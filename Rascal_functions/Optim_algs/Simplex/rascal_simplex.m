%function [x,fval,exitflag,output]=fminsearchbnd(fun,x0,LB,UB,options,varargin)

function problem = rascal_simplex(problem);


fittingOptions = getappdata(0,'fittingOptions');
theseOpts = fittingOptions.simplex;

options = optimset('MaxIter',problem.maxiter,'TolFun',theseOpts.stopFunTol,'TolX',theseOpts.stopTolParam,'MaxFunEvals',theseOpts.MaxFunEvals);

x0 = problem.fitpars;
LB = problem.fitconstr(:,1);
UB = problem.fitconstr(:,2);

% size checks
xsize = size(x0);
x0 = x0(:);
n=length(x0);

if isempty(LB)
  LB = repmat(-inf,n,1);
else
  LB = LB(:);
end
if isempty(UB)
  UB = repmat(inf,n,1);
else
  UB = UB(:);
end



% stuff into a struct to pass around
params.args = [];%varargin;
params.LB = LB;
params.UB = UB;
params.fun = problem.module.name;%fun;

% 0 --> unconstrained variable
% 1 --> lower bound only
% 2 --> upper bound only
% 3 --> dual finite bounds
params.BoundClass = zeros(n,1);
for i=1:n
  k = isfinite(LB(i)) + 2*isfinite(UB(i));
  params.BoundClass(i) = k;
  if (k==3) & (LB(i)==UB(i))
    error 'Bounds must be distinct if both are supplied.'
  end
end

% transform starting values into their unconstrained
% surrogates. Check for infeasible starting guesses.
x0u = x0;
for i = 1:n
  switch params.BoundClass(i)
    case 1
      % lower bound only
      if x0(i)<=LB(i)
        % infeasible starting value. Use bound.
        x0u(i) = 0;
      else
        x0u(i) = sqrt(x0(i) - LB(i));
      end
    case 2
      % upper bound only
      if x0(i)>=UB(i)
        % infeasible starting value. use bound.
        x0u(i) = 0;
      else
        x0u(i) = sqrt(UB(i) - x0(i));
      end
    case 3
      % lower and upper bounds
      if x0(i)<=LB(i)
        % infeasible starting value
        x0u(i) = -pi/2;
      elseif x0(i)>=UB(i)
        % infeasible starting value
        x0u(i) = pi/2;
      else
        x0u(i) = 2*(x0(i) - LB(i))/(UB(i)-LB(i)) - 1;
        x0u(i) = asin(max(-1,min(1,x0u(i))));
      end
    case 0
      % unconstrained variable. x0u(i) is set.
  end
end

% now we can call fminsearch, but with our own
% intra-objective function.
[xu,fval,exitflag,output] = rfminsearch(@intrafun,x0u,problem,options,params,300);

% undo the variable transformations into the original space
x = xtransform(xu,params);

% final reshape
x = reshape(x,xsize);

problem.fitpars = x;


% ======================================
% ========= begin subfunctions =========
% ======================================
function fval = intrafun(x,problem,itercount,params,update);
% transform variables, then call original function

% transform
xtrans = xtransform(x,params);

%Unpck the params..
problem.fitpars = xtrans;
problem = unpackparams(problem);

% and call fun
%problem = feval(params.fun,problem,params.args{:});
%setappdata(0,'problem',problem);
problem = reflectivity_calculation(problem);
%problem = getappdata(0,'problem');
if  rem(itercount,update) == 0
    problem.calcSLD = 1;
    problem = reflectivity_calculation(problem);
    setappdata(0,'problem',problem);    
    rJavaUpdatePlots();
    problem.calcSLD = 0;
    setappdata(0,'problem',problem);    
    if problem.update_params == 1;
        update_params();
    end
end
fval = problem.calculations.sum_chi;

% ======================================
function xtrans = xtransform(x,params);
% converts unconstrained variables into their original domains

xtrans = x;
for i = 1:length(x)
  switch params.BoundClass(i)
    case 1
      % lower bound only
      xtrans(i) = params.LB(i) + x(i).^2;
    case 2
      % upper bound only
      xtrans(i) = params.UB(i) - x(i).^2;
    case 3
      % lower and upper bounds
      xtrans(i) = (sin(x(i))+1)/2;
      xtrans(i) = xtrans(i)*(params.UB(i) - params.LB(i)) + params.LB(i);
    case 0
      % unconstrained variable. xtrans(i) is set.
  end
end
