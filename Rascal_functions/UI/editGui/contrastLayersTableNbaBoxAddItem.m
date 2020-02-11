function contrastLayersTableNbaBoxAddItem(name)

boxes = getappdata(0,'contrastEditPanelTablesCombos');
nbaComboBox = boxes.bulkIn;
nbaComboBox.addItem(name);
boxes.bulkIn = nbaComboBox;
setappdata(0,'contrastEditPanelTablesCombos',boxes);


