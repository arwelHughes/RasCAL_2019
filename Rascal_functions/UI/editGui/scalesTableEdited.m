function scalesTableEdited(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

scalesNamesList = getappdata(0,'scalesNamesList');
scalesTable = getappdata(0,'editGuiScalesTable');
tableModel = scalesTable.getModel();

newval = tableModel.getValueAt(row,col);
oldval = scalesNamesList{row+1};

addToAllContrastScalesCombos(newval);
removeFromAllContrastScalesCombos(oldval);

scalesNamesList{row+1} = newval;

setappdata(0,'scalesNamesList',scalesNamesList);