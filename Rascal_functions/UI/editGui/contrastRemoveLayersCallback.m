function contrastRemoveLayersCallback(src,ev);


whichContrast = getappdata(src,'UserData');
theTables = getappdata(0,'allContrastTables');
thisTable = theTables{whichContrast};

theModel = thisTable.getModel();
selected = thisTable.getSelectedRow();

rows = theModel.getRowCount();

if (selected == -1) || (selected == 0) || (selected == rows-1)
    return
end

if ~(isempty(selected))
    theModel.removeRow(selected(1));
end

numberOfLayers = theModel.getRowCount()-2;

allPanels = getappdata(0,'allPanels');
thisPanel = allPanels.contrasts{whichContrast};

numberOfLayersBox = thisPanel.getNumberOfLaysTextBox();
numberOfLayersBox.setText(java.lang.String(num2str(numberOfLayers)));


theTables{whichContrast} = thisTable;

setappdata(0,'theTables',theTables);

end



%_________________________________________________________________________
