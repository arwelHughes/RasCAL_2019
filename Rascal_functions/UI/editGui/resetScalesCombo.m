function combo = resetScalesCombo(combo,problem);

numberOfScales = problem.numberOfScales;
scalesNames = problem.scalesNames;
combo.removeAllItems();
for i = 1:numberOfScales;
    combo.addItem(scalesNames{i});
end


