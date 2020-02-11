function repeatsBoxChecked(src,ev)

problem = getappdata(0,'problem');

%accessible = get(src,'AccessibleContext');
whichContrast = getappdata(src,'UserData');
whatHappened = get(src,'Selected');

thePanels = getappdata(0,'allMainGuiContrastPanels');
thisPanel = thePanels{whichContrast};
thisTextBox = thisPanel.getRepeatLayersTextBox();

if strcmp(whatHappened,'on');
    thisTextBox.setEnabled(true);
    problem.repeatLayers{whichContrast}(1) = 1;
else
    thisTextBox.setEnabled(false);
    problem.repeatLayers{whichContrast}(1) = 0;
end

thePanels{whichContrast} = thisPanel;
setappdata(0,'allMainGuiContrastPanels',thePanels);
setappdata(0,'problem',problem);
reflectivity_calculation();
rJavaUpdatePlots();


