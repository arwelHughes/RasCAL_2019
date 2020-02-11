function nbsAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiNbsTable');
numberOfAddedNbs = getappdata(0,'numberOfAddedNbs');
nbsNamesList = getappdata(0,'nbsNamesList');
theModel = theTable.getModel();

items = getappdata(0,'contrastEditPanelTablesCombos');
%cbox = items.bulkIn;


newRowName = ['Bulk out ' num2str(numberOfAddedNbs)];
newRow = {newRowName , 6.3e-6 , 6.35e-6 , 6.35e-6};
theModel.addRow(newRow);
contrastLayersTableNbsBoxAddItem(newRowName);
nbsNamesList{end+1} = newRowName;

setappdata(0,'editGuiNbsTable',theTable);
setappdata(0,'numberOfAddedNbs',numberOfAddedNbs+1);
setappdata(0,'nbsNamesList',nbsNamesList);


