function removeParamsButtonCallback(src,ev);

problem = getappdata(0,'problem');
table = getappdata(0,'editGuiParamsTable');
paramsNamesList = getappdata(0,'paramsNamesList');
model = table.getModel();

selected = table.getSelectedRows();
if strcmp(problem.module.type,'Standard Layers');
    if any(find(selected == 0));
        addInfoText('First parameter must be substrate roughness in srandard layer model. Cant remove this row');
        beep
        return
    end
end

while (~isempty(selected));
    switch problem.module.type
        case 'Standard Layers'
            parameterToRemove = model.getValueAt(selected(1),0);
            cboxremoveItem(parameterToRemove);
            pause(0.1);
    end
    paramsNamesList = [paramsNamesList(1:selected(1)) paramsNamesList(selected(1)+2:end)];
    awtinvoke(model,'removeRow(I)',selected(1));
    %model.removeRow(selected(1));
    selected = awtinvoke(table,'getSelectedRows')
    %selected = table.getSelectedRows();
end

setappdata(0,'problem',problem);
setappdata(0,'paramsNamesList',paramsNamesList);
end



%_________________________________________________________________________
