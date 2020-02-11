function shiftsRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiShiftsTable');
shiftsNamesList = getappdata(0,'shiftsNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    removeFromAllContrastShiftsCombos(theModel.getValueAt(selected(1),0));
    shiftsNamesList = [shiftsNamesList(1:selected(1)) shiftsNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiShiftsTable',theTable);
setappdata(0,'shiftsNamesList',shiftsNamesList);

