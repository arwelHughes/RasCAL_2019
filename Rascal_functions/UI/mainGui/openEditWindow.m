function openEditWindow(src,ev)

problem = getappdata(0,'problem');
setappdata(0,'originalProblem',problem);

%savePosWindows
editGuiTest(problem);

end












