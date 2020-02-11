function removeContrastCallback(src,ev)

desktop = getappdata(0,'desktop');
mainFrame = getappdata(0,'internalFrame');
mainTabbedPane = getappdata(0,'mainPane');
panels = getappdata(0,'allContrastPanels');
tables = getappdata(0,'allContrastTables');
allPanels = getappdata(0,'allPanels');

lockEditGuiFrame();


whichContrastDialog = deleteWhichContrastDialog();
dComboBox = whichContrastDialog.getDeleteWhichComboBox();
dOKButton = whichContrastDialog.getOkButton();
dCancelButton = whichContrastDialog.getCancelButton();
set(dCancelButton,'ActionPerformedCallback',@cancelPressed);
set(dOKButton,'ActionPerformedCallback',@okPressed);

%p = mainFrame.getLocation;

desktop.setLayer(whichContrastDialog,4);
desktop.add(whichContrastDialog);
whichContrastDialog.toFront();
whichContrastDialog.setLocation(mainFrame.getLocation);
whichContrastDialog.setVisible(true);

numberOfContrasts = length(panels);
for i = 1:numberOfContrasts;
    dComboBox.addItem(['Contrast ' num2str(i)]);
end

%Internal Nested Functions....
    function okPressed(src,ev)
        if numberOfContrasts == 1
            addInfoText('');
            addInfoText('');
            addInfoText('At least one contrast required');
            whichContrastDialog.dispose;
            unlockEditGuiFrame;
            setappdata(0,'allContrastPanels',panels);
            setappdata(0,'allContrastTables',tables);
            return
        end 
        whichSelected = dComboBox.getSelectedIndex;
        tabLocation = whichSelected + 4;
        mainTabbedPane.removeTabAt(tabLocation);
        newContrastNumber = 1;
        for n = 4:mainTabbedPane.getTabCount-1;
            mainTabbedPane.setTitleAt(n,['Contrast ' num2str(newContrastNumber)]);
            newContrastNumber = newContrastNumber + 1;
        end
        panels(whichSelected+1) = [];
        tables(whichSelected+1) = [];
        numberOfContrasts = numberOfContrasts - 1;
        for p = 1:length(panels)
            thisPanel = panels{p};
            addLayersButton = thisPanel.getAddLayersButton();
            removeLayersButton = thisPanel.getRemoveLayersButton();
            typeComboBox = thisPanel.getTypeComboBox();
            setappdata(addLayersButton,'UserData',p);      
            setappdata(removeLayersButton,'UserData',p);
            setappdata(typeComboBox,'UserData',p);
        end
        generalPanel = allPanels.generalPanel;
        noOfContrastsBox = generalPanel.getNumberOfContrastsTextField();
        noOfContrastsBox.setText(num2str(numberOfContrasts));
        whichContrastDialog.dispose;
        unlockEditGuiFrame;
        allPanels.contrasts = panels;
        
        setappdata(0,'allPanels',allPanels);
        setappdata(0,'allContrastPanels',panels);
        setappdata(0,'allContrastTables',tables);
    end

    function cancelPressed(src,ev)
        whichContrastDialog.dispose;
        unlockEditGuiFrame;
    end
end


