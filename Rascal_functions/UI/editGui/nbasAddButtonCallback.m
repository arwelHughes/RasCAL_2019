function nbasAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiNbaTable');
numberOfAddedNbas = getappdata(0,'numberOfAddedNbas');
nbasNamesList = getappdata(0,'nbasNamesList');
theModel = theTable.getModel();

items = getappdata(0,'contrastEditPanelTablesCombos');
%cbox = items.bulkIn;


newRowName = ['Bulk in ' num2str(numberOfAddedNbas)];
newRow = {newRowName , -0.001 , 0 , 0.001};
theModel.addRow(newRow);
contrastLayersTableNbaBoxAddItem(newRowName);
nbasNamesList{end+1} = newRowName;

setappdata(0,'editGuiShiftsTable',theTable);
setappdata(0,'numberOfAddedNbas',numberOfAddedNbas+1);
setappdata(0,'nbasNamesList',nbasNamesList);


