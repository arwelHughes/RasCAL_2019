function changeContrastLayersTablesForCustom()

panels = getappdata(0,'allContrastPanels');
tables = getappdata(0,'allContrastTables');
problem = getappdata(0,'problem');

for contrast = 1:length(panels);
    thisPanel = panels{contrast};
    scrollPane = thisPanel.getLayersDetailsScrollPane();
    thisTable = setupCustomLayersTable(problem,contrast);
    scrollPane.setViewportView(thisTable);
    tables{contrast} = thisTable;
    panels{contrast} = thisPanel;
    thisPanel.disableLayersItems();
end



setappdata(0,'allContrastPanels',panels);
setappdata(0,'allContrastTables',tables);


