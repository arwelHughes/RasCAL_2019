function problem = rascal_cmaes(problem,fitopts);

%CMAES Optimisation strategy modified for Rascal.

%Initial Parameters......
problem = scalePars(problem);
xstart = problem.fitpars(:);
lbounds = zeros(length(xstart),1);
ubounds = ones(length(xstart),1);


%lbounds = problem.fitconstr(:,1);
%ubounds = problem.fitconstr(:,2);


% ------------------------ Initialization -------------------------------

%General options
stopFitness = fitopts.cmaes.TargetChi; 
stopMaxFunEvals = fitopts.cmaes.MaxFunEval;  
stopMaxIter = problem.maxiter;  
stopFunEvals = 1e10;  
stopIter = problem.maxiter;  
stopTolX = fitopts.cmaes.StopTolX;
stopTolUpX = 1e8;
stopTolFun = fitopts.cmaes.StopTolFun;
stopOnWarnings = 'no'; 
flgWarnOnEqualFunctionValues = 'off';
flgdisplay = 'on';
flgplotting = 'on';
verbosemodulo = '1';
flgscience = 'off';
flgsaving = 'off';
savemodulo = 2;
savetime = 25;
popsize = fitopts.cmaes.PopSize;
maxdx = fitopts.cmaes.Maxdp; % maximal sensible variable change
mindx = fitopts.cmaes.Mindp; % minimal sensible variable change

%Fitting Strategy options....
ParentNumber = floor(popsize / 2);
RecombinationWeights = (fitopts.cmaes.RecombW + 1); % 1 ='superlinear decrease', 2 = 'linear', 3 = 'equal';

xmean = xstart;
N = size(xmean, 1); 
numberofvariables = N; 
lambda = popsize;
insigma = 0.3 .* (ubounds - lbounds);

%More initial checking....
if any(lbounds>=ubounds)
	error('upper bound must be greater than lower bound');
end


  % Check all vector sizes
  if size(xmean, 2) > 1 | size(xmean,1) ~= N
    error(['intial search point should be a column vector of size ' ...
	   num2str(N)]);
  elseif ~(all(size(insigma) == [1 1]) | all(size(insigma) == [N 1]))
    error(['input parameter SIGMA should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(stopTolX, 2) > 1 | ~ismember(size(stopTolX, 1), [1 N])
    error(['option TolX should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(stopTolUpX, 2) > 1 | ~ismember(size(stopTolUpX, 1), [1 N])
    error(['option TolUpX should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(maxdx, 2) > 1 | ~ismember(size(maxdx, 1), [1 N])
    error(['option DiffMaxChange should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(mindx, 2) > 1 | ~ismember(size(mindx, 1), [1 N])
    error(['option DiffMinChange should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(lbounds, 2) > 1 | ~ismember(size(lbounds, 1), [1 N])
    error(['option lbounds should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  elseif size(ubounds, 2) > 1 | ~ismember(size(ubounds, 1), [1 N])
    error(['option ubounds should be (or eval to) a scalar '...
	   'or a column vector of size ' num2str(N)] );
  end
  
% Strategy internal parameter setting: Selection  
lambda = popsize;  
mu = floor(popsize/2); % number of parents/points for recombination
if RecombinationWeights ==  3
    weights = ones(mu,1); % (mu_I,lambda)-CMA-ES
elseif RecombinationWeights == 2
    weights = mu+1-(1:mu)';
elseif RecombinationWeights == 1
    weights = log(mu+1)-log(1:mu)'; % muXone array for weighted recombination
end

mueff=sum(weights)^2/sum(weights.^2); % variance-effective size of mu

if mueff == lambda
   error(['Combination of values for PopSize, ParentNumber and ' ...
	 ' and RecombinationWeights is not reasonable']);
end
  
% Strategy internal parameter setting: Adaptation
cc = 4/(N+4);                                                   % time constant for cumulation for covariance matrix
cs = (mueff+2)/(N+mueff+3);                                     % t-const for cumulation for step size control
mucov = mueff;                                                  % size of mu used for calculating learning rate ccov
ccov = (1/mucov) * 2/(N+1.41)^2 ...                             % learning rate for covariance matrix
	 + (1-1/mucov) * min(1,(2*mueff-1)/((N+2)^2+mueff)); 
                                                                % ||ps|| is close to sqrt(mueff/N) for mueff large on linear fitness
damps = ...                                                     % damping for step size control, usually close to one 
      (1 + 2*max(0,sqrt((mueff-1)/(N+1))-1)) ...                % limit sigma increase
      * max(0.3, ...                                            % reduce damps, if max. iteration number is small
	  1 - N/min(stopMaxIter,stopMaxFunEvals/lambda)) + cs; 

% Initialize dynamic internal strategy parameters
if any(insigma <= 0) 
    error(['Initial search volume (SIGMA) must be greater than zero']);
end

if max(insigma)/min(insigma) > 1e12
    error(['Initial search volume (SIGMA) badly conditioned']);
end

  sigma = max(insigma);              % overall standard deviation
  pc = zeros(N,1); ps = zeros(N,1);  % evolution paths for C and sigma
  if length(insigma) == 1
    insigma = insigma * ones(N,1) ;
  end
  B = eye(N);                        % B defines the coordinate system
  D = diag(insigma/max(insigma));    % diagonal matrix D defines the scaling
  BD = B*D;                          % for speed up only
  C = BD*(BD)';                      % covariance matrix
  fitness.hist=NaN*ones(1,10+ceil(3*10*N/lambda)); % history of fitness values
  fitness.histsel=NaN*ones(1,10+ceil(3*10*N/lambda)); % history of fitness values

  % Initialize boundary handling
  bnd.isactive = any(lbounds > -Inf) | any(ubounds < Inf); 
  if bnd.isactive
    if any(lbounds>ubounds)
      error('lower bound found to be greater than upper bound');
    end
    [xmean ti] = xintobounds(xmean, lbounds, ubounds); % just in case
    if any(ti)
      warning('Initial point was out of bounds, corrected');
    end
    bnd.weights = zeros(N,1);         % weights for bound penalty
    bnd.scale = diag(C)/mean(diag(C));
    bnd.isbounded = (lbounds > -Inf) | (ubounds < Inf);
    if length(bnd.isbounded) == 1
      bnd.isbounded = bnd.isbounded * ones(N,1);
    end
    maxdx = min(maxdx, (ubounds - lbounds)/2);
    if any(sigma*sqrt(diag(C)) > maxdx)
      fac = min(maxdx ./ sqrt(diag(C)))/sigma;
      sigma = min(maxdx ./ sqrt(diag(C)));
      warning(['Initial SIGMA multiplied by the factor ' num2str(fac) ...
	       ', because it was larger than half' ...
	       ' of one of the boundary intervals']);
    end
    idx = (lbounds > -Inf) & (ubounds < Inf);
    dd = diag(C);
    if any(5*sigma*sqrt(dd(idx)) < ubounds(idx) - lbounds(idx))
      warning(['Initial SIGMA is, in at least one coordinate, ' ...
	       'much smaller than the '...
	       'given boundary intervals. For reasonable ' ...
	       'global search performance SIGMA should be ' ...
	       'between 0.2 and 0.5 of the bounded interval in ' ...
	       'each coordinate. If all coordinates have ' ... 
	       'lower and upper bounds SIGMA can be empty']);
    end
    bnd.dfithist = 1;              % delta fit for setting weights
    bnd.aridxpoints = [];          % remember complete outside points
    bnd.arfitness = [];            % and their fitness
    bnd.validfitval = 0;
    bnd.iniphase = 1;
  end

  % ooo initial feval, for output only, (un-)comment if required
  counteval = 0;
  problem.fitpars = xmean;
  
  
  problem = fitcalc(problem);
  
  fitness.hist(1)=problem.calculations.sum_chi; 
  fitness.histsel(1)=fitness.hist(1);
  counteval = counteval + 1;
                                         
  % Initialize further constants
  randn('state', sum(100*clock));     % random number generator state
  startseed = randn('state');         % for saving purpose
  chiN=N^0.5*(1-1/(4*N)+1/(21*N^2));  % expectation of 
				      %   ||N(0,I)|| == norm(randn(N,1))
  weights = weights/sum(weights);     % normalize recombination weights array
  
  % Initialize records and output
  time.t0 = clock;
  outhist = [0 fitness.hist(1) max(diag(D))/min(diag(D)) ...
	     sigma*sqrt(max(diag(C))) ...
	     sigma*sqrt(min(diag(C))) sqrt(max(diag(C)))];
  outt0=clock; outetime=0; 
  out.x = 0;                   
  out.y1=[fitness.hist(1) sigma max(diag(D))/min(diag(D)) ...
	  sigma*[max(diag(D)) min(diag(D))]];
  out.y2=xmean'; out.y2a=xmean';
  out.y3=sigma*sqrt(diag(C))';
  out.y4=sort(diag(D))'; 
  outiter = 0;

  countiter = 0;

clc; addInfoText('Running Covariance Matrix Adapted Evolution Strategy');

% -------------------- Generation Loop --------------------------------
stopflag = {};
while isempty(stopflag)
  countiter = countiter + 1; 
  
  % Generate and evaluate lambda offspring
 
  for k=1:lambda,
    fitness.raw(k) = NaN; tries = 0;
    % Resample, until fitness is not NaN
    while isnan(fitness.raw(k))
      arz(:,k) = randn(N,1);
      arx(:,k) = xmean + sigma * (BD * arz(:,k));                % Eq. (1)

      % You may handle constraints here. You may either resample
      % arz(:,k) and/or multiply it with a factor between -1 and 1
      % (the latter will decrease the overall step size) and
      % recalculate arx accordingly. Do not change arx or arz in any
      % other way.
 
      if ~bnd.isactive
        arxvalid(:,k) = arx(:,k);
      else
        arxvalid(:,k) = xintobounds(arx(:,k), lbounds, ubounds);
      end
      % You may handle constraints here.  You may copy and alter
      % (columns of) arxvalid(:,k) only for the evaluation of the
      % fitness function. arx and arxvalid should not be changed.
      %fitness.raw(k) = feval(fitfun, arxvalid(:,k), varargin{:});
      
        problem.fitpars = arxvalid(:,k);
        problem = fitcalc(problem);
        %problem = reflectivity_calculation(problem);
        fitness.raw(k)=problem.calculations.sum_chi;
      
      
      tries = tries + 1;
      if mod(tries, 10*lambda) == 0
	warning(['Many NaN objective function values at evaluation ' ...
		num2str(counteval)]);
      end
    end
    % NaN are not counted
    counteval = counteval + 1;
  end

  fitness.sel = fitness.raw; 

  % ----- handle boundaries -----
  if 1 < 3 & bnd.isactive
    % Get delta fitness values
    val = myprctile(fitness.raw, [25 75]);
    val = (val(2) - val(1)) / N / mean(diag(C)) / sigma^2;
    %val = (myprctile(fitness.raw, 75) - myprctile(fitness.raw, 25)) ...
    %    / N / mean(diag(C)) / sigma^2;
    % Catch non-sensible values 
    if ~isfinite(val)
      warning('Non-finite fitness range');
      val = max(bnd.dfithist);  
    elseif val == 0 % happens if all points are out of bounds
      val = min(bnd.dfithist(bnd.dfithist>0)); 
    elseif bnd.validfitval == 0 % first sensible val
      bnd.dfithist = [];
      bnd.validfitval = 1;
    end

    % Keep delta fitness values
    if length(bnd.dfithist) < 20+(3*N)/lambda
      bnd.dfithist = [bnd.dfithist val];
    else
      bnd.dfithist = [bnd.dfithist(2:end) val];
    end

    % Scale weights anew, bias scaling to unity
    if 1 < 3
      bnd.weights = bnd.scale .* bnd.weights;  % reset scaling
      bnd.scale = exp(0.1*mean(log(diag(C)))) * diag(C).^0.9;
      bnd.scale = bnd.scale / exp(mean(log(bnd.scale))); % prod is 1 initially
      bnd.weights = bnd.weights ./ bnd.scale; 
    end
    [tx ti]  = xintobounds(xmean, lbounds, ubounds);

    % Set initial weights
    if bnd.iniphase 
      if any(ti) 
        bnd.weights(find(bnd.isbounded)) = ...
          2.0002 * median(bnd.dfithist) ./ bnd.scale(find(bnd.isbounded));
	if bnd.validfitval & countiter > 2
          bnd.iniphase = 0;
        end
      end
    end

    % Increase/decrease weights
    if  1 < 3 & any(ti) % any coordinate of xmean out of bounds
      % judge distance of xmean to boundary
      tx = xmean - tx;
      idx = (ti ~= 0 & abs(tx) > 3*max(1,sqrt(N)/mueff) ... 
	     * sigma*sqrt(diag(C))) ;
      if ~isempty(idx) % increase
	bnd.weights(idx) = 1.1^(max(1, mueff/10/N)) * bnd.weights(idx); 
      end
    end

    % Assigned penalized fitness
    bnd.arpenalty = bnd.weights' * (arxvalid - arx).^2; 
    fitness.sel = fitness.raw + bnd.arpenalty;

  end % handle boundaries
  % ----- end handle boundaries -----
  
  % Sort by fitness 
  [fitness.raw, fitness.idx] = sort(fitness.raw);  
  [fitness.sel, fitness.idxsel] = sort(fitness.sel);   % minimization
  fitness.hist(2:end) = fitness.hist(1:end-1);    % record short history of
  fitness.hist(1) = fitness.raw(1);               % best fitness values
  fitness.histsel(2:end) = fitness.histsel(1:end-1);    % record short history of
  fitness.histsel(1) = fitness.sel(1);               % best fitness values

  % Calculate new xmean, this is selection and recombination 
  xold = xmean; % for speed up of Eq. (2) and (3)
  xmean = arx(:,fitness.idxsel(1:mu))*weights; 
  zmean = arz(:,fitness.idxsel(1:mu))*weights;%==D^-1*B'*(xmean-xold)/sigma
  % fmean = feval(fitfun, xintobounds(xmean, lbounds, ubounds), varargin{:});
  % counteval = counteval + 1;
  
  % Cumulation: update evolution paths
  ps = (1-cs)*ps + (sqrt(cs*(2-cs)*mueff)) * (B*zmean);          % Eq. (4)
  hsig = norm(ps)/sqrt(1-(1-cs)^(2*countiter))/chiN < 1.5 + 1/(N-0.5);
  pc = (1-cc)*pc ...
        + hsig*(sqrt(cc*(2-cc)*mueff)/sigma) * (xmean-xold);     % Eq. (2)
  if hsig == 0
    %disp([num2str(countiter) ' ' num2str(counteval) ' pc update stalled']);
  end

  % Adapt covariance matrix
  if ccov > 0                                                    % Eq. (3)
    C = (1-ccov+(1-hsig)*ccov*cc*(2-cc)/mucov) * C ... % regard old matrix 
        + ccov * (1/mucov) * pc*pc' ...                % plus rank one update
        + ccov * (1-1/mucov) ...                       % plus rank mu update
          * sigma^-2 * (arx(:,fitness.idxsel(1:mu))-repmat(xold,1,mu)) ...
          * diag(weights) * (arx(:,fitness.idxsel(1:mu))-repmat(xold,1,mu))';
  end
  
  if 1 < 2 & ~flgscience 
    % remove momentum in ps, if ps is large and fitness is getting worse.
    % this should rarely happen. 
    % this might be questionable in dynamic environments
    if sum(ps.^2)/N > 1.5 + 10*(2/N)^.5 & ...
        fitness.histsel(1) > max(fitness.histsel(2:3))
      ps = ps * sqrt(N*(1+max(0,log(sum(ps.^2)/N))) / sum(ps.^2));
      if flgdisplay
        disp(['Momentum in ps removed at [niter neval]=' ...
              num2str([countiter counteval]) ']']);
      end
    end
  end

  % Adapt sigma
  sigma = sigma * exp((norm(ps)/chiN - 1)*cs/damps);             % Eq. (5)

  % Update B and D from C
  if ccov > 0 & mod(countiter, 1/ccov/N/10) < 1
    C=triu(C)+triu(C,1)'; % enforce symmetry
    [B,D] = eig(C);       % eigen decomposition, B==normalized eigenvectors
    % limit condition of C to 1e14 + 1
    if min(diag(D)) <= 0
	if stopOnWarnings
	  stopflag(end+1) = {'warnconditioncov'};
	else
	  warning(['Iteration ' num2str(countiter) ...
		   ': Eigenvalue (smaller) zero']);
	  D(D<0) = 0;
	  tmp = max(diag(D))/1e14;
	  C = C + tmp*eye(N); D = D + tmp*eye(N); 
	end
    end
    if max(diag(D)) > 1e19*min(diag(D)) 
	if stopOnWarnings
	  stopflag(end+1) = {'warnconditioncov'};
	else
	  warning(['Iteration ' num2str(countiter) ': condition of C ' ...
		   'at upper limit' ]);
	  tmp = max(diag(D))/1e14 - min(diag(D));
	  C = C + tmp*eye(N); D = D + tmp*eye(N); 
	end
    end
    D = diag(sqrt(diag(D))); % D contains standard deviations now
    % D = D / prod(diag(D))^(1/N);  C = C / prod(diag(D))^(2/N);
    BD = B*D; % for speed up only
  end % if mod

  % ----- numerical error management -----
  % Adjust maximal coordinate axis deviations
  if any(sigma*sqrt(diag(C)) > maxdx)
    sigma = min(maxdx ./ sqrt(diag(C)));
    %warning(['Iteration ' num2str(countiter) ': coordinate axis std ' ...
    %         'deviation at upper limit of ' num2str(maxdx)]);
    % stopflag(end+1) = {'maxcoorddev'};
  end
  % Adjust minimal coordinate axis deviations
  while any(sigma*sqrt(diag(C)) < mindx)
    sigma = max(mindx ./ sqrt(diag(C))) * exp(0.05+cs/damps); 
    %warning(['Iteration ' num2str(countiter) ': coordinate axis std ' ...
    %         'deviation at lower limit of ' num2str(mindx)]);
    % stopflag(end+1) = {'mincoorddev'};;
  end
  % Adjust too low coordinate axis deviations
  if any(xmean == xmean + 0.2*sigma*sqrt(diag(C))) 
    if stopOnWarnings
	stopflag(end+1) = {'warnnoeffectcoord'};
    else
      warning(['Iteration ' num2str(countiter) ': coordinate axis std ' ...
	       'deviation too low' ]);
	C = C + ccov * diag(diag(C) .* ...
			    (xmean == xmean + 0.2*sigma*sqrt(diag(C))));
	sigma = sigma * exp(0.05+cs/damps); 
    end
  end
  % Adjust step size in case of (numerical) precision problem 
  if all(xmean == xmean ...
	    + 0.1*sigma*BD(:,1+floor(mod(countiter,N))))
    i = 1+floor(mod(countiter,N));
    if stopOnWarnings
	stopflag(end+1) = {'warnnoeffectaxis'};
    else
      warning(['Iteration ' num2str(countiter) ...
	       ': main axis standard deviation ' ...
	       num2str(sigma*D(i,i)) ' has no effect' ]);
	sigma = sigma * exp(0.2+cs/damps); 
    end
  end
  % Adjust step size in case of equal function values (flat fitness)
  if fitness.sel(1) == fitness.sel(1+ceil(0.1+lambda/4))
    if flgWarnOnEqualFunctionValues & stopOnWarnings
	stopflag(end+1) = {'warnequalfunvals'};
    else
      if flgWarnOnEqualFunctionValues
	warning(['Iteration ' num2str(countiter) ...
		 ': equal function values f=' num2str(fitness.sel(1)) ...
		 ' at maximal main axis sigma ' ...
		 num2str(sigma*max(diag(D)))]);
      end
      sigma = sigma * exp(0.2+cs/damps); 
    end
  end
  % Adjust step size in case of equal function values
  if countiter > 2 & myrange([fitness.hist fitness.sel(1)]) == 0  
    if stopOnWarnings
	stopflag(end+1) = {'warnequalfunvalhist'};
    else
      warning(['Iteration ' num2str(countiter) ...
	       ': equal function values in history at maximal main ' ...
	       'axis sigma ' num2str(sigma*max(diag(D)))]);
	sigma = sigma * exp(0.2+cs/damps); 
    end
  end
  % Align scales of sigma and C for nicer output
  if 11 < 2 & (sigma > 1e10*max(diag(D)) | 1e10*sigma < min(diag(D)))
    fac = sqrt(sigma/median(diag(D)));
    sigma = sigma/fac;
    pc = fac * pc;
    C = fac^2 * C;
    D = fac * D;
    BD = fac * BD;
  end
    
  % ----- end numerical error management -----
  
  % Keep overall best solution
  if countiter == 1
    if fitness.hist(2) < fitness.hist(1)
	bestever.x = xold;
	bestever.f = fitness.hist(2);
	bestever.counteval = 1;
    else
	bestever.x = arxvalid(:, fitness.idx(1));
	bestever.f = fitness.hist(1);
	bestever.counteval = counteval + fitness.idx(1) - lambda;
    end
  elseif fitness.hist(1) < bestever.f
    bestever.x = arxvalid(:, fitness.idx(1));
    bestever.f = fitness.hist(1);
    bestever.counteval = counteval + fitness.idx(1) - lambda;
  end

  % Set stop flag
  if fitness.raw(1) <= stopFitness stopflag(end+1) = {'fitness lower than target'}; end
  if counteval >= stopMaxFunEvals stopflag(end+1) = {'maximum function evals exceeded'}; end
  if countiter >= stopMaxIter stopflag(end+1) = {'maximum number of iterations ecxeeded'}; end
  if all(sigma*(max(abs(pc), sqrt(diag(C)))) < stopTolX) 
    stopflag(end+1) = {'tolx reached'};
  end
  if any(sigma*sqrt(diag(C)) > stopTolUpX) 
    stopflag(end+1) = {'tolupx'};
  end
  if sigma*max(D) == 0  % should never happen
    stopflag(end+1) = {'bug'};
  end
  if countiter > 2 & myrange([fitness.sel fitness.hist]) < stopTolFun 
    stopflag(end+1) = {'tolfun'};
  end
  if counteval >= stopFunEvals | countiter >= stopIter
    stopflag(end+1) = {'stoptoresume'};
    if length(stopflag) == 1 & flgsaving == 0
      error('To resume later the saving option needs to be set');
    end
  end

  % ----- output generation -----
  if verbosemodulo > 0 & isfinite(verbosemodulo)
    if countiter == 1 | mod(countiter, 10*verbosemodulo) < 1 
      addInfoText(['Iterat, #Fevals:   Function Value    (median,worst) ' ...
	    '|Axis Ratio|' ...
	    'idx:Min SD idx:Max SD']); 
    end
    if mod(countiter, verbosemodulo) < 1 ...
	  | (countiter < 3 & verbosemodulo > 0 & isfinite(verbosemodulo))
      [minstd minstdidx] = min(sigma*sqrt(diag(C)));
      [maxstd maxstdidx] = max(sigma*sqrt(diag(C)));
      % format display nicely
      addInfoText([repmat(' ',1,4-floor(log10(countiter))) ...
	    num2str(countiter) ' , ' ...
	    repmat(' ',1,5-floor(log10(counteval))) ...
	    num2str(counteval) ' : ' ...
            num2str(fitness.hist(1), '%.13e') ...
	    ' +(' num2str(median(fitness.raw)-fitness.hist(1), '%.0e ') ...
	    ',' num2str(max(fitness.raw)-fitness.hist(1), '%.0e ') ...
	    ') | ' ...
	    num2str(max(diag(D))/min(diag(D)), '%4.2e') ' | ' ...
	    repmat(' ',1,1-floor(log10(minstdidx))) num2str(minstdidx) ':' ...
	    num2str(minstd, ' %.1e') ' ' ...
	    repmat(' ',1,1-floor(log10(maxstdidx))) num2str(maxstdidx) ':' ...
	    num2str(maxstd, ' %.1e')]);
    end
  end

  % measure time for recording data
  if countiter < 3
    time.c = 0.5;
    time.nonoutput = 0;
    time.recording = 0;
    time.saving  = 0.5; % first saving after 10 seconds
    time.plotting = 0;
  else
    time.c = min(1, time.nonoutput/3 + 1e-9); % set backward horizon
    time.c = max(1e-5, 1/countiter); % mean over all or 1e-5
  end
  % get average time per iteration
  time.t1 = clock;
  time.act = max(0,etime(time.t1, time.t0));
  time.nonoutput = (1-time.c) * time.nonoutput ...
      + time.c * time.act; 

  time.recording = (1-time.c) * time.recording;
  time.saving  = (1-time.c) * time.saving;
  time.plotting = (1-time.c) * time.plotting;
  
  % record output data, concerning time issues
  if countiter < 1e2 | ~isempty(stopflag) | ...
	countiter >= outiter + savemodulo
    outiter = countiter; 
      % Compose output argument No 5
      outhist = [outhist; [counteval fitness.hist(1) ...
		    max(diag(D))/min(diag(D)) ...
		    sigma*sqrt(max(diag(C))) sigma*sqrt(min(diag(C))) ...
		    sqrt(max(diag(C)))]];

    if (flgsaving | flgplotting)
      out.x = [out.x counteval];
      out.y1 = [out.y1; [fitness.raw(1) sigma max(diag(D))/min(diag(D))] ...
                sigma*[max(diag(D)) min(diag(D))]];
      out.y2 = [out.y2; xmean'];
      out.y2a = [out.y2a; (arx(:,fitness.idx(1)))'];
      %out.y2 = [out.y2; (arxvalid(:,fitness.idx(1)))'];
      %out.y2a = [out.y2a; xmean'];
      out.y3 = [out.y3; sigma*sqrt(diag(C))'];
      out.y4 = [out.y4; sort(diag(D))']; 
    end % end flgsaving or flgplotting
    
    % get average time for recording data
    time.t2 = clock;
    time.recording = time.recording + time.c * max(0,etime(time.t2, time.t1)); 
    
    if flgplotting & countiter > 2
      if ~isempty(stopflag) | ...
	  time.plotting < 0.2 * time.nonoutput
    problem.fitpars = bestever.x;
    problem = fitcalc(problem);
    %problem = reflectivity_calculation(problem);
    setappdata(0,'problem',problem);
    rJavaUpdatePlots()
    stop = getStopFlag();
    if stop
        stopflag(end+1) = {'user interrupt'};
    end
	time.plotting = time.plotting + time.c * max(0,etime(clock, time.t2)); 
      end
    end
    if countiter > 100 & ...
	  time.recording > savetime * (time.nonoutput+time.recording) / 100
      savemodulo = savemodulo + 1;
      % disp('++savemodulo'); %qqq
    end
  end % if output

  % ----- end output generation -----

  
  
end % while, end generation loop

% -------------------- Final Procedures -------------------------------

% Evaluate xmean and return best recent point in xmin
fmin = fitness.raw(1);
xmin = arxvalid(:, fitness.idx(1)); % Return best point of last generation.
if length(stopflag) > sum(strcmp(stopflag, 'stoptoresume')) % final stopping
      problem.fitpars = xmin;
  problem = fitcalc(problem);
  %problem = reflectivity_calculation(problem);
  fmean = problem.calculations.sum_chi;
  counteval = counteval + 1;
  if fmean < fitness.raw(1)
    fmin = fmean;
    xmin = xintobounds(xmean, lbounds, ubounds); % Return xmean as best point
  end
end


  %Update the table....
problem.fitpars = bestever.x;
problem = unscalePars(problem);
%   problem.constr = [lbounds(:) ubounds];

%   params_fig;

%problem = fitfinish(problem);
setappdata(0,'problem',problem);

addInfoText(sprintf('Final value = %6.4f \n',fmin));
disp(stopflag);

% ---------------------------------------------------------------  
% ---------------------------------------------------------------  
function problem = fitcalc(problem)
  
problem = unscalePars(problem);
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');
problem = scalePars(problem);

  
  %---------------------------------------------------------------


function [x, idx] = xintobounds(x, lbounds, ubounds)
  if ~isempty(lbounds)
    idx = x < lbounds;
    if length(lbounds) == 1
      x(idx) = lbounds;
    else
      x(idx) = lbounds(idx);
    end
  end
  if ~isempty(ubounds)
    idx2 = x > ubounds;
    if length(ubounds) == 1
      x(idx2) = ubounds;
    else
      x(idx2) = ubounds(idx2);
    end
  end
  idx = idx2-idx;
  
% ---------------------------------------------------------------  
% ---------------------------------------------------------------  
function res=myeval(s)
  if ischar(s)
    res = evalin('caller', s);
  else
    res = s;
  end
  

% ---------------------------------------------------------------  
% ---------------------------------------------------------------  
% ----- replacements for statistic toolbox functions ------------
% ---------------------------------------------------------------  
% ---------------------------------------------------------------  
function res=myrange(x)
  res = max(x) - min(x);
  
% ---------------------------------------------------------------  
% ---------------------------------------------------------------  
function res = myprctile(inar, perc, idx)
%
% Computes the percentiles in vector perc from vector inar
% returns vector with length(res)==length(perc)
% idx: optional index-array indicating sorted order
%

N = length(inar);
flgtranspose = 0;

% sizes 
if size(perc,1) > 1
  perc = perc';
  flgtranspose = 1;
  if size(perc,1) > 1
    error('perc must not be a matrix');
  end
end
if size(inar, 1) > 1 & size(inar,2) > 1
  error('data inar must not be a matrix');
end
 
% sort inar
if nargin < 3 | isempty(idx)
  [sar idx] = sort(inar);
else
  sar = inar(idx);
end

res = [];
for p = perc
  if p <= 100*(0.5/N)
    res(end+1) = sar(1);
  elseif p >= 100*((N-0.5)/N)
    res(end+1) = sar(N);
  else
    % find largest index smaller than required percentile
    availablepercentiles = 100*((1:N)-0.5)/N;
    i = max(find(p > availablepercentiles));
    % interpolate linearly
    res(end+1) = sar(i) ...
	+ (sar(i+1)-sar(i))*(p - availablepercentiles(i)) ...
	/ (availablepercentiles(i+1) - availablepercentiles(i));

  end
end

if flgtranspose
  res = res';
end



