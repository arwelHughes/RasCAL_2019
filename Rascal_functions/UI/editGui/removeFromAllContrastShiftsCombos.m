function removeFromAllContrastShiftsCombos(name)


allContrastPanels = getappdata(0,'allContrastPanels');


for i = 1:length(allContrastPanels);
    thisPanel = allContrastPanels{i};
    shiftsCombo = thisPanel.getShiftComboBox();
    shiftsCombo.removeItem(name);
end

allContrastPanels{i} = thisPanel;

setappdata(0,'allContrastPanels',allContrastPanels);