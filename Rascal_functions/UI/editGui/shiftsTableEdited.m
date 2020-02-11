function shiftsTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

shiftsNamesList = getappdata(0,'shiftsNamesList');
shiftsTable = getappdata(0,'editGuiShiftsTable');
tableModel = shiftsTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = shiftsNamesList{row+1};

addToAllContrastShiftsCombos(newval);
removeFromAllContrastShiftsCombos(oldval);

shiftsNamesList{row+1} = newval;

setappdata(0,'shiftsNamesList',shiftsNamesList);