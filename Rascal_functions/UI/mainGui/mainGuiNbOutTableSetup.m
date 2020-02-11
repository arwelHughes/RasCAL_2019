function table = mainGuiNbOutTableSetup(problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Fit?','Nb Bulk In Name','Lower Bound','Value','Upper Bound'};
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;


%Get all the relevant values out of problem.
checks = problem.nbsubs_fityesno;
names = problem.nbsNames;
min = problem.nbsubs_constr(:,1);
val = problem.nbs;
max = problem.nbsubs_constr(:,2);
rows = length(val);

%Put all the values into an array
for r = 1:rows
    if checks(r) == 1
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals{r,2} = names{r};
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
end

%Apply the TableModel to the JTable
model = javaObjectEDT(mainGuiParamsDefaultTableModel(Vals,headings));
table = javaObjectEDT(JTable(model));

for i = 2:4
    aColumn = javaObjectEDT(table.getColumnModel().getColumn(i));
    rend = javaObjectEDT(numberTableCellRenderer());
    aColumn.setCellRenderer(rend);
end


set(model,'TableChangedCallback',@mainGuiNbOutTableEditedCallback);
setappdata(0,'mainGuiNbssTable',table);
setappdata(0,'mainGuiNbssTableModel',model);

end

%______________________________________________________________________

