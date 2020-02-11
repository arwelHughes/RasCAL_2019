import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.io.Serializable;


public class bayesGuiResultsTableModel extends DefaultTableModel implements Serializable{
    
    
    public bayesGuiResultsTableModel(Object[][] data, Object[] columnNames) {
        this.setDataVector(data, columnNames);
    }
    
    public void setValueAt(Object value, int row, int column)
    {
     switch (column) {
          case 0:
              break;
          case 1:
              if (value instanceof Double) {
                    super.setValueAt(value,row,column);  
              } else if (value instanceof String) {  
              try  {
                super.setValueAt(Double.valueOf((String)value),row,column);
              }
              catch (NumberFormatException nfe) {
                    super.setValueAt(Double.valueOf("NaN"),row,column);
                    break;
                    }
              }
          case 2:
          case 3:
          case 4:
              super.setValueAt(value,row,column);
              
              
           fireTableCellUpdated(row, column);        
      }
    }
    
     public Class getColumnClass(int columnIndex) {
               return super.getColumnClass(columnIndex);
     }

     public boolean isCellEditable(int row, int column) {
                return false;
        }
     
}

