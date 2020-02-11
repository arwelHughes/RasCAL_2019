function updateReflectivityChart()

problem = getappdata(0,'problem');
myCharts = getappdata(0,'myCharts');
myUtils = getappdata(0,'myUtils');
numberOfContrasts = problem.numberOfContrasts;
shiftValue = problem.dataShiftValue;

pointsSeriesCounter = 0;
for i = 1:numberOfContrasts;
    thisData = problem.calculations.Simulation{i};
    if i>1
        mult = 10.^((i/100)*shiftValue);
    else
        mult=1;
    end
    thisData(:,2) = thisData(:,2)./mult;
    points = size(thisData,1);
    thisDoubleData = myUtils.convertArray(thisData,points);
    awtinvoke(myCharts,'updateTheReflSims',thisDoubleData,points-1,i-1);
    
    switch problem.dataPresent(i)
        case 1
            thisData = problem.shifted_data{i};
            thisData(:,2) = thisData(:,2)./mult;
            points = size(thisData,1);
            thisDoubleData = myUtils.convertArray(thisData,points);    
            awtinvoke(myCharts,'updateTheReflData',thisDoubleData,points-1,pointsSeriesCounter);
            pointsSeriesCounter = pointsSeriesCounter + 1;
    end
end


