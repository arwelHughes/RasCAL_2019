
import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.io.Serializable;

public class mainGuiLayersDefaultTableModel extends DefaultTableModel implements Serializable {
    
    public mainGuiLayersDefaultTableModel(Object[][] data, Object[] columnNames) {
        this.setDataVector(data, columnNames);
    }
    
     public boolean isCellEditable(int row, int column) {
                return false;
        } 
          
}


