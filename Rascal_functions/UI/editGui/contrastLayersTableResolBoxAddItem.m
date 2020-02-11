function contrastLayersTableResolBoxAddItem(name)

boxes = getappdata(0,'contrastEditPanelTablesCombos');
resolComboBox = boxes.resolution;
resolComboBox.addItem(name);
boxes.resolution = resolComboBox;
setappdata(0,'contrastEditPanelTablesCombos',boxes);


