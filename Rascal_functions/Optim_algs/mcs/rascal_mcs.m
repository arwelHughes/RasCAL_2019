%function [x,fval,exitflag,output]=fminsearchbnd(fun,x0,LB,UB,options,varargin)

function problem = rascal_mcs(problem);

persistent iterCount;

iterCount = 0;

options = optimset('MaxIter',problem.maxiter,'TolFun',1e-7);

problem = scalePars(problem);

x0 = problem.fitpars;
LB = zeros(length(problem.fitconstr(:,1)),1);
UB = ones(length(problem.fitconstr(:,1)),1);

% stuff into a struct to pass around
params.args = [];%varargin;
params.LB = LB;
params.UB = UB;
params.fun = problem.module.name;

% now we can call fminsearch, but with our own
% intra-objective function.
n = length(LB);
prt = 1;
smax = 10*n+10;
nf = 1e4*n^2;
stop(1) = 50*n;
stop(2) = -inf;
iinit = 2;
local = 100;
gamma = eps^2;
hess = ones(n,n);



[xu,fval,exitflag,output] = mcs(@intrafun,problem,LB,UB,prt,smax,nf,stop,iinit,local,gamma,hess);


% ======================================
% ========= begin subfunctions =========
% ======================================
function fval = intrafun(problem,x);
% transform variables, then call original function

%problem = getappdata(0,'problem');


iterCount = iterCount + 1;

%Unpck the params..
problem.fitpars = x;
problem = unscalePars(problem);
problem = unpackparams(problem);

% and call fun
%problem = feval(params.fun,problem,params.args{:});
setappdata(0,'problem',problem);
reflectivity_calculation();
%rsafeCalcAndPlot()
problem = getappdata(0,'problem');
if (rem(iterCount,10) == 0)    
    rJavaUpdatePlots();    
end
fval = problem.calculations.sum_chi;
if (isnan(fval) | isinf(fval))
    addInfoText('Problem with func val here!');
end


end
% ======================================

problem.fitpars = xu;
problem = unscalePars(problem);

end