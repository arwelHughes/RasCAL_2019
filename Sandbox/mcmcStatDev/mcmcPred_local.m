function out = mcmcPred_local(problem,results,chain,s2chain)

data = problem.data;

parind = results.parind;
local  = results.local;
theta  = results.theta;
nsimu  = size(chain,1);
nbatch = results.nbatch;

fitpars = problem.fitpars;
parind = ones(1,length(fitpars));

if isempty(s2chain)
  lims = [0.005,0.025,0.05,0.25,0.5,0.75,0.95,0.975,0.995];
else
  lims = [0.025,0.5,0.975];
end

nsample = 500;
if nsample ==  size(chain,1)
  isample = 1:size(chain,1); % sample whole chain
else
  % random sample from the chain
  isample = ceil(rand(nsample,1)*nsimu);
end

nbatch = problem.numberOfContrasts;


for i=1:nbatch
    
    datai = data{i};
    for iisample = 1:nsample;
        theta(parind) = chain(isample(iisample),:)';
        th  = theta(local==0|local==i);
        
        %y   = feval(modelfun,datai,th,varargin{:});
        y = MCMC_Intrafun(th,i);
        ysave(iisample,:,:) = y;
        
        if ~isempty(s2chain)
            osave(iisample,:,:) = ...
                y + randn(size(y))*diag(sqrt(s2chain(isample(iisample),:)));
        end
    end
end

out = [];

[my,ny] = size(y);
  for j=1:ny
    if 0& nbatch == 1 & ny == 1
      plim = plims(ysave(:,:,j),lims);
    elseif 0&nbatch == 1      
      plim{j} = plims(ysave(:,:,j),lims);
    else
      plim{i}{j} = plims(ysave(:,:,j),lims);
    end
    if ~isempty(s2chain)
      olim{i}{j} = plims(osave(:,:,j),lims);
    end
  end


out.predlims = plim;
if ~isempty(s2chain)
  out.obslims = olim;
else
  out.obslims = [];  
end
out.data = data;

end

function outCurve = MCMC_Intrafun(pars,contrast)

problem = getappdata(0,'problem');

%First calculate chisquared
problem.fitpars = pars;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');
%ss = problem.calculations.sum_chi;
outCurve = problem.calculations.Simulation{contrast};

end

    