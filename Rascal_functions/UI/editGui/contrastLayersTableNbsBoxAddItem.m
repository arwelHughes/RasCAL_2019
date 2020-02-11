function contrastLayersTableNbsBoxAddItem(name)

boxes = getappdata(0,'contrastEditPanelTablesCombos');
nbsComboBox = boxes.bulkOut;
nbsComboBox.addItem(name);
boxes.bulkOut = nbsComboBox;
setappdata(0,'contrastEditPanelTablesCombos',boxes);


