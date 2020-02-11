import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.io.Serializable;




public class mainGuiParamsDefaultTableModel extends DefaultTableModel implements Serializable{
    
    
    public mainGuiParamsDefaultTableModel(Object[][] data, Object[] columnNames) {
        this.setDataVector(data, columnNames);
    }
    
    public void setValueAt(Object value, int row, int column)
    {
      switch (column) {
          case 0:
              super.setValueAt(value,row,column);
              break;
          case 1:
          case 2:
          case 3:
          case 4:
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
          if(columnIndex == 0) {
               return Boolean.class;
          } else {
               return super.getColumnClass(columnIndex);
          }
     }

     public boolean isCellEditable(int row, int column) {
        switch(column){
            case 1:
                return false;
            default:
                return true;
        }
        }
     
}

