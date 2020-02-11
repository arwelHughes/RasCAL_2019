function bsHistComboChanged(src,ev)

import org.jfree.data.statistics.SimpleHistogramBin;

whatSelected = get(src,'SelectedIndex')+1;


dataSet = getappdata(0,'bsHistCollection');
histChartClass = getappdata(0,'bsHistGraphClass');
histChart = getappdata(0,'histChart');
bsResults = getappdata(0,'bsResults');
allTheBsParVals = bsResults.pars;%getappdata(0,'allThebsParVals');
problem = getappdata(0,'problem');


dataSet.clearObservations;
dataSet.removeAllBins;

if ~isempty(allTheBsParVals);
    newObservations = allTheBsParVals(:,whatSelected);
else
    newObservations = [];
end

constr = problem.fitconstr;
thisRange = constr(whatSelected,:);

lastEdge = thisRange(1);
step = (thisRange(2) - thisRange(1))/40;
for i = 1:40;
    b = SimpleHistogramBin(lastEdge,lastEdge+step,true,false);
    dataSet.addBin(b);
    lastEdge = lastEdge + step;
end

if ~isempty(newObservations)
    for i = 1:length(newObservations);
        dataSet.addObservation(newObservations(i));
    end
end
