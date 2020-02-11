function refChartPanel = mkReflectivityChartPanel();


myCharts = getappdata(0,'myCharts');
problem = getappdata(0,'problem');

collection = awtinvoke(myCharts,'mkXYSeriesCollection');
collection2 = awtinvoke(myCharts,'mkXYSeriesCollection');
numberOfContrasts = length(problem.data);
shiftValue = problem.dataShiftValue;

% lowest = 1;

for i = 1:numberOfContrasts
    if i>1
        mult =  10.^((i/100)*shiftValue);
    else
        mult=1;
    end
    switch problem.dataPresent(i)
        case 1
            series{i} = awtinvoke(myCharts,'mkXYSeries',problem.contrastNames{i});
            thisData = problem.shifted_data{i};
            for n = 1:length(thisData(:,1))
                %thisSeries = series{i};
                %awtinvoke(thisSeries,'add(DD)',thisData(n,1),thisData(n,2)./mult);
                
%                 if(min(thisData(n,2)./mult) < lowest)
%                     lowest = min(thisData(n,2)./mult);
%                 end
                
                series{i}.add(thisData(n,1),thisData(n,2)./mult);
            end
            awtinvoke(collection,'addSeries',series{i});
    end
    
    dataName = problem.contrastNames{i};
    dot = findstr(dataName,'.');
    if ~isequal([],dot)
        dataName = dataName(1:dot-1);
        fullName = [dataName ' fit'];
    else
        fullName = dataName;
    end
    series2{i} = awtinvoke(myCharts,'mkXYSeries',fullName);
    thisData = problem.calculations.reflectivity{i};
    for n = 1:length(thisData(:,1))                
        thisSeries = series2{i};
        %awtinvoke(thisSeries,'add(DD)',thisData(n,1),thisData(n,2)./mult);
        series2{i}.add(thisData(n,1),thisData(n,2)./mult);
    end
    awtinvoke(collection2,'addSeries',series2{i});
end

minval = 10^(-(numberOfContrasts+14));

refChartPanel = awtinvoke(myCharts,'mkRefChart',collection,collection2,'test',minval);




