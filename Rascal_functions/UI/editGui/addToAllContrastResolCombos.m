function addToAllContrastResolCombos(name)


allContrastPanels = getappdata(0,'allContrastPanels');


for i = 1:length(allContrastPanels);
    thisPanel = allContrastPanels{i};
    resolCombo = thisPanel.getResolComboBox();
    resolCombo.addItem(name);
end

allContrastPanels{i} = thisPanel;

setappdata(0,'allContrastPanels',allContrastPanels);