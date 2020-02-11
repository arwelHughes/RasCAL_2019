function setHistGraphForParam(p,problem);

import org.jfree.data.statistics.SimpleHistogramBin;

dataSet = getappdata(0,'bsHistCollection');
histChartClass = getappdata(0,'bsHistGraphClass');
histChart = getappdata(0,'histChart');

constr = problem.fitconstr;
thisRange = constr(p,:);

lastEdge = thisRange(1);
step = (thisRange(2) - thisRange(1))/40;
for i = 1:40;
    b = SimpleHistogramBin(lastEdge,lastEdge+step,true,false);
    dataSet.addBin(b);
    lastEdge = lastEdge + step;
end

