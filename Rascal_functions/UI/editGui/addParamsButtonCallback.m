function addParamsButtonCallback(src,ev)

problem = getappdata(0,'problem');
table = getappdata(0,'editGuiParamsTable');
paramsNamesList = getappdata(0,'paramsNamesList');
numberOfAddedParams = getappdata(0,'numberOfAddedParams');

model = table.getModel();

newParamName = ['New parameter ' num2str(numberOfAddedParams)];
numberOfAddedParams = numberOfAddedParams + 1;

rowdata = {newParamName,0,0.5,1};

model.addRow(rowdata);

cboxAddItem(newParamName);
paramsNamesList{end+1} = newParamName;

setappdata(0,'problem',problem);
setappdata(0,'paramsNamesList',paramsNamesList);
setappdata(0,'numberOfAddedParams',numberOfAddedParams);
end

%________________________________________________________________________

