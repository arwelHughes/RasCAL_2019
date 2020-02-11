function resolutionTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

resolNamesList = getappdata(0,'resolutionNamesList');
resolTable = getappdata(0,'editGuiResolTable');
tableModel = resolTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = resolNamesList{row+1};

addToAllContrastResolCombos(newval);
removeFromAllContrastBacksCombos(oldval);

resolNamesList{row+1} = newval;

setappdata(0,'resolNamesList',resolNamesList);