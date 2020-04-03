function thePanel = existingContrastPanelSetup(thisContrast);

problem = getappdata(0,'problem');
allContrastTables = getappdata(0,'allContrastTables');
allContrastPanels = getappdata(0,'allContrastPanels');
thePanel = contrastGui();

nameTextField = thePanel.getContrastNameTextField();
typeComboBox = thePanel.getTypeComboBox();
fileTextField = thePanel.getFileTextField();
backgroundComboBox = resetBackCombo(thePanel.getBackgroundComboBox(),problem);
scalefacComboBox = resetScaleCombo(thePanel.getScalefacComboBox(),problem);
shiftsComboBox = resetShiftsCombo(thePanel.getShiftComboBox(),problem);
resolComboBox = resetResolCombo(thePanel.getResolComboBox(),problem);
numberOfLayersBox = thePanel.getNumberOfLaysTextBox();
addLayersButton = thePanel.getAddLayersButton();
removeLayersButton = thePanel.getRemoveLayersButton();
fileNameBrowseButton = thePanel.getFileNameBrowseButton();
openGenieEditButton = thePanel.getOgEditButton();
fileTypeCombo = thePanel.getFileTypeComboBox();
reloadFileButton = thePanel.getReloadFileButtonGroup();

h_addLayersButton = handle(addLayersButton, 'CallbackProperties');
set(h_addLayersButton,'ActionPerformedCallback',@contrastAddLayersCallback);

h_removeLayersButton = handle(removeLayersButton, 'CallbackProperties');
set(h_removeLayersButton,'ActionPerformedCallback',@contrastRemoveLayersCallback);

h_typeComboBox = handle(typeComboBox, 'CallbackProperties');
set(h_typeComboBox,'ActionPerformedCallback',@contrastTypeComboChangedCallback);

h_fileNameBrowseButton = handle(fileNameBrowseButton, 'CallbackProperties');
set(h_fileNameBrowseButton,'ActionPerformedCallback',@contrastFileNameBrowseButtonCallback);

h_contrastOpenGenieEditButton = handle(openGenieEditButton, 'CallbackProperties');
set(h_contrastOpenGenieEditButton,'ActionPerformedCallback',@contrastOpenGenieEditButtonCallback);

setappdata(addLayersButton,'UserData',thisContrast);
setappdata(removeLayersButton,'UserData',thisContrast);
setappdata(typeComboBox,'UserData',thisContrast);
setappdata(fileNameBrowseButton,'UserData',thisContrast);
setappdata(openGenieEditButton,'UserData',thisContrast);
setappdata(fileTypeCombo,'UserData',thisContrast);
setappdata(reloadFileButton,'UserData',thisContrast);

type = problem.contrastTypes{thisContrast};
path = problem.datapath{:};
file = problem.contrastFiles{thisContrast};
name = problem.contrastNames{thisContrast};

nameTextField.setText(java.lang.String(name));
fileTextField.setText(java.lang.String([path file]));

if strcmp(computer,'MACI') && strcmp(type,'OpenGenie Script')
    type = 'Simulation';
end

%if strcmp(computer,'MACI')
    typeComboBox.removeItem('OpenGenie Script');
%end
    
switch type
    case 'Simulation'
       typeComboBox.setSelectedItem('Simulation');
       thePanel.hideFileItems(); 
       thePanel.getOgEditButton().setVisible(false)
    case 'Ascii File'
       typeComboBox.setSelectedItem('Ascii File');
       fileTypeCombo.setSelectedIndex(problem.contrastFileTypes(thisContrast));
       thePanel.showFileItems();
       thePanel.getOgEditButton().setVisible(false)
%     case 'OpenGenie Script'
%        typeComboBox.setSelectedItem('OpenGenie Script');
%        thePanel.hideFileItems();
%        thePanel.showOpenGenieItems();
end
        
backgroundComboBox.setSelectedIndex(problem.contrastBacks(thisContrast)-1);
scalefacComboBox.setSelectedIndex(problem.contrastScales(thisContrast)-1);
shiftsComboBox.setSelectedIndex(problem.contrastShifts(thisContrast)-1);
resolComboBox.setSelectedIndex(problem.contrastResolutions(thisContrast)-1);

type = problem.module.type;
if strcmp(type,'Standard Layers')
    layersTable = setupLayersDetailsTable(problem,thisContrast);
    thePanel.enableLayersItems();
else
    layersTable = setupCustomLayersTable(problem,thisContrast);
    thePanel.disableLayersItems();
end

layersScrollPane = thePanel.getLayersDetailsScrollPane();
layersScrollPane.setViewportView(layersTable);
allContrastTables{thisContrast} = layersTable;
allContrastPanels{thisContrast} = thePanel;

numberOfLayersBox.setText(num2str(problem.contrastsNumberOfLayers(thisContrast)));
problem.numberOfAddedLayers = 0;

mainGuiPanels = getappdata(0,'allMainGuiContrastPanels');

if thisContrast <= length(mainGuiPanels)
    thisPanel = mainGuiPanels{thisContrast}; 

    previousVals.simMin = thisPanel.getSimQminTextField().getText;
    previousVals.simMax = thisPanel.getSimQmaxTextField().getText; 

    previousVals.repeatsOn = thisPanel.getRepeatLayersCheckbox().isSelected;  
    previousVals.repeatNumber = thisPanel.getRepeatLayersTextBox().getText; 

    previousVals.datMin = thisPanel.getDataQminTextField().getText;
    previousVals.datMax = thisPanel.getDataQmaxTextField().getText;
    
    previousVals.data = problem.data{thisContrast};
else
    previousVals.simMin = '0.01';;
    previousVals.simMax = '0.7'; 

    previousVals.repeatsOn = 0;  
    previousVals.repeatNumber = '1'; 

    previousVals.datMin = '0.01';
    previousVals.datMax = '0.7';
end

setappdata(thePanel,'UserData',previousVals);

setappdata(0,'problem',problem);
setappdata(0,'allContrastTables',allContrastTables);
setappdata(0,'allContrastPanels',allContrastPanels);

end

