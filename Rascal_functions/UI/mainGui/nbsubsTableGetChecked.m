function checks = nbsubsTableGetChecked();


table = getappdata(0,'mainGuiNbssTable');
tableModel = table.getModel;
rows = tableModel.getRowCount;

for r = 1:rows;
    thisCheck = tableModel.getValueAt(r-1,0);
    if isequal(thisCheck,false)
        checks(r) = 0;
    else
        checks(r) = 1;
    end
end
