function simQMaxChanged(src,ev)

problem = getappdata(0,'problem');

%accessible = get(src,'AccessibleContext');
whichContrast = getappdata(src,'UserData');

dataThere = problem.include_data(whichContrast); 
oldDataRanges = problem.dataLimits{whichContrast};
oldSimRanges = problem.simLimits{whichContrast};
thisData = problem.data{whichContrast};

details = get(src,'ActionPerformedCallbackData');
value = awtinvoke(details,'getActionCommand');


if strcmp(value,'max')
    OK = 1;
    val = problem.data{whichContrast}(end,1);
    set(src,'Text',num2str(val));
else
    [val,OK] = str2num(value);
end
if (OK == 0)
    addInfoText('Must be numeric');
    set(src,'Text',num2str(oldSimRanges(2)));
    return
end

if (val <= oldSimRanges(1))
    addInfoText('Sim min value must be less than max value');
    set(src,'Text',num2str(oldSimRanges(2)));
    return
end

if (val < oldDataRanges(2)) && (dataThere == 1)
    addInfoText('Data range must be within sim range')
    set(src,'Text',num2str(oldSimRanges(2)));
    return
end

problem.simLimits{whichContrast}(2) = val;

if (strcmp(problem.contrastTypes{whichContrast},'Simulation'))
    problem = setupSimulation(problem,whichContrast);
end

setappdata(0,'problem',problem);
rsafeCalcAndPlot();