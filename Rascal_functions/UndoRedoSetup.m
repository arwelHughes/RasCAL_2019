function UndoRedoSetup(problem)


setappdata(0,'oldProblem',problem);

menuItems = getappdata(0,'undoRedoMenuItems');
undoMenuItem = menuItems.undoMenuItem;

%What follows is a very dirty hack to deal with the change to syntax for
%the java call. This changed posr R2010a.
%Conditional excecution based on the output of 'version' would be better,
%and is on the todo....
try
    set(undoMenuItem,'Enabled',1);
catch
    set(undoMenuItem,'Enabled','on');
end
