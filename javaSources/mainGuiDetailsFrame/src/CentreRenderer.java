import java.awt.Component;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.DefaultTableCellRenderer;
import java.io.Serializable;


     public class CentreRenderer extends DefaultTableCellRenderer implements Serializable {
        public CentreRenderer()
        {
            setHorizontalAlignment( CENTER );
        }
 
        public Component getTableCellRendererComponent(
            JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column)
        {
            super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
            return this;
        }
    }
