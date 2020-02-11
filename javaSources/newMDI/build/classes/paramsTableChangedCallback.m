function paramsTableChangedCallback(src,ev)

disp('in the user changed callback');

row = ev.getFirstRow;
col = ev.getColumn;

problem = getappdata(0,'problem');
tableModel = getappdata(0,'paramsTableModel');

newval = tableModel.getValueAt(row,col);

row = row + 1;
switch col
    case 2;
        problem.constr(row,1) = newval;
    case 3;
        problem.params(row) = newval;
    case 4
        problem.constr(row,2) = newval;
end

setappdata(0,'problem',problem);