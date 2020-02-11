function undoLastFit(src,ev)


disp('test');

thisProblem = getappdata(0,'problem');
setappdata(0,'nextProblem',thisProblem);

previousProblem = getappdata(0,'oldProblem');
problem = previousProblem;
setappdata(0,'problem',problem);

setappdata(0,'oldProblem',[]);

menuItems = getappdata(0,'undoRedoMenuItems');
set(menuItems.undoMenuItem,'Enabled',0);
set(menuItems.redoMenuItem,'Enabled',1);

reSetProblem(problem);

disp('debug!');


