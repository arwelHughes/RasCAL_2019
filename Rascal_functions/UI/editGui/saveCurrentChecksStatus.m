function saveCurrentChecksStatus

problem = getappdata(0,'problem');
checkStatus = {};

params = problem.paramnames;
pChecks = paramsTableGetChecked;

for i = 1:length(params);
    checkStatus.params{i} = {params{i},pChecks(i)};
end

backs = problem.backsNames;
bChecks = backsTableGetChecked;
for i = 1:length(backs);
    checkStatus.backs{i} = {backs{i},bChecks(i)};
end

scales = problem.scalesNames;
sChecks = scalesTableGetChecked;
for i = 1:length(scales);
    checkStatus.scales{i} = {scales{i},sChecks(i)};
end

shifts = problem.shiftsNames;
shChecks = shiftsTableGetChecked;
for i = 1:length(shifts);
    checkStatus.shifts{i} = {shifts{i},shChecks(i)};
end

nbairs = problem.nbaNames;
nbaChecks = nbairsTableGetChecked;
for i = 1:length(nbairs);
    checkStatus.nbairs{i} = {nbairs{i} nbaChecks(i)};
end

nbsubs = problem.nbsNames;
nbsChecks = nbsubsTableGetChecked;
for i = 1:length(nbsubs);
    checkStatus.nbsubs{i} = {nbsubs{i} nbsChecks(i)};
end

resol = problem.resolNames;
resolChecks = resolutionTableGetChecked;
for i = 1:length(resol);
    checkStatus.resol{i} = {resol{i} resolChecks(i)};
end


setappdata(0,'checkStatus',checkStatus);