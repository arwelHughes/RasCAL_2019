function paramsPanel = paramsPanelSetup()

problem = getappdata(0,'problem');

paramsPanel = editParams();
paramsScrollPane = paramsPanel.GetParamsTableScrollPane();
paramsTable = editGuiParamsTableSetup(problem);
paramsScrollPane.setViewportView(paramsTable);

addParamsButton = paramsPanel.GetParamsAddButton();
set(addParamsButton,'ActionPerformedCallback',@addParamsButtonCallback);

removeParamsButton = paramsPanel.GetParamsRemoveButton();
set(removeParamsButton,'ActionPerformedCallback',@removeParamsButtonCallback);

numberOfAddedParams = 0;
setappdata(0,'numberOfAddedParams',numberOfAddedParams);

end
%_________________________________________________________________________

