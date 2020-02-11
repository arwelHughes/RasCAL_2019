function table = mainGuiTableSetup(problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Parameter Name','Value','Lower Bound','Upper Bound','Prior type','mu','sig'};
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

priors = problem.priors;% priors = problem.priors;
for i = 1:length(priors)
    allPriorNames{i} = priors{i,1}{1};
end

%Put all the values into an array
for r = 1:rows
    % Check if the parameters exist in the
    % priors array. Set the mu and sig from this
    % array if so
    Vals{r,1} = names{r};
    Vals{r,2} = val(r);
    Vals{r,3} = min(r);
    Vals{r,4} = max(r);
    Vals{r,5} = 'Gaussian';
    where = find(strcmp(allPriorNames,names{r}));
    if ~isempty(where)
        thisRow = priors{where};
        Vals{r,6} = thisRow{5};
        Vals{r,7} = thisRow{6};
    else
        Vals{r,6} = 0;
        Vals{r,7} = inf;
    end
end

%Apply the TableModel to the JTable
model = bayesGuiMainTableModel(Vals,headings);
table = JTable(model);

numCols = [1 2 3 5 6];
for i = 1:length(numCols)
    thisCol = numCols(i);
    aColumn = table.getColumnModel().getColumn(numCols(i));
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
 end

%set(model,'TableChangedCallback',@mainGuiBacksTableEditedCallback);
setappdata(0,'mainbayesBacksTable',table);

end


