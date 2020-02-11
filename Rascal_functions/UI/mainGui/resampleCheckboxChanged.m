function resampleCheckboxChanged(src,ev)

problem = getappdata(0,'problem');
resample = problem.resample;

%accessible = get(src,'AccessibleContext');
whichContrast = getappdata(src,'UserData');

selected = get(src,'Selected');
if selected
    problem.resample(whichContrast) = 1;
else
    problem.resample(whichContrast) = 0;
end

setappdata(0,'problem',problem);
rsafeCalcAndPlot();

