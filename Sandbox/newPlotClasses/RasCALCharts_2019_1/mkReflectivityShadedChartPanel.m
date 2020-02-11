function refChartPanel = mkReflectivityShadedChartPanel(bayesResults)


myCharts = getappdata(0,'myCharts');
problem = getappdata(0,'problem');

debug = 1;
switch debug
    case 1
        figure(1); 
        clf;
        set(gca,'YScale','log');
        hold on;
end

pointsIntervalcollection = awtinvoke(myCharts,'mkXYIntervalSeriesCollection');        %This is the errorbar series collection..
linesXYCollection = awtinvoke(myCharts,'mkXYSeriesCollection');       %This is the fitted lines series collection...
shadingIntervalCollection = awtinvoke(myCharts,'mkXYIntervalSeriesCollection');         %This is the confidence interval series collection
numberOfContrasts = length(problem.data);

shiftValue = problem.dataShiftValue;

%Make the errorbar and fit series
for i = 1:numberOfContrasts
    if i>1
        mult =  10.^((i/100)*shiftValue);
    else
        mult=1;
    end
    switch problem.dataPresent(i)
        case 1
            series{i} = awtinvoke(myCharts,'mkIntervalXY',problem.contrastNames{i}); %Make a new Interval Series
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
                else
                    %addInfoText('Zero ignored');
                    disp('zero');
                end
            end
            awtinvoke(pointsIntervalcollection,'addSeries',series{i}); %Add this to the series collection
    end
    
    dataName = problem.contrastNames{i};
    dot = findstr(dataName,'.');
    if ~isequal([],dot)
        dataName = dataName(1:dot-1);
        fullName = [dataName ' fit'];
    else
        fullName = dataName;
    end
    series2{i} = awtinvoke(myCharts,'mkXYSeries',fullName); %New lines series
    thisData = problem.calculations.reflectivity{i};
    for n = 1:length(thisData(:,1))
        series2{i}.add(thisData(n,1),thisData(n,2)./mult);
    end
    
    switch debug
        case 1
            plot(thisData(:,1),thisData(:,2)./mult);
    end    
    awtinvoke(linesXYCollection,'addSeries',series2{i}); %Add this to the series collection.
end


%Now need to make the shading series and add them to the collection...
for i = 1:numberOfContrasts
    if i>1
        mult =  10.^((i/100)*shiftValue);
    else
        mult=1;
    end
    shadingSeries{i} = awtinvoke(myCharts,'mkIntervalXY',problem.contrastNames{i}); %Make a new Interval Series
    thisData = bayesResults.data{i};
    thisBayesMin = bayesResults.refBounds{1}{i};
    thisBayesMax = bayesResults.refBounds{2}{i};
    for n = 1:length(thisData(:,1))
        x = thisData(n,1);
        y = thisData(n,2);
        xlo = x;
        xhi = x;
        ylo = thisBayesMin(n);
        yhi = thisBayesMax(n);
        ytot = [y ylo yhi] ./ mult;
        all = [x,xlo,xhi,ytot(1),ytot(2),ytot(3)];
        if isempty(find(all <= 0))
            shadingSeries{i}.add(x,xlo,xhi,ytot(1),ytot(2),ytot(3));
        else
            addInfoText('Zero ignored');
        end
    end
    switch debug
        case 1
            plot(thisData(:,1),thisBayesMin./mult,'r-');
            plot(thisData(:,1),thisBayesMax./mult,'r-');
    end     
    awtinvoke(shadingIntervalCollection,'addSeries',shadingSeries{i});
end

minval = 10^(-(numberOfContrasts+7));

refChartPanel = awtinvoke(myCharts,'mkRefShadedChart',pointsIntervalcollection,...
    linesXYCollection,shadingIntervalCollection,'test',minval, numberOfContrasts);

end


