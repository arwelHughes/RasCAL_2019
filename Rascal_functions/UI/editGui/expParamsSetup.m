function thePanel = expParamsSetup()

problem = getappdata(0,'problem');

thePanel = expParams();


backsScrollPane = thePanel.getBacksScrollPane();
backsTable = editGuiBacksTableSetup(problem);
backsScrollPane.setViewportView(backsTable);
backsAddButton = thePanel.getBacksAddButton();
backsRemoveButton = thePanel.getBacksRemoveButton();
set(backsAddButton,'ActionPerformedCallback',@backsAddButtonCallback);
set(backsRemoveButton,'ActionPerformedCallback',@backsRemoveButtonCallback);


scaleFactorsScrollPane = thePanel.getScalesScrollPane();
scalesTable = editGuiScalesTableSetup(problem);
scaleFactorsScrollPane.setViewportView(scalesTable);
scalesAddButton = thePanel.getScalesAddButton();
scalesRemoveButton = thePanel.getScalesRemoveButton();
set(scalesAddButton,'ActionPerformedCallback',@scalesAddButtonCallback);
set(scalesRemoveButton,'ActionPerformedCallback',@scalesRemoveButtonCallback);


shiftsScrollPane = thePanel.getShiftsScrollPane();
shiftsTable = editGuiShiftsTableSetup(problem);
shiftsScrollPane.setViewportView(shiftsTable);
shiftsAddButton = thePanel.getShiftsAddButton();
shiftsRemoveButton = thePanel.getShiftsRemoveButton();
set(shiftsAddButton,'ActionPerformedCallback',@shiftsAddButtonCallback);
set(shiftsRemoveButton,'ActionPerformedCallback',@shiftsRemoveButtonCallback);


nbairsScrollPane = thePanel.getNbaScrollPane();
nbaTable = editGuiNbaTableSetup(problem);
nbairsScrollPane.setViewportView(nbaTable);
nbaAddButton = thePanel.getNbaAddButton();
nbaRemoveButton = thePanel.getNbaRemoveButton();
set(nbaAddButton,'ActionPerformedCallback',@nbasAddButtonCallback);
set(nbaRemoveButton,'ActionPerformedCallback',@nbasRemoveButtonCallback);

nbsubsScrollPane = thePanel.getNbsScrollPane();
nbsTable = editGuiNbsTableSetup(problem);
nbsubsScrollPane.setViewportView(nbsTable);
nbsAddButton = thePanel.getNbsAddButton();
nbsRemoveButton = thePanel.getNbsRemoveButton();
set(nbsAddButton,'ActionPerformedCallback',@nbsAddButtonCallback);
set(nbsRemoveButton,'ActionPerformedCallback',@nbsRemoveButtonCallback);

resolScrollPane = thePanel.getResolutionScrollPane();
resolTable = editGuiResolTableSetup(problem);
resolScrollPane.setViewportView(resolTable);
resolAddButton = thePanel.getResolAddButton();
resolRemoveButton = thePanel.getResolRemoveButton();
set(resolAddButton,'ActionPerformedCallback',@resolAddButtonCallback);
set(resolRemoveButton,'ActionPerformedCallback',@resolRemoveButtonCallback);

end

%__________________________________________________________________________

