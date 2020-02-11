function nbsTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

nbsNamesList = getappdata(0,'nbsNamesList');
nbsTable = getappdata(0,'editGuiNbsTable');
tableModel = nbsTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = nbsNamesList{row+1};

contrastLayersTableNbsBoxAddItem(newval);
contrastLayersTableNbsBoxRemoveItem(oldval);

nbsNamesList{row+1} = newval;

setappdata(0,'nbsNamesList',nbsNamesList);