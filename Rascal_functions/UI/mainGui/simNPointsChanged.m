function simNPointsChanged(src,ev)

accessible = get(src,'AccessibleContext');
%whichContrast = getappdata(accessible,'UserData');
whichContrast = getappdata(src,'UserData');

details = get(src,'ActionPerformedCallbackData');
value = details.getActionCommand;


problem = getappdata(0,'problem'); 
problem.simNPoints(whichContrast) = str2num(value); 
problem = setupSimulation(problem,whichContrast);
setappdata(0,'problem',problem); 
rsafeCalcAndPlot();