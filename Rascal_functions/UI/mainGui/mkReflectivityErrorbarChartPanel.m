function refChartPanel = mkReflectivityErrorbarChartPanel()


myCharts = getappdata(0,'myCharts');
problem = getappdata(0,'problem');

Intervalcollection = awtinvoke(myCharts,'mkXYIntervalSeriesCollection');
collection2 = awtinvoke(myCharts,'mkXYSeriesCollection');
numberOfContrasts = length(problem.data);
shiftValue = problem.dataShiftValue;


for i = 1:numberOfContrasts
    if i>1
        mult =  10.^((i/100)*shiftValue);
    else
        mult=1;
    end
    switch problem.dataPresent(i)
        case 1
            %series{i} = javaObjectEDT(myCharts.mkIntervalXY(problem.contrastNames{i}));
            series{i} = awtinvoke(myCharts,'mkIntervalXY',problem.contrastNames{i});
            thisData = problem.shifted_data{i};
            for n = 1:length(thisData(:,1))
                x = thisData(n,1);
                y = thisData(n,2);
                e = thisData(n,3);
                xlo = x;
                xhi = x;
                ylo = y-e;
                yhi = y+e;
                ytot = [y ylo yhi] ./ mult;
                all = [x,xlo,xhi,ytot(1),ytot(2),ytot(3)];
                if isempty(find(all <= 0))
                    series{i}.add(x,xlo,xhi,ytot(1),ytot(2),ytot(3));
                    %drawnow;
                else
                    addInfoText('Zero ignored');
                end
            end
            awtinvoke(Intervalcollection,'addSeries',series{i});
            %drawnow;
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
        %awtinvoke(series2,'add(DD)',thisData(n,1),thisData(n,2)./mult);
        series2{i}.add(thisData(n,1),thisData(n,2)./mult);
    end
    awtinvoke(collection2,'addSeries',series2{i});
end

minval = 10^(-(numberOfContrasts+7));

refChartPanel = awtinvoke(myCharts,'mkRefErrorBarChart',Intervalcollection,collection2,'test',minval);
%refChartPanel = awtinvoke(myCharts,'mkRefErrorBarChart',Intervalcollection,collection2,'test',minval);




