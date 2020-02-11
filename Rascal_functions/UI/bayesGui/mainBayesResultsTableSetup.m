function table = mainBayesResultsTableSetup(problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Parameter Name','Best Value','95% CI','65% CI','25% CI'};
% check_on = java.lang.Boolean.TRUE;
% check_off = java.lang.Boolean.FALSE;


%Get all the relevant values out of problem.
problem = getappdata(0,'problem');
names = problem.fitNames;
%checks = ones(length(names));
val = problem.fitpars;
min = problem.fitconstr(:,1);
max = problem.fitconstr(:,2);
rows = length(names);

% names = output.names;
% checks = ones(length(names));%output.fityesno;
% min = output.limits(:,1);
% val = output.results.mean;
% max = output.limits(:,2);
% rows = length(val);

%Put all the values into an array
for r = 1:rows
%     if checks(r) == 1;
%         Vals{r,1} = check_on;
%     else
%         Vals{r,1} = check_off;
%     end
    Vals{r,1} = names{r};
    Vals{r,2} = val(r);
    Vals{r,3} = 'Not Set';
    Vals{r,4} = 'Not Set';
    Vals{r,5} = 'Not Set';
end

%Apply the TableModel to the JTable
model = bayesGuiResultsTableModel(Vals,headings);
table = JTable(model);

% numCols = [1 2 3 4];
% for i = 1:length(numCols)
%     thisCol = numCols(i);
%     aColumn = table.getColumnModel().getColumn(numCols(i));
%     rend = numberTableCellRenderer();
%     aColumn.setCellRenderer(rend);
%  end

resColumn = table.getColumnModel().getColumn(1);
rend = numberTableCellRenderer();
resColumn.setCellRenderer(rend);

%set(model,'TableChangedCallback',@mainGuiBacksTableEditedCallback);
setappdata(0,'mainBayesResultsTable',table);

end


