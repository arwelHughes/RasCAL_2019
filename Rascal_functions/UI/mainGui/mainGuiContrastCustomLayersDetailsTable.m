function table = mainGuiContrastCustomLayersDetailsTable(problem,contrast);

import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

nba = problem.nbaNames;
nbs = problem.nbsNames;

headings = {'','Layers'};
Vals = {};

whichBulkIn = problem.contrastNbas(contrast);
Vals{1,1} = 'Bulk In';
Vals{1,2} = nba{whichBulkIn};

Vals{2,1} = '';
Vals{2,2} = 'Custom';

whichBulkOut = problem.contrastNbss(contrast);
Vals{3,1} = 'Bulk Out';
Vals{3,2} = nbs{whichBulkOut};

model = javaObjectEDT(mainGuiLayersDefaultTableModel(Vals,headings));
table = javaObjectEDT(JTable(model));

for i = 1:2
    column = javaObjectEDT(table.getColumnModel().getColumn(i-1));
    column.setCellRenderer(javaObjectEDT(CentreRenderer()));
end

end