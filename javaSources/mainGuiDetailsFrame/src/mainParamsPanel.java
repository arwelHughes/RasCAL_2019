/*
 * mainParamsPanel.java
 *
 * Created on 28 April 2008, 10:09
 */
import java.io.Serializable;
/**
 *
 * @author  avh45
 */
public class mainParamsPanel extends javax.swing.JPanel implements Serializable{
    
    /** Creates new form mainParamsPanel */
    public mainParamsPanel() {
        initComponents();
    }

    public javax.swing.JScrollPane getMainParamsTableScrollPane() {
        return mainParamsTableScrollPane;
    }

    public javax.swing.JButton getMainParamsCheckAllButton() {
        return mainParamsCheckAllButton;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        mainParamsCheckAllButton = new javax.swing.JButton();
        mainParamsTableScrollPane = new javax.swing.JScrollPane();

        mainParamsCheckAllButton.setText("(un)check all");

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(20, 20, 20)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(mainParamsTableScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 545, Short.MAX_VALUE)
                    .add(mainParamsCheckAllButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 115, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(20, 20, 20))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(mainParamsCheckAllButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 35, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(10, 10, 10)
                .add(mainParamsTableScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 330, Short.MAX_VALUE)
                .add(30, 30, 30))
        );
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton mainParamsCheckAllButton;
    private javax.swing.JScrollPane mainParamsTableScrollPane;
    // End of variables declaration//GEN-END:variables
    
}
