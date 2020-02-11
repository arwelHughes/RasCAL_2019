function resolAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiResolTable');
numberOfAddedResols = getappdata(0,'numberOfAddedResols');
resolsNamesList = getappdata(0,'resolutionNamesList');
theModel = theTable.getModel();

newRowName = ['Resolution ' num2str(numberOfAddedResols)];
newRow = {newRowName , 0.01 , 0.03 , 0.05};
theModel.addRow(newRow);
addToAllContrastResolCombos(newRowName);
resolsNamesList{end+1} = newRowName;

setappdata(0,'editGuiResolTable',theTable);
setappdata(0,'numberOfAddedResols',numberOfAddedResols+1);
setappdata(0,'resolutionNamesList',resolsNamesList);


