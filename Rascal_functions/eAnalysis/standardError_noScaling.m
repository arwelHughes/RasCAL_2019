function [err,cov,cM,hess] = standardError_noScaling()

% First load in problem
problem = getappdata(0,'problem');

problem.calcSLD = 0;

% Make sure it's taking account of which fitting parameters are selected
problem = packparams(problem);

% Save stuff for the intrafun
originalPars = problem.fitpars;
x0 = originalPars;
LB = problem.fitconstr(:,1);
UB = problem.fitconstr(:,2);

% stuff into a struct to pass around
params.args = [];%varargin;
params.LB = LB;
params.UB = UB;
params.fun = problem.module.name;%fun;

% Save things for the intrafun
stdErrPars.problem = problem;
stdErrPars.params = params;
setappdata(0,'stdErrPars',stdErrPars);

chisq = intrafun(x0);

addInfoText('Calculating Hessian...');
[hess,err] = hessian_test(@intrafun,x0);

% disp(hess);

hess = abs(hess);

addInfoText('Calculating Covariance Matrix...');
cov = inv(hess);

addInfoText('Calculating Correlation Matrix...');
for i = 1:length(originalPars)
    for j = 1:length(originalPars)
        cM(i,j) = cov(i,j) / sqrt(cov(i,i)*cov(j,j));
    end
end

cM = abs(cM);
e1 = diag(cov);
err = sqrt(abs(e1));
err = abs(err);

end


function fval = intrafun(x0)


% Get the necessary parameters
stdErrPars = getappdata(0,'stdErrPars');
problem = stdErrPars.problem;
params = stdErrPars.params;

%Unpck the params..
problem.fitpars = x0;
problem = unpackparams(problem);

% and call fun
%problem = feval(params.fun,problem,params.args{:});
%setappdata(0,'problem',problem);
problem = reflectivity_calculation(problem);

fval = problem.calculations.sum_chi;

end