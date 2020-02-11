function mySLDChart = mkSLDChartPanel()

myCharts = getappdata(0,'myCharts');
problem = getappdata(0,'problem');


collection = javaObjectEDT(myCharts.mkXYSeriesCollection());
numberOfContrasts = problem.numberOfContrasts;

for i = 1:numberOfContrasts
    series{i} = javaObjectEDT(myCharts.mkXYSeries(problem.contrastNames{i}));
    thisData = problem.calculations.slds{i};
    for n = 1:length(thisData(:,1))
        series{i}.add(thisData(n,1),thisData(n,2));
    end
    collection.addSeries(series{i});
end

mySLDChart =  javaObjectEDT(myCharts.mkSLDChart(collection));
