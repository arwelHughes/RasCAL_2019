function layersPanel = layersPanelSetup();

problem = getappdata(0,'problem');

layersPanel = editLayers();
layersScrollPane = layersPanel.getLayersTableScrollPane();
%switch problem.module.type
    %case {'Standard Layers'
        layersTable = editGuiLayersTableSetup(problem);
        layersScrollPane.setViewportView(layersTable);
%end

addLayersButton = layersPanel.getAddLayersButton();
set(addLayersButton,'ActionPerformedCallback',@addLayersButtonCallback);

removeLayersButton = layersPanel.getRemoveLayersButton();
set(removeLayersButton,'ActionPerformedCallback',@removeLayersButtonCallback);

end

%_________________________________________________________________________

