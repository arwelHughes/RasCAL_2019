function layersTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end


layersNamesList = getappdata(0,'layersNamesList');
layersTableItems = getappdata(0,'layersTableItems');
tableModel = layersTableItems.model;

newval = tableModel.getValueAt(row,col);
oldval = layersNamesList{row+1};

contrastLayersCboxRemoveItem(oldval);
contrastLayersTableBoxAddItem(newval);

layersNamesList{row+1} = newval;

setappdata(0,'layersNamesList',layersNamesList);

end

%________________________________________________________________________
