function contrastTypeComboChangedCallback(src,ev)


whichContrast = getappdata(src,'UserData');
allPanels = getappdata(0,'allPanels');
allContrastPanels = allPanels.contrasts;

thisPanel = allContrastPanels{whichContrast};
whatSelected = get(src,'SelectedItem');

switch whatSelected
    case 'Ascii File'
        thisPanel.showFileItems;
        thisPanel.getOgEditButton().setVisible(false)
    case 'Simulation'
        thisPanel.hideFileItems();
        thisPanel.getOgEditButton().setVisible(false)
    otherwise
        thisPanel.showOpenGenieItems();
end


