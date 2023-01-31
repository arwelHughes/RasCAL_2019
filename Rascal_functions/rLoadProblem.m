function problem = rLoadProblem(path,name);

% Check to see if the user has save permissions....
[~,attr] = fileattrib(pwd);
if ~attr.UserWrite
    warning('no user save permissions on current directory');
end

cd(path);
load(name);

if (strcmp(problem.path,path)~=1) && attr.UserWrite
    problem.path = path;
    save(name,'problem');
end

problem = dealWithLegacyIssues(problem);
problem = rLoadDataFile(problem);
rascalMemoryCleanup();

