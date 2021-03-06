/*
 * PlottingWindow.java
 *
 * Created on 10 March 2008, 09:28
 */
import java.io.Serializable;
/**
 *
 * @author  Arwel
 *
 *
 */

import org.jfree.chart.ChartPanel;


public class PlottingWindow extends javax.swing.JInternalFrame implements Serializable {
    
    /** Creates new form PlottingWindow */
    public PlottingWindow() {
        initComponents();
    }

    public javax.swing.JPanel getReflectivityPanel() {
        return reflectivityPanel;
    }

    public javax.swing.JPanel getSldPanel() {
        return sldPanel;
    }

    public javax.swing.JComboBox getPlotTypeJComboBox() {
        return plotTypeJComboBox;
    }
    
    public javax.swing.JComboBox getDataTypeJComboBox() {
        return dataTypeComboBox;
    }

    //public javax.swing.JTextField getYMinTextField() {
    //    return yMinTextField;
   // }
    
    
    
    public void setReflectivityPanel(javax.swing.JPanel jPanel1) {
        this.reflectivityPanel = jPanel1;
    }

    public void setSldPanel(javax.swing.JPanel jPanel2) {
        this.sldPanel = jPanel2;
    }

    public javax.swing.JSlider getJSlider1() {
        return jSlider1;
    }

    public void setJSlider1(javax.swing.JSlider jSlider1) {
        this.jSlider1 = jSlider1;
    }

    public javax.swing.JCheckBox getShowErrorBarsCheckBox() {
        return showErrorBarsCheckBox;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jSlider1 = new javax.swing.JSlider();
        plotTypeJComboBox = new javax.swing.JComboBox();
        jLabel1 = new javax.swing.JLabel();
        showErrorBarsCheckBox = new javax.swing.JCheckBox();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        dataTypeComboBox = new javax.swing.JComboBox<>();
        reflectivityPanel = new javax.swing.JPanel();
        sldPanel = new javax.swing.JPanel();

        setResizable(true);

        jSlider1.setOrientation(javax.swing.JSlider.VERTICAL);

        plotTypeJComboBox.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Linear", "Logarithmic" }));

        jLabel1.setText("Plot Type:");

        showErrorBarsCheckBox.setText("Show Error Bars");
        showErrorBarsCheckBox.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 0, 0, 0));

        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.TRAILING);
        jLabel2.setText("Y");

        jLabel3.setText("X");

        dataTypeComboBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Ref", "Ref * Q^4" }));

        reflectivityPanel.setBackground(java.awt.Color.white);

        org.jdesktop.layout.GroupLayout reflectivityPanelLayout = new org.jdesktop.layout.GroupLayout(reflectivityPanel);
        reflectivityPanel.setLayout(reflectivityPanelLayout);
        reflectivityPanelLayout.setHorizontalGroup(
            reflectivityPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 0, Short.MAX_VALUE)
        );
        reflectivityPanelLayout.setVerticalGroup(
            reflectivityPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 0, Short.MAX_VALUE)
        );

        sldPanel.setBackground(java.awt.Color.white);

        org.jdesktop.layout.GroupLayout sldPanelLayout = new org.jdesktop.layout.GroupLayout(sldPanel);
        sldPanel.setLayout(sldPanelLayout);
        sldPanelLayout.setHorizontalGroup(
            sldPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 0, Short.MAX_VALUE)
        );
        sldPanelLayout.setVerticalGroup(
            sldPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 0, Short.MAX_VALUE)
        );

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(jSlider1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(layout.createSequentialGroup()
                        .add(showErrorBarsCheckBox)
                        .add(30, 30, 30)
                        .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 72, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(plotTypeJComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 145, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .add(18, 18, 18)
                        .add(jLabel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .add(3, 3, 3)
                        .add(dataTypeComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 171, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .add(107, 407, Short.MAX_VALUE))
                    .add(layout.createSequentialGroup()
                        .add(reflectivityPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                        .add(sldPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jSlider1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 491, Short.MAX_VALUE)
                    .add(reflectivityPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(sldPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE, false)
                    .add(plotTypeJComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel1)
                    .add(jLabel3, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(showErrorBarsCheckBox)
                    .add(jLabel2, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(dataTypeComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    javax.swing.JComboBox<String> dataTypeComboBox;
    javax.swing.JLabel jLabel1;
    javax.swing.JLabel jLabel2;
    javax.swing.JLabel jLabel3;
    javax.swing.JSlider jSlider1;
    javax.swing.JComboBox plotTypeJComboBox;
    javax.swing.JPanel reflectivityPanel;
    javax.swing.JCheckBox showErrorBarsCheckBox;
    javax.swing.JPanel sldPanel;
    // End of variables declaration//GEN-END:variables
    
}
