function window = initBootstrapWindow(problem,window)

plotsPanel = window.getBootstrapPanel;

paramsCombo = plotsPanel.getWhichParamCombo;
parnames = problem.fitNames;
for i = 1:length(parnames)
    paramsCombo.addItem(parnames{i});
end

sldGraph = makeErrSLDGraph();
histGraph = makeErrHistGraph();
bsTable = makeBsTable(problem);

setHistGraphForParam(1,problem);

sldPanel = plotsPanel.getBsSLDPanel();
sldPanel.add(sldGraph,java.awt.BorderLayout.CENTER);

histPanel = plotsPanel.getBsBarPanel();
histPanel.add(histGraph,java.awt.BorderLayout.CENTER);

bsScrollPane = plotsPanel.getBsTableScrollPane();
bsScrollPane.add(bsTable);
bsScrollPane.setViewportView(bsTable);

bsStartButton = plotsPanel.getBsStartButton;
set(bsStartButton,'ActionPerformedCallback',@runBSAnalysis);

set(paramsCombo,'ActionPerformedCallback',@bsHistComboChanged);

setappdata(0,'bsSLDGraph',sldGraph);
setappdata(0,'bsHistGraph',histGraph);
setappdata(0,'bsPanel',plotsPanel);
setappdata(0,'paramsCombo',paramsCombo);

%--------------------------------------------------------------------------

function table = makeBsTable(problem);

import javax.swing.JTable;

names = problem.fitNames;
vals = problem.fitpars;

rows = length(names);
for i = 1:rows;
    Vals{i,1} = names{i};
    Vals{i,2} = vals(i);
    Vals{i,3} = '';
end

Headings = {'Parameter' , 'Best Fit Value' , 'Bootstrap Error Estimate'};

model = bsTableModel(Vals,Headings);
table = JTable(model);

for i = 1:2
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end


setappdata(0,'bsErrorTable',table);
    