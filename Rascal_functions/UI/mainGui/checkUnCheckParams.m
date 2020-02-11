function checkUnCheckParams(src,ev)

problem = getappdata(0,'problem');
checks = paramsTableGetChecked();

check_on = length(find(checks == 1));
check_off = length(find(checks == 0));

if check_on > check_off
   newChecks = zeros(size(checks));
else
    newChecks = ones(size(checks));
end

problem.fityesno = newChecks;
setappdata(0,'problem',problem');
updateParamsTable;

