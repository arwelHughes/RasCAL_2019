import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.io.Serializable;


public class bayesGuiMainTableModel extends DefaultTableModel implements Serializable{
    
    
    public bayesGuiMainTableModel(Object[][] data, Object[] columnNames) {
        this.setDataVector(data, columnNames);
    }
    
    public void setValueAt(Object value, int row, int column)
    {
     switch (column) {
          case 0:
          case 4:
              break;
          case 1:
          case 2:
          case 3:
          case 5:
          case 6:
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
           fireTableCellUpdated(row, column);        
      }
    }
    
     public Class getColumnClass(int columnIndex) {
               return super.getColumnClass(columnIndex);
     }

     public boolean isCellEditable(int row, int column) {
        switch(column){
            case 0:
            case 4:
                return false;
            default:
                return true;
        }
        }
     
}

