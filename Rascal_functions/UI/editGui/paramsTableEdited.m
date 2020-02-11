function paramsTableEdited(src,ev)

paramsNamesList = getappdata(0,'paramsNamesList');
tableModel = getappdata(0,'editGuiParamsTableModel');
MPComponents = getappdata(0,'MPComponents');

how = getappdata(tableModel,'UserData');
if strcmp(how,'From Code');
    setappdata(tableModel,'UserData','');
    return
end


typeBox = MPComponents.typeComboBox;
whatType = typeBox.getSelectedItem;

row = ev.getFirstRow;
col = ev.getColumn;

if col ~= 0
    return;
end

if (col == 0 && row == 0 && strcmp(whatType,'Standard Layers'));
    setappdata(tableModel,'UserData','From Code');
    tableModel.setValueAt('Substrate Roughness',0,0);
    addInfoText('First parameter must be substrate roughness in standard layer model');
    beep
    return;
end

newval = tableModel.getValueAt(row,col);
oldval = paramsNamesList{row+1};

cboxremoveItem(oldval);
cboxAddItem(newval);

paramsNamesList{row+1} = newval;

setappdata(0,'paramsNamesList',paramsNamesList);

end

%________________________________________________________________________
