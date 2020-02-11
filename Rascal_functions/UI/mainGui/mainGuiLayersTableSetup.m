function table = mainGuiLayersTableSetup()

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

problem = getappdata(0,'problem');
headings = {'Layer Name','Thickness','SLD','Roughness','%Hydr','Hydrate with'};
rows = problem.numberOfLayers;
names = problem.paramnames;
lDetails = problem.layersDetails;

%Put all the values into an array
Vals = {};
for r = 1:rows;
        Vals{r,1} = problem.layersDetails{r}{5};
% Adjustment for layers details now being doubles
%         Vals{r,2} = names{str2double(problem.layersDetails{r}{1})};
%         Vals{r,3} = names{str2double(problem.layersDetails{r}{2})};
%         Vals{r,4} = names{str2double(problem.layersDetails{r}{3})};

        Vals{r,2} = names{problem.layersDetails{r}{1}};
        Vals{r,3} = names{problem.layersDetails{r}{2}};
        Vals{r,4} = names{problem.layersDetails{r}{3}};
        if ~isempty(problem.layersDetails{r}{4})
            Vals{r,5} = names{problem.layersDetails{r}{4}};
        else
            Vals{r,5} = '';
        end
        Vals{r,6} = problem.layersDetails{r}{6};
end



%Apply the TableModel to the JTable
model = javaObjectEDT(mainGuiLayersDefaultTableModel(Vals,headings));
table = javaObjectEDT(JTable(model));

setappdata(0,'mainGuiLayersTable',table);

end