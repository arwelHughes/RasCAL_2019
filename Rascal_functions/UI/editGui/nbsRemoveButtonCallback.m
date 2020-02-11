function nbsRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiNbsTable');
nbsNamesList = getappdata(0,'nbsNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    contrastLayersTableNbsBoxRemoveItem(theModel.getValueAt(selected(1),0));
    nbsNamesList = [nbsNamesList(1:selected(1)) nbsNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiNbsTable',theTable);
setappdata(0,'nbsNamesList',nbsNamesList);

