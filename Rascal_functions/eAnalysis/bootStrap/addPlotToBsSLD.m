function addPlotToBsSLD(data);

coll = getappdata(0,'bsSLDCollection');
sldGraph = getappdata(0,'bsSLDGraphClass');

newSeries = sldGraph.mkXYSeries('');

for i = 1:length(data(:,1))
    newSeries.add(data(i,1),data(i,2));
end

coll.addSeries(newSeries);

end