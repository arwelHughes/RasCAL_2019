function removeFromAllContrastResolCombos(name)


allContrastPanels = getappdata(0,'allContrastPanels');


for i = 1:length(allContrastPanels);
    thisPanel = allContrastPanels{i};
    resolCombo = thisPanel.getResolComboBox();
    resolCombo.removeItem(name);
end

allContrastPanels{i} = thisPanel;

setappdata(0,'allContrastPanels',allContrastPanels);