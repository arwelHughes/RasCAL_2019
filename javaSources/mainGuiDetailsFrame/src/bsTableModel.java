/*
 * bsTableModel.java
 *
 * Created on 06 February 2009, 08:20
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

/**
 *
 * @author Arwel
 */
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import java.io.Serializable;

public class bsTableModel extends DefaultTableModel implements Serializable {
    
    
    public bsTableModel(Object[][] data, Object[] columnNames) {
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
    

     public boolean isCellEditable(int row, int column) {
                return false;
        }
     
}

    

