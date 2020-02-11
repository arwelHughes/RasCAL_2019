function backsAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiBacksTable');
numberOfAddedBacks = getappdata(0,'numberOfAddedBacks');
backsNamesList = getappdata(0,'backsNamesList');
theModel = theTable.getModel();

newRowName = ['Background ' num2str(numberOfAddedBacks)];
newRow = {newRowName , 1e-6 , 2e-6 , 3e-6};
theModel.addRow(newRow);
addToAllContrastBacksCombos(newRowName);
backsNamesList{end+1} = newRowName;

setappdata(0,'editGuiBacksTable',theTable);
setappdata(0,'numberOfAddedBacks',numberOfAddedBacks+1);
setappdata(0,'backsNamesList',backsNamesList);


