function backsRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiBacksTable');
backsNamesList = getappdata(0,'backsNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    removeFromAllContrastBacksCombos(theModel.getValueAt(selected(1),0));
    backsNamesList = [backsNamesList(1:selected(1)) backsNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiBacksTable',theTable);
setappdata(0,'backsNamesList',backsNamesList);

