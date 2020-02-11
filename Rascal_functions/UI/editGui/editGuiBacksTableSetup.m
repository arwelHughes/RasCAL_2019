function table = editGuiBacksTableSetup(problem);


import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Background','Lower Bound','Value','Upper Bound'};

%Get all the relevant values out of problem.
min = problem.backs_constr(:,1);
val = problem.backs;
max = problem.backs_constr(:,2);
rows = length(val);
names = problem.backsNames;

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

numberOfAddedBacks = rows+1;
set(model,'TableChangedCallback',@backsTableEdited);

setappdata(0,'editGuiBacksTable',table);
setappdata(0,'numberOfAddedBacks',numberOfAddedBacks);
setappdata(0,'backsNamesList',names);
end


%________________________________________________________________________

