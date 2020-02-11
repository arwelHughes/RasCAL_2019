function paramsPanel = mainGuiParamsPanelSetup();


problem = getappdata(0,'problem');

paramsPanel = javaObjectEDT(mainParamsPanel());
paramsScrollPane = javaObjectEDT(paramsPanel.getMainParamsTableScrollPane());
paramsTable = mainGuiParamsTableSetup(problem);
paramsScrollPane.setViewportView(paramsTable);

checkAllButton = paramsPanel.getMainParamsCheckAllButton();
h = handle(checkAllButton,'CallbackProperties');set(h,'ActionPerformedCallback',@checkUnCheckParams);

end






