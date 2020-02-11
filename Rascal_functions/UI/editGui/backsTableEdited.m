function backsTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

backsNamesList = getappdata(0,'backsNamesList');
backsTable = getappdata(0,'editGuiBacksTable');
tableModel = backsTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = backsNamesList{row+1};

addToAllContrastBacksCombos(newval);
removeFromAllContrastBacksCombos(oldval);

backsNamesList{row+1} = newval;

setappdata(0,'backsNamesList',backsNamesList);