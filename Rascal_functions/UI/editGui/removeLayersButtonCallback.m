function removeLayersButtonCallback(src,ev);

problem = getappdata(0,'problem');
items = getappdata(0,'layersTableItems');
layersNamesList = getappdata(0,'layersNamesList');


table = items.table;
model = table.getModel();

selected = table.getSelectedRows();
while (~isempty(selected));
    contrastLayersCboxRemoveItem(model.getValueAt(selected(1),0));
    layersNamesList = [layersNamesList(1:selected(1)) layersNamesList(selected(1)+2:end)];
    model.removeRow(selected(1));
    selected = table.getSelectedRows();
end


items.table = table;

setappdata(0,'layersTableItems',items);
setappdata(0,'problem',problem);
setappdata(0,'layersNamesList',layersNamesList);
end



%_________________________________________________________________________
