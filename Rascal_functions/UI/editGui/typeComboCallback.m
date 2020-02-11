function typeComboCallback(src,ev)

MPcomponents = getappdata(0,'MPComponents');
mainPane = getappdata(0,'mainPane');

which = get(src,'SelectedItem');

switch which
    case 'Standard Layers'
        MPcomponents.customFileLabel.setVisible(false);
        MPcomponents.customFileBrowseButton.setVisible(false);
        MPcomponents.customFileTextField.setVisible(false);
        MPcomponents.customFileNew.setVisible(false);
        MPcomponents.customFileEdit.setVisible(false);
        mainPane.setEnabledAt(2,true);
        changeContrastLayersTablesForLayers()
    otherwise
        MPcomponents.customFileLabel.setVisible(true);
        MPcomponents.customFileBrowseButton.setVisible(true);
        MPcomponents.customFileTextField.setVisible(true);
        MPcomponents.customFileNew.setVisible(true);
        MPcomponents.customFileEdit.setVisible(true);
        mainPane.setEnabledAt(2,false);
        changeContrastLayersTablesForCustom()
end

end

