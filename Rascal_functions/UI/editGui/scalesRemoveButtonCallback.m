function scalesRemoveButtonCallback(src,ev)

theTable = getappdata(0,'editGuiScalesTable');
scalesNamesList = getappdata(0,'scalesNamesList');
theModel = theTable.getModel();

selected = theTable.getSelectedRows();
while (~isempty(selected));
    removeFromAllContrastScalesCombos(theModel.getValueAt(selected(1),0));
    scalesNamesList = [scalesNamesList(1:selected(1)) scalesNamesList(selected(1)+2:end)];
    theModel.removeRow(selected(1));
    selected = theTable.getSelectedRows();
end

setappdata(0,'editGuiScalesTable',theTable);
setappdata(0,'scalesNamesList',scalesNamesList);

