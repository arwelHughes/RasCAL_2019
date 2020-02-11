function table = mainGuiContrastLayersDetailsTable(problem,contrast);

import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

numberOfLayers = problem.contrastsNumberOfLayers(contrast);
layers = problem.contrastLayers(contrast);
lays = str2num(layers{:});


rows = numberOfLayers+2;
nba = problem.nbaNames;
nbs = problem.nbsNames;

headings = {'','Layers'};
Vals = {};

whichBulkIn = problem.contrastNbas(contrast);
Vals{1,1} = 'Bulk In';
Vals{1,2} = nba{whichBulkIn};

for i = 2:rows-1;
    Vals{i,1} = ' ';
    thisLayName = problem.layersDetails{lays(i-1)}{5};
    Vals{i,2} = thisLayName;
end

whichBulkOut = problem.contrastNbss(contrast);
Vals{rows,1} = 'Bulk Out';
Vals{rows,2} = nbs{whichBulkOut};

model = javaObjectEDT(mainGuiLayersDefaultTableModel(Vals,headings));
table = javaObjectEDT(JTable(model));

for i = 1:2
    column = javaObjectEDT(table.getColumnModel().getColumn(i-1));
    column.setCellRenderer(javaObjectEDT(CentreRenderer()));
end

end