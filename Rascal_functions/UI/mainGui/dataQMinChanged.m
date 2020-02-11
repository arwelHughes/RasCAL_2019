function dataQMinChanged(src,ev)

problem = getappdata(0,'problem');

%accessible = get(src,'AccessibleContext');
whichContrast = getappdata(src,'UserData');

dataThere = problem.include_data(whichContrast); 
oldDataRanges = problem.dataLimits{whichContrast};
oldSimRanges = problem.simLimits{whichContrast};
thisData = problem.data{whichContrast};

details = get(src,'ActionPerformedCallbackData');
value = awtinvoke(details,'getActionCommand');

if strcmp(value,'min')
    OK = 1;
    val = problem.data{whichContrast}(1,1);
    set(src,'Text',num2str(val));
else
    [val,OK] = str2num(value);
end

if (OK == 0)
    addInfoText('Must be numeric');
    set(src,'Text',num2str(oldDataRanges(1)));
    return
end

if (val > thisData(end,1) || (val >= oldDataRanges(2)) || (val < thisData(1,1))) 
    addInfoText('Invalid data range');
    set(src,'Text',num2str(oldDataRanges(1)));
    return
end

if (val < oldSimRanges(1))
    addInfoText('Data range must be within sim range')
    set(src,'Text',num2str(oldDataRanges(1)));
    return
end

problem.dataLimits{whichContrast}(1) = val;
setappdata(0,'problem',problem);
rsafeCalcAndPlot();







