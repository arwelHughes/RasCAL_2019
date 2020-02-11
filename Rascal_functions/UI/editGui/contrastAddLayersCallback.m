function contrastAddLayersCallback(src,ev)

whichContrast = getappdata(src,'UserData');
theTables = getappdata(0,'allContrastTables');
thisTable = theTables{whichContrast};

theModel = thisTable.getModel();
selected = thisTable.getSelectedRow();

if selected == -1
    return
end

rowData = {'Layer',''};
theModel.insertRow(selected(1),rowData);
numberOfLayers = theModel.getRowCount()-2;

allPanels = getappdata(0,'allPanels');
thisPanel = allPanels.contrasts{whichContrast};

numberOfLayersBox = thisPanel.getNumberOfLaysTextBox();
numberOfLayersBox.setText(java.lang.String(num2str(numberOfLayers)));

