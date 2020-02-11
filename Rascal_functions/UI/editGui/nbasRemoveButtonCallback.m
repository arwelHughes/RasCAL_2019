function nbasRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiNbaTable');
nbasNamesList = getappdata(0,'nbasNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    contrastLayersTableNbaBoxRemoveItem(theModel.getValueAt(selected(1),0));
    nbasNamesList = [nbasNamesList(1:selected(1)) nbasNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiNbaTable',theTable);
setappdata(0,'nbasNamesList',nbasNamesList);

