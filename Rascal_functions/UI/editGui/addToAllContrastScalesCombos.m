function addToAllContrastScalesCombos(name)


allContrastPanels = getappdata(0,'allContrastPanels');


for i = 1:length(allContrastPanels);
    thisPanel = allContrastPanels{i};
    scalesCombo = thisPanel.getScalefacComboBox();
    scalesCombo.addItem(name);
end

allContrastPanels{i} = thisPanel;

setappdata(0,'allContrastPanels',allContrastPanels);