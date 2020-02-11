function myTable =  editGuiLayersTableSetup(problem)

import javax.swing.DefaultCellEditor;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JComboBox;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.TableColumn;

layersDetails = problem.layersDetails;

myTable = JTable();
rows = problem.numberOfLayers();
cols = 6;

model = DefaultTableModel(rows,cols);
myTable.setModel(model);

pNames = problem.paramnames;
cBox = JComboBox();
cBox.addItem(java.lang.String(''));
for i = 1:length(pNames)
    cBox.addItem(java.lang.String(pNames(i)));
end

fillWithWhatCbox = JComboBox();
fillWithWhatCbox.addItem(java.lang.String('bulk in'));
fillWithWhatCbox.addItem(java.lang.String('bulk out'));

if rows == 0
    layersNames = {};
else
    for i = 1:rows;
        layersNames{i} = layersDetails{i}{5};
    end
end

set(cBox,'PropertyChangeCallback',@boxChange);

for i = 1:4;
    aColumn = myTable.getColumnModel().getColumn(i);
    aColumn.setCellEditor(DefaultCellEditor(cBox));
    renderer = DefaultTableCellRenderer();
    renderer.setToolTipText('Click to select parameter');
    aColumn.setCellRenderer(renderer);
end

aColumn = myTable.getColumnModel().getColumn(5);
aColumn.setCellEditor(DefaultCellEditor(fillWithWhatCbox));
renderer = DefaultTableCellRenderer();
renderer.setToolTipText('Click to change');
aColumn.setCellRenderer(renderer);


for i = 1:rows
    model.setValueAt(java.lang.String(layersDetails{i}(5)),i-1,0);
    model.setValueAt(java.lang.String(layersDetails{i}(6)),i-1,5);
    for n = 1:4
        thisVal = layersDetails{i}(n);
        if ~isempty(thisVal{:})
            if ischar(thisVal{:})
                thisVal = str2num(thisVal{:});
            else
                thisVal = thisVal{:};
            end
            model.setValueAt(java.lang.String(pNames(thisVal)),i-1,n);
        else
            model.setValueAt('',i-1,n);
        end
    end
end

myTable.getColumnModel().getColumn(0).setHeaderValue('Layer Name');
myTable.getColumnModel().getColumn(1).setHeaderValue('Thickness');
myTable.getColumnModel().getColumn(2).setHeaderValue('SLD');
myTable.getColumnModel().getColumn(3).setHeaderValue('Roughness');
myTable.getColumnModel().getColumn(4).setHeaderValue('%Hydration');
myTable.getColumnModel().getColumn(5).setHeaderValue('Hydrate with');

set(model,'TableChangedCallback',@layersTableEdited);

layersTableItems.table = myTable;
layersTableItems.cBox = cBox;
layersTableItems.model = model;
setappdata(0,'layersTableItems',layersTableItems);
setappdata(0,'layersNamesList',layersNames);
setappdata(0,'layersTable',myTable);
setappdata(0,'problem',problem);

end

%_________________________________________________________________________

