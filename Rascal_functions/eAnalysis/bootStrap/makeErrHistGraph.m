function histChart = makeErrHistGraph();

histChartClass = ErrorsHistogramChart();
dataSet = histChartClass.makeIntervalXYDataset();
%dataSet.addSeries(java.lang.String(''),[1],10);
histChart = histChartClass.MakeErrorsHistogramChart(dataSet);

setappdata(0,'bsHistCollection',dataSet);
setappdata(0,'bsHistGraphClass',histChartClass);
setappdata(0,'histChart',histChart);

end

