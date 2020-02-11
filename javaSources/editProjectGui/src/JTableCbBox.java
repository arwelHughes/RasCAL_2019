


import javax.swing.JTable;
import javax.swing.DefaultCellEditor;
import javax.swing.JComboBox;


public class JTableCbBox extends JTable {

    protected DefaultCellEditor cboxBulk1;
    protected DefaultCellEditor cboxBulk2;
    protected DefaultCellEditor cboxLayers;
    protected DefaultCellEditor standard;
    
    
    public JTableCbBox(int rows, int cols, DefaultCellEditor e1, DefaultCellEditor e2, DefaultCellEditor e3) {
        super(rows,cols);
        cboxBulk1 = e1;
        cboxBulk2 = e2;
        cboxLayers = e3;
    }

    public DefaultCellEditor getCellEditor(int row, int col) {
        if (col == 1) {      
            if (row == 0) {
                System.out.println("Debug");
                return cboxBulk1;
            }
            else if (row == super.getRowCount()-1){
                return cboxBulk2;
            } 
            else {
                return cboxLayers;
            }
        }
        else {
            return standard;
        }
    }
}