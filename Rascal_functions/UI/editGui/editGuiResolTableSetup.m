function table = editGuiResolTableSetup(problem);


import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Name','Lower Bound','Value','Upper Bound'};

%Get all the relevant values out of problem.
min = problem.resolution_constr(:,1);
val = problem.resolution;
max = problem.resolution_constr(:,2);
rows = length(val);
names = problem.resolNames;


%Put all the values into an array
for r = 1:rows;
    %names = ['Nb out ' num2str(r)];
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



numberOfAddedResols = rows+1;


set(model,'TableChangedCallback',@resolutionTableEdited);
setappdata(0,'editGuiResolTable',table);
setappdata(0,'resolutionNamesList',names);
setappdata(0,'numberOfAddedResols',numberOfAddedResols);
end


%________________________________________________________________________

