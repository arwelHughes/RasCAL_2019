function table = setupCustomLayersTable(problem,contrast);

import javax.swing.DefaultCellEditor;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JComboBox;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;


rows = 1;
nba = problem.nbaNames;
nbs = problem.nbsNames;

contrastEditPanelTablesCombos = getappdata(0,'contrastEditPanelTablesCombos');


bulkInComboBox = contrastEditPanelTablesCombos.bulkIn;
bulkOutComboBox = contrastEditPanelTablesCombos.bulkOut;

cellEditorBulk1 = DefaultCellEditor(bulkInComboBox);
cellEditorBulk2 = DefaultCellEditor(bulkOutComboBox);

table = JTableCbBoxCustom(rows+2,2,cellEditorBulk1,cellEditorBulk2);
table.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
model = table.getModel;


model.setValueAt(java.lang.String('Custom'),1,1);
model.setValueAt(java.lang.String(''),i,0);


whichBulkIn = problem.contrastNbas(contrast);
model.setValueAt(java.lang.String(nba{whichBulkIn}),0,1);
model.setValueAt(java.lang.String('Bulk in'),0,0);

whichBulkOut = problem.contrastNbss(contrast);
model.setValueAt(java.lang.String(nbs{whichBulkOut}),rows+1,1);
model.setValueAt(java.lang.String('Bulk Out'),rows+1,0);



end

