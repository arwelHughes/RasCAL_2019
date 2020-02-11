import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;




public class editGuiParamsDefaultTableModel extends DefaultTableModel {
    
    
    public editGuiParamsDefaultTableModel(Object[][] data, Object[] columnNames) {
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

}






