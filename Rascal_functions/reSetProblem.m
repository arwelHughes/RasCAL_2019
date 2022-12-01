function reSetProblem(problem)

problem = rascal_defaults(problem);
problem = dealWithLegacyIssues(problem);
problem.calculations.xtra_fitness = 0;
problem = backsorts(problem);
problem = packparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
clearDesktop();
desktop = getappdata(0,'desktop');
desktop = SetupPlotsAndMainGuiWindows(desktop,problem);
if strcmp(problem.q4,'yes')
    turnOnQ4();
else
    turnOffQ4();
end
setappdata(0,'desktop',desktop);
resetFittingOptionsFrame;
applyOldChecksStatus;
restorePreviousCheckStatus;
rJavaUpdatePlots();
defaultPosWindows();

