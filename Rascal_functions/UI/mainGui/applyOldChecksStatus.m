function applyOldChecksStatus;

problem = getappdata(0,'problem');
checkStatus = {};

params = problem.paramnames;
pChecks = problem.fityesno;

for i = 1:length(params);
    checkStatus.params{i} = {params{i},pChecks(i)};
end

backs = problem.backsNames;
bChecks = problem.backgrounds_fityesno;
for i = 1:length(backs);
    checkStatus.backs{i} = {backs{i},bChecks(i)};
end

scales = problem.scalesNames;
sChecks = problem.scalefac_fityesno;
for i = 1:length(scales);
    checkStatus.scales{i} = {scales{i},sChecks(i)};
end

shifts = problem.shiftsNames;
shChecks = problem.shifts_fityesno;
for i = 1:length(shifts);
    checkStatus.shifts{i} = {shifts{i},shChecks(i)};
end

nbairs = problem.nbaNames;
nbaChecks = problem.nbairs_fityesno;
for i = 1:length(nbairs);
    checkStatus.nbairs{i} = {nbairs{i} nbaChecks(i)};
end

nbsubs = problem.nbsNames;
nbsChecks = problem.nbsubs_fityesno;
for i = 1:length(nbsubs);
    checkStatus.nbsubs{i} = {nbsubs{i} nbsChecks(i)};
end

resol = problem.resolNames;
resolChecks = problem.resolution_fityesno;
for i = 1:length(resol);
    checkStatus.resol{i} = {resol{i} resolChecks(i)};
end

setappdata(0,'checkStatus',checkStatus);

