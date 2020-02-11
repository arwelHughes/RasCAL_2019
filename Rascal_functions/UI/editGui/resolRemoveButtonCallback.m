function resolRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiResolTable');
resolNamesList = getappdata(0,'resolutionNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    removeFromAllContrastResolCombos(theModel.getValueAt(selected(1),0));
    resolNamesList = [resolNamesList(1:selected(1)) resolNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiResolTable',theTable);
setappdata(0,'resolutionNamesList',resolNamesList);

