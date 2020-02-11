function addToAllContrastBacksCombos(name)


allContrastPanels = getappdata(0,'allContrastPanels');


for i = 1:length(allContrastPanels);
    thisPanel = allContrastPanels{i};
    backsCombo = thisPanel.getBackgroundComboBox();
    backsCombo.addItem(name);
    allContrastPanels{i} = thisPanel;
end



setappdata(0,'allContrastPanels',allContrastPanels);