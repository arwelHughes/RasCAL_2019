function updateSLDChart()

problem = getappdata(0,'problem');
myCharts = getappdata(0,'myCharts');
myUtils = getappdata(0,'myUtils');
numberOfContrasts = problem.numberOfContrasts;

for i = 1:numberOfContrasts;
    thisData = problem.calculations.slds{i};
    points = size(thisData,1);
    thisDoubleData = myUtils.convertArray(thisData,points);
    awtinvoke(myCharts,'updateTheSLDs',thisDoubleData,points-1,i-1);
end

drawnow;