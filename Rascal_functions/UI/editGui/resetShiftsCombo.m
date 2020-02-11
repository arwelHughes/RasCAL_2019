function combo = resetShiftsCombo(combo,problem);

shiftsNames = getappdata(0,'shiftsNamesList');
combo.removeAllItems();
for i = 1:length(shiftsNames);
    combo.addItem(shiftsNames{i});
end
