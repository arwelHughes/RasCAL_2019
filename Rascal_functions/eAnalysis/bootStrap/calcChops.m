


function res = calcChops(par_number);

problem = getappdata(0,'problem');
originalProblem = problem;
originalChi = problem.calculations.sum_chi;
fitpars = problem.fitpars;

if par_number > problem.fitpars
    addInfoText('Error - selection out of range');
    return
end


fitconstr = problem.fitconstr;
originalPar = fitpars(par_number);
step = 0.01;
count = 1;
for i = -10:10;
thisStep = (i*(step*originalPar));
newPar = originalPar + thisStep;
x(count) = newPar;
problem.fitpars(par_number) = newPar;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');
thisVal = problem.calculations.sum_chi;
y(count) = thisVal;
count = count + 1;
end
figure(1)
clf
plot(x,y);
hold on
plot(originalPar,originalChi,'ro');

setappdata(0,'problem',originalProblem);