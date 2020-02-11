function table = editGuiScalesTableSetup(problem);


import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Scalefactor','Lower Bound','Value','Upper Bound'};

%Get all the relevant values out of problem.
min = problem.scale_constr(:,1);
val = problem.scalefac;
max = problem.scale_constr(:,2);
rows = length(val);
names = problem.scalesNames;

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




numberOfAddedScales = rows + 1;


set(model,'TableChangedCallback',@scalesTableEdited);
setappdata(0,'editGuiScalesTable',table);
setappdata(0,'numberOfAddedScales',numberOfAddedScales);
setappdata(0,'scalesNamesList',names);

end

%________________________________________________________________________


