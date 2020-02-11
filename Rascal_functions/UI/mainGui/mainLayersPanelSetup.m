function layersPanel = mainLayersPanelSetup();

problem = getappdata(0,'problem');

layersPanel = javaObjectEDT(mainGuiLayersPanel());
layersScrollPane = javaObjectEDT(layersPanel.getJScrollPane1());
layersTable = mainGuiLayersTableSetup();
layersScrollPane.setViewportView(layersTable);


%_________________________________________________________________________

