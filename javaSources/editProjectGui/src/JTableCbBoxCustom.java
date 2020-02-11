
import javax.swing.JTable;
import javax.swing.DefaultCellEditor;
import javax.swing.JComboBox;


public class JTableCbBoxCustom extends JTable {

    protected DefaultCellEditor cboxBulk1;
    protected DefaultCellEditor cboxBulk2;
    protected DefaultCellEditor standard;
    
    
    public JTableCbBoxCustom(int rows, int cols, DefaultCellEditor e1, DefaultCellEditor e2) {
        super(rows,cols);
        cboxBulk1 = e1;
        cboxBulk2 = e2;
    }

    public DefaultCellEditor getCellEditor(int row, int col) {
        if (col == 1) {      
            if (row == 0) {
                return cboxBulk1;
            }
            else if (row == super.getRowCount()-1){
                return cboxBulk2;
            } 
            else {
                return standard;
            }
        }
        else {
            return standard;
        }
    }
}