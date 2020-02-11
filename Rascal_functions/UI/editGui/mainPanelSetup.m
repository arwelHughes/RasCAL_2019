function theMainPanel = mainPanelSetup();

problem = getappdata(0,'problem');

theMainPanel =  mainPanel();

MPcomponents.addContrastButton = theMainPanel.getAddContrastsButton();
MPcomponents.customFileBrowseButton = theMainPanel.getCustomFileBrowse();
MPcomponents.customFileLabel = theMainPanel.getCustomFileLabel();
MPcomponents.customFileTextField = theMainPanel.getCustomFileTextField();
MPcomponents.geometryComboBox = theMainPanel.getGeometryComboBox();
MPcomponents.projectNameTextField = theMainPanel.getProjectNameTextField();
MPcomponents.numberOfContrastsTextField = theMainPanel.getNumberOfContrastsTextField();
MPcomponents.pathTextField = theMainPanel.getPathTextField();
MPcomponents.removeContrastButton = theMainPanel.getremoveContrastsButton(); 
MPcomponents.typeComboBox = theMainPanel.getTypeComboBox();
MPcomponents.customFileNew = theMainPanel.getCustomFileNew();
MPcomponents.customFileEdit = theMainPanel.getCustomFileEdit();
MPcomponents.importModel = theMainPanel.getImportModel();
MPcomponents.exportModel = theMainPanel.getExportModel();

if ~isdeployed
    type = problem.module.type;
    MPcomponents.typeComboBox.setSelectedItem(type);

    if strcmp(type,'Standard Layers')
        MPcomponents.customFileLabel.setVisible(false);
        MPcomponents.customFileBrowseButton.setVisible(false);
        MPcomponents.customFileTextField.setVisible(false);
        MPcomponents.customFileNew.setVisible(false);
        MPcomponents.customFileEdit.setVisible(false);
    else
        MPcomponents.customFileLabel.setVisible(true);
        MPcomponents.customFileBrowseButton.setVisible(true);
        MPcomponents.customFileNew.setVisible(true);
        MPcomponents.customFileEdit.setVisible(true);
        MPcomponents.customFileTextField.setVisible(true);
        MPcomponents.customFileTextField.setText(problem.module.name);
    end
else
    MPcomponents.typeComboBox.setSelectedItem('Standard Layers');
    MPcomponents.typeComboBox.setEnabled(false);
end



MPcomponents.pathTextField.setText(problem.path);

numberOfContrasts = length(problem.include_data);
MPcomponents.numberOfContrastsTextField.setText(num2str(numberOfContrasts));

MPcomponents.projectNameTextField.setText(problem.name);

MPcomponents.geometryComboBox.setSelectedItem(problem.module.experiment_type);

set(MPcomponents.typeComboBox,'ActionPerformedCallback',@typeComboCallback);
set(MPcomponents.removeContrastButton,'ActionPerformedCallback',@removeContrastCallback);
set(MPcomponents.addContrastButton,'ActionPerformedCallback',@addContrastCallback);
set(MPcomponents.customFileNew,'ActionPerformedCallback',@makeNewCustomFile);
set(MPcomponents.customFileBrowseButton,'ActionPerformedCallback',@selectExistingCustomFile);
set(MPcomponents.customFileEdit,'ActionPerformedCallback',@editExistingCustomFile);
set(MPcomponents.exportModel,'ActionPerformedCallback',@exportModelFile);
set(MPcomponents.importModel,'ActionPerformedCallback',@importModelFile);
setappdata(0,'MPComponents',MPcomponents);

end


