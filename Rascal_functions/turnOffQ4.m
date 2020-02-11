function turnOnQ4

problem = getappdata(0,'problem');
problem.q4 = 'no';
problem = backsorts(problem);
setappdata(0,'problem',problem);

mycharts = getappdata(0,'myCharts');
refChart = mycharts.getRefChart();
plot = refChart.getPlot();
ax = plot.getRangeAxis;
ax.setAutoRange(1);

reflectivity_calculation();
updateTheGraphs();
