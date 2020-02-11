function mainGuiNbInTableEditedCallback(src,ev)


row = ev.getFirstRow;
col = ev.getColumn;

problem = getappdata(0,'problem');
table = getappdata(0,'mainGuiNbasTable');

fromWhere = getappdata(table,'UserData');
if strcmpi(fromWhere,'Updating From Code')
    return
end

tableModel = table.getModel();

newval = tableModel.getValueAt(row,col);

row = row + 1;
switch col
    case 2
        problem.nbairs_constr(row,1) = newval;
    case 3
        problem.nba(row) = newval;
    case 4
        problem.nbairs_constr(row,2) = newval;
end

setappdata(0,'problem',problem);

if (col==3 && (strcmpi(fromWhere,'Ok') || isempty(fromWhere)))
   reflectivity_calculation();
   rJavaUpdatePlots();
   drawnow limitrate
end










%__________________________________________________________________________