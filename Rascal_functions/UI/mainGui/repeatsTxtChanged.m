function repeatsTxtChanged(src,ev)

problem = getappdata(0,'problem');
%accessible = get(src,'AccessibleContext');
whichContrast = getappdata(h,'UserData');

details = get(src,'ActionPerformedCallbackData');
value = awtinvoke(details,'getActionCommand');

val = str2double(value);

if ~isinteger(val)
    val = round(val);
end

if val > 100
    val = 100;
elseif val <= 0
    val = 1;
end

set(src,'Text',num2str(val));

problem.repeatLayers{whichContrast}(2) = val;

setappdata(0,'problem',problem);
reflectivity_calculation();
rJavaUpdatePlots();

    




