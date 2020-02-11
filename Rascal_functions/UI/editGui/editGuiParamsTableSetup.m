function table = editGuiParamsTableSetup(problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Parameter Name','Lower Bound','Value','Upper Bound'};

%Get all the relevant values out of problem.
names = problem.paramnames;
min = problem.constr(:,1);
val = problem.params;
max = problem.constr(:,2);
rows = length(problem.params);

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


set(model,'TableChangedCallback',@paramsTableEdited);
setappdata(0,'editGuiParamsTable',table);
setappdata(0,'editGuiParamsTableModel',model);
setappdata(0,'paramsNamesList',names);

end

%______________________________________________________________________

