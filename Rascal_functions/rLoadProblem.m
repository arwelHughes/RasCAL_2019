function problem = rLoadProblem(path,name);

cd(path);
load(name);
if strcmp(problem.path,path)~=1
    problem.path = path;
    save(name,'problem');
end

problem = dealWithLegacyIssues(problem);
problem = rLoadDataFile(problem);
rascalMemoryCleanup();

