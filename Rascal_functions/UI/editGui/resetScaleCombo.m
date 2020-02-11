function combo = resetScaleCombo(combo,problem);

scalesNames = getappdata(0,'scalesNamesList');
combo.removeAllItems();
for i = 1:length(scalesNames);
    combo.addItem(scalesNames{i});
end
end

%__________________________________________________________________________

