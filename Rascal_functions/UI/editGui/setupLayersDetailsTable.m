function table = setupLayersDetailsTable(problem,contrast);

import javax.swing.DefaultCellEditor;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JComboBox;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;

numberOfLayers = problem.contrastsNumberOfLayers(contrast);
layers = problem.contrastLayers(contrast);
lays = str2num(layers{:});
rows = length(lays);
cols = 1;
nba = problem.nbaNames;
nbs = problem.nbsNames;

contrastEditPanelTablesCombos = getappdata(0,'contrastEditPanelTablesCombos');


bulkInComboBox = contrastEditPanelTablesCombos.bulkIn;
bulkOutComboBox = contrastEditPanelTablesCombos.bulkOut;
layersComboBox = contrastEditPanelTablesCombos.layers;

cellEditorBulk1 = DefaultCellEditor(bulkInComboBox);
cellEditorBulk2 = DefaultCellEditor(bulkOutComboBox);
cellEditorLayers = DefaultCellEditor(layersComboBox);

table = JTableCbBox(rows+2,2,cellEditorBulk1,cellEditorBulk2,cellEditorLayers);
table.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
model = table.getModel;


theseLayers = str2num(problem.contrastLayers{contrast});
for i = 1:length(theseLayers)
    layerName = problem.layersDetails{theseLayers(i)}(5);
    model.setValueAt(java.lang.String(layerName),i,1);
    model.setValueAt(java.lang.String('Layer'),i,0);
end

whichBulkIn = problem.contrastNbas(contrast);
model.setValueAt(java.lang.String(nba{whichBulkIn}),0,1);
model.setValueAt(java.lang.String('Bulk in'),0,0);

whichBulkOut = problem.contrastNbss(contrast);
model.setValueAt(java.lang.String(nbs{whichBulkOut}),rows+1,1);
model.setValueAt(java.lang.String('Bulk Out'),rows+1,0);

end

