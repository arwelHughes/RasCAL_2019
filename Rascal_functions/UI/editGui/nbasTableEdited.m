function nbasTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

nbasNamesList = getappdata(0,'nbasNamesList');
nbasTable = getappdata(0,'editGuiNbaTable');
tableModel = nbasTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = nbasNamesList{row+1};

contrastLayersTableNbaBoxAddItem(newval);
contrastLayersTableNbaBoxRemoveItem(oldval);

nbasNamesList{row+1} = newval;

setappdata(0,'nbassNamesList',nbasNamesList);