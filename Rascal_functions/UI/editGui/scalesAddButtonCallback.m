function scalesAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiScalesTable');
numberOfAddedScales = getappdata(0,'numberOfAddedScales');
scalesNamesList = getappdata(0,'scalesNamesList');
theModel = theTable.getModel();

newRowName = ['Scalefactor ' num2str(numberOfAddedScales)];
newRow = {newRowName , -0.01 , 0 , 0.01};
theModel.addRow(newRow);
addToAllContrastScalesCombos(newRowName);
scalesNamesList{end+1} = newRowName;

setappdata(0,'editGuiScalesTable',theTable);
setappdata(0,'numberOfAddedScales',numberOfAddedScales+1);
setappdata(0,'scalesNamesList',scalesNamesList);


