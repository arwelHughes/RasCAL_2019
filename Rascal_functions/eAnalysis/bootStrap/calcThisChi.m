function thisVal = calcThisChi(x0);



problem = getappdata(0,'problem');
oldProblem = problem;
problem.fitpars = x0;

problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');
thisVal = problem.calculations.sum_chi;

setappdata(0,'problem',oldProblem);