function sldChart = makeErrSLDGraph();

sldGraph = bootstrapSLDChart();
Collection = sldGraph.mkXYSeriesCollection();
Series = sldGraph.mkXYSeries('');
Collection.addSeries(Series);
sldChart = sldGraph.mkbsSLDChart(Collection);

setappdata(0,'bsSLDCollection',Collection);
setappdata(0,'bsSLDGraphClass',sldGraph);

end

