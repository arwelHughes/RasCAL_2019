function cboxremoveItem(name)

layersTableItems = getappdata(0,'layersTableItems');
if isempty(layersTableItems)
    return
end
model = layersTableItems.model;
cBox = layersTableItems.cBox;
%awtinvoke(cBox,'removeItem(C)',name);
cBox.removeItem(name);
pause(0.1);

rows = model.getRowCount();
cols = model.getColumnCount();
for n = 0:rows-1;
    for m = 0:cols-1;
        here = model.getValueAt(n,m);
        if strcmp(here,name)
            model.setValueAt('',n,m);
        end
    end
end

layersTableItems.model = model;
layersTableItems.cBox = cBox;
setappdata(0,'layersTableItems',layersTableItems);
end

%__________________________________________________________________________

