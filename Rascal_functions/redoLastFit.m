function redoLastFit(src,ev)


thisProblem = getappdata(0,'problem');
nextProblem = getappdata(0,'nextProblem');

setappdata(0,'oldProblem',thisProblem);
problem = nextProblem;

setappdata(0,'problem',problem);
setappdata(0,'problem',problem);

menuItems = getappdata(0,'undoRedoMenuItems');
set(menuItems.undoMenuItem,'Enabled','on');
set(menuItems.redoMenuItem,'Enabled','off');

reSetProblem(problem);