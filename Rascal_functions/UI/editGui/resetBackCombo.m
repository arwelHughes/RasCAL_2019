function combo = resetBackCombo(combo,problem);

backsNames = getappdata(0,'backsNamesList');
numberOfBacks = length(backsNames);
combo.removeAllItems();
for i = 1:numberOfBacks;
    combo.addItem(backsNames{i});
end


