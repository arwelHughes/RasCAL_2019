function contrastLayersTableBoxAddItem(name)

boxes = getappdata(0,'contrastEditPanelTablesCombos');
layersComboBox = boxes.layers;
layersComboBox.addItem(name);
boxes.layers = layersComboBox;
setappdata(0,'contrastEditPanelTablesCombos',boxes);
end


%__________________________________________________________________________


