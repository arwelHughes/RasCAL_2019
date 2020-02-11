function saveProject(src,ev);

problem = getappdata(0,'problem');
cd(problem.path);
if iscell(problem.name)
    name = problem.name{:};
else
    name = problem.name;
end
save(name,'problem');
addInfoText(['Saving  ' name]);
savePosWindows();

