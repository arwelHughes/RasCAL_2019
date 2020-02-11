function table = editGuiShiftsTableSetup(problem);


import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Qz Shift','Lower Bound','Value','Upper Bound'};

%Get all the relevant values out of problem.
min = problem.shifts_constr(:,1);
val = problem.shifts_horisontal;
max = problem.shifts_constr(:,2);
rows = length(val);
names = problem.shiftsNames;

%Put all the values into an array
for r = 1:rows;
    Vals{r,1} = names{r};
    Vals{r,2} = min(r);
    Vals{r,3} = val(r);
    Vals{r,4} = max(r);
end

%Apply the TableModel to the JTable
model = editGuiParamsDefaultTableModel(Vals,headings);

table = JTable(model);

for i = 1:3
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end



numberOfAddedShifts = rows+1;

set(model,'TableChangedCallback',@shiftsTableEdited);
setappdata(0,'editGuiShiftsTable',table);
setappdata(0,'numberOfAddedShifts',numberOfAddedShifts);
setappdata(0,'shiftsNamesList',names);

end

%________________________________________________________________________



