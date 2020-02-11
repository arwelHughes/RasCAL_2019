function combo = resetResolCombo(combo,problem);

resolNames = getappdata(0,'resolutionNamesList');
combo.removeAllItems();
for i = 1:length(resolNames);
    combo.addItem(resolNames{i});
end
