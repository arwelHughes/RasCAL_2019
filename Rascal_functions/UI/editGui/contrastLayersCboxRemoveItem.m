function contrastLayersCboxRemoveItem(name)

boxes = getappdata(0,'contrastEditPanelTablesCombos');
allContrastTables = getappdata(0,'allContrastTables');
layersComboBox = boxes.layers;
layersComboBox.removeItem(name);

for i = 1:length(allContrastTables)
    model = allContrastTables{i}.getModel();
    rows = model.getRowCount();
    cols = model.getColumnCount();
    for n = 0:rows-1;
        for m = 0:cols-1;
            here = model.getValueAt(n,m);
            if strcmp(here,name)
                model.setValueAt('',n,m);
            end
        end
    end
end

boxes.layers = layersComboBox;
setappdata(0,'contrastEditPanelTablesCombos',boxes);
end