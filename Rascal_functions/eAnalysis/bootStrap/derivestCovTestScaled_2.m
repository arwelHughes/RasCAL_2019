function scaledCovTest4(src,ev)


addInfoText('')
addInfoText('')
addInfoText('Attempting to Estimate parameter uncertainties from the gradients');
addInfoText('around the selected parameters. Please wait...');
addInfoText('')
addInfoText('')

lockMainGuiFrame
lockMainControlsFrame
disableMenus

%Initial set up
problem = getappdata(0,'problem'); 
originalProblem = problem;
problem = updateChecksStatus(problem);
problem = packparams(problem);
problem.bestPars = problem.fitpars;
setappdata(0,'problem',problem);

fitpars = problem.fitpars;

scaledPars = fitpars./fitpars;

% [hess,b]=hessian_test(@calcThisChi,scaledPars);
% 
% cov = inv(hess);
x = scaledPars;
funfcn = @calcThisChi;
delta = 10^(-6);
t = length(x);
h = zeros(t);
Dx = delta*eye(t);

for i = 1: t
    for j = 1: t
        h(i,j) = (feval(funfcn,x+Dx(i,:)+Dx(j,:)) ...
                  - feval(funfcn,x+Dx(i,:)-Dx(j,:)) ...
                  - feval(funfcn,x-Dx(i,:)+Dx(j,:)) ...
                  + feval(funfcn,x-Dx(i,:)-Dx(j,:)) ...
                 ) / (4*delta^2);
    end
end

d=eig(h);
%disp(d);
cov=inv(h);

k = sqrt(diag(cov));
k1 = diag(k); 
k2=inv(k1);
cor = k2 * cov * k2

% if any(find(diag(cov)<0))
%     addInfoText('');
%     addInfoText('Sorry, some of the values on the diagonal of the Covariance Matrix are negative')
%     addInfotext('Cant estimate the errors from the gradient');
%     addInfoText('(This could occur if the parameters are close to a boundary, or if');
%     addInfoText('two or more parameters are too highly correlated)');
%     addInfoText('Please use the first order estimation or the jackknife estimator');
%     return
% end

e1 = diag(cov);
%e1 = makeCov(hess,length(fitpars))';

for i = 1:length(fitpars)
    for j = 1:length(fitpars);
        cM(i,j) = cov(i,j) / sqrt(cov(i,i)*cov(j,j));
    end
end

disp(cM);

if any(find(e1<0))
    addInfoText('');
    addInfoText('Sorry, some of the values on the diagonal of the Covariance Matrix are negative')
    addInfotext('Cant estimate the errors from the gradient');
    addInfoText('(This could occur if the parameters are close to a boundary, or if');
    addInfoText('two or more parameters are too highly correlated)');
    addInfoText('Please use the first order estimation or the jackknife estimator');
    unlockMainGuiFrame
    unlockMainControlsFrame
    enableMenus
    return
end

err = 2*sqrt(e1);
err = err' .* fitpars;
problem.fiterrs = err;

for i = 1:length(problem.fitpars);
    addInfoText(sprintf([problem.fitNames{i} ' \t \t  %d  +/-  \t %d'],fitpars(i),err(i)));
end

setappdata(0,'problem',originalProblem);



unlockMainGuiFrame
unlockMainControlsFrame
enableMenus
end
%--------------------------------------------------------------------------


function thisVal = calcThisChi(x0);



problem = getappdata(0,'problem');
bestPars = problem.bestPars;

oldProblem = problem;
problem.fitpars = x0.*bestPars;

problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');
thisVal = problem.calculations.sum_chi;

setappdata(0,'problem',oldProblem);


end
%-------------------------------------------------------------------------


function orthog_test


problem = getappdata(0,'problem');
bestPars = problem.fitpars;
scaledPars = bestPars ./ bestPars;
bestValofChi = problem.calculations.sum_chi;

delta = 0.01;

shiftedPars = scaledPars;
shiftedPars(1) = shiftedPars(1) + delta;
newVal = calcThisChi(shiftedPars);

index = 2;
coefficient = 0;
d = minDiff(coefficient,bestValofChi,shiftedPars,index,delta);

[c,fval] = fminsearch(@minDiff,coefficient,[],bestValofChi,shiftedPars,index,delta);

disp('hello!');
end



%------------------------------------------------------------------------

function d = minDiff(coefficient,bestValofChi,allVals,index,delta);

shift = coefficient * delta;
allVals(index) = allVals(index) + shift;
newValofChi= calcThisChi(allVals);
d = newValofChi - bestValofChi;

end
