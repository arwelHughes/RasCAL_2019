function turnOnQ4

problem = getappdata(0,'problem');
problem.q4 = 'yes';
problem = backsorts(problem);
setappdata(0,'problem',problem);

mycharts = getappdata(0,'myCharts');
% refChart = mycharts.getRefChart();
% plot = refChart.getPlot();
% ax = plot.getRangeAxis;
% ax.setRange(9.999930978337379E-4,0.0010000402194914179);
reflectivity_calculation();
updateTheGraphs()

