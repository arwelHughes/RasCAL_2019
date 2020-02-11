/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author arwel
 */
import javax.swing.JLabel;
import javax.swing.table.TableCellRenderer;
import java.text.NumberFormat;
import java.text.DecimalFormat;
import javax.swing.JTable;
import java.awt.Component;


public class numberTableCellRenderer extends JLabel implements TableCellRenderer {

        Number numberValue;   
        NumberFormat nf;
        DecimalFormat df = new DecimalFormat("#.####"); 
        DecimalFormat df2 = new DecimalFormat("0.000E0");
        String _formattedValue;
    
    public numberTableCellRenderer() {
    };    
        
        @Override
    public Component getTableCellRendererComponent(JTable table,
        Object value, boolean isSelected, boolean hasFocus, 
        int row, int col) {

        Double _value = (Double)value;
        if (value == null) {
            _formattedValue = "Not Set";
        } else {
            if (((_value > 1000 ) || (_value < -1000)) || ((_value < 9e-3 ) && (_value > -9e-3))) 
            _formattedValue = df2.format(value);
            else
            _formattedValue = df.format(value);   
        }
        JLabel testLabel = new JLabel(_formattedValue);
        testLabel.setHorizontalAlignment(CENTER);

        return testLabel;
    }
 }
