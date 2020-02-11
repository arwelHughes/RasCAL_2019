function window = makeMonovariateTab(problem,window);

import java.awt.BorderLayout;

pListBox = window.getParsComboBox();
for i = 1:length(problem.fitNames);
    pListBox.addItem(problem.fitNames{i});
end

pListBox.setSelectedIndex(0);
set(pListBox,'ActionPerformedCallback',@newParSelected);

chart = makeCutThroughsChart(problem);
thePanel = window.getCutThroughsPanel();
thePanel.setLayout(BorderLayout);
panelSize = thePanel.getSize();
thePanel.add(chart,BorderLayout.CENTER);
chart.setSize(panelSize);

setappdata(0,'cutThroughsChartPanel',chart);

end

%--------------------------------------------------------------------------

function chart = makeCutThroughsChart(problem)

cutsChart = cutThroughsGraph();
thisData = makeCutThroughData(problem,1);

collection = cutsChart.mkXYSeriesCollection();
series = cutsChart.mkXYSeries('');

for n = 1:length(thisData(:,1));
    series.add(thisData(n,1),thisData(n,2));
end
collection.addSeries(series);

collection2 = cutsChart.mkXYSeriesCollection();
series2 = cutsChart.mkXYSeries('');

series2.add(problem.fitpars(1),problem.calculations.sum_chi);

collection2.addSeries(series2);

chart = cutsChart.mkCutThroughsChart(collection,collection2);
setappdata(0,'cutThroughsGraph',cutThroughsGraph);

end


%--------------------------------------------------------------------------

function data = makeCutThroughData(problem,par_number);

originalProblem = problem;

fitconstr = problem.fitconstr;
fitpars = problem.fitpars;
originalPar = fitpars(par_number);
step = 0.01;
count = 1;
for i = -10:10;
    thisStep = (i*(step*originalPar));
    newPar = originalPar + thisStep;
    x(count) = newPar;
    problem.fitpars(par_number) = newPar;
    problem = unpackparams(problem);
    setappdata(0,'problem',problem);
    reflectivity_calculation;
    problem = getappdata(0,'problem');
    thisVal = problem.calculations.sum_chi;
    y(count) = thisVal;
    count = count + 1;
end

setappdata(0,'problem',originalProblem);
data = [x(:) y(:)];

end


%--------------------------------------------------------------------------

function newParSelected(src,ev)

cutThroughsGraph = getappdata(0,'cutThroughsGraph');
whichParSelected = get(src,'SelectedIndex');
problem = getappdata(0,'problem');

newData = makeCutThroughData(problem,whichParSelected+1);
points = length(newData(:,1));

thePanel  = getappdata(0,'cutThroughsChartPanel');
theChart = thePanel.getChart;
thePlot = theChart.getPlot;
linesData = thePlot.getDataset(0);
linesSeries = linesData.getSeries(0);
linesSeries.clear;
for i = 1:points;
    linesSeries.add(java.lang.Double(newData(i,1)),java.lang.Double(newData(i,2)));
end

pointsData = thePlot.getDataset(1);
pointSeries = pointsData.getSeries(0);
pointSeries.clear;

pointSeries.add(problem.fitpars(whichParSelected+1),problem.calculations.sum_chi);

end