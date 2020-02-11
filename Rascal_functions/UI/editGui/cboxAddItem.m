function cboxAddItem(name)

layersTableItems = getappdata(0,'layersTableItems');
if isempty(layersTableItems)
    return
end
cBox = layersTableItems.cBox;
cBox.addItem(name);
layersTableItems.cBox = cBox;
setappdata(0,'layersTableItems',layersTableItems);
end


%__________________________________________________________________________


