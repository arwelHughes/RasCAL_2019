/*
 * expParamsScrollabalePanel.java
 *
 * Created on 07 January 2008, 15:43
 */

/**
 *
 * @author  avh45
 */
public class expParamsScrollabalePanel extends javax.swing.JPanel {
    
    /** Creates new form expParamsScrollabalePanel */
    public expParamsScrollabalePanel() {
        initComponents();
    }

    public javax.swing.JButton getResolAddButton() {
        return resolAddButton;
    }

    public javax.swing.JButton getResolRemoveButton() {
        return resolRemoveButton;
    }

    public javax.swing.JScrollPane getResolutionScrollPane() {
        return resolutionScrollPane;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc=" Generated Code ">//GEN-BEGIN:initComponents
    private void initComponents() {
        backsAddButton = new javax.swing.JButton();
        backsRemoveButton = new javax.swing.JButton();
        resolutionScrollPane = new javax.swing.JScrollPane();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        scalesAddButton = new javax.swing.JButton();
        scalesRemoveButton = new javax.swing.JButton();
        scalesScrollPane = new javax.swing.JScrollPane();
        jLabel3 = new javax.swing.JLabel();
        shiftsAddButton = new javax.swing.JButton();
        shiftsRemoveButton = new javax.swing.JButton();
        shiftsScrollPane = new javax.swing.JScrollPane();
        jLabel4 = new javax.swing.JLabel();
        nbaAddButton = new javax.swing.JButton();
        nbaRemoveButton = new javax.swing.JButton();
        nbairsScrollPane = new javax.swing.JScrollPane();
        jLabel5 = new javax.swing.JLabel();
        nbsAddButton = new javax.swing.JButton();
        nbsRemoveButton = new javax.swing.JButton();
        nbsubsScrollPane = new javax.swing.JScrollPane();
        resolRemoveButton = new javax.swing.JButton();
        resolAddButton = new javax.swing.JButton();
        backsScrollPane = new javax.swing.JScrollPane();
        jLabel6 = new javax.swing.JLabel();

        backsAddButton.setText("Add");

        backsRemoveButton.setText("Remove");

        jLabel1.setText("Backgrounds");

        jLabel2.setText("Scale Factors");

        scalesAddButton.setText("Add");

        scalesRemoveButton.setText("Remove");

        jLabel3.setText("Qz Shifts");

        shiftsAddButton.setText("Add");

        shiftsRemoveButton.setText("Remove");

        jLabel4.setText("SLD bulk 1 (beam in)");

        nbaAddButton.setText("Add");

        nbaRemoveButton.setText("Remove");

        jLabel5.setText("SLD bulk 2 (beam out)");

        nbsAddButton.setText("Add");

        nbsRemoveButton.setText("Remove");

        resolRemoveButton.setText("Remove");

        resolAddButton.setText("Add");

        jLabel6.setText("Resolution");

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(backsScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE)
                    .add(nbairsScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, scalesScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, layout.createSequentialGroup()
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 117, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel1))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 305, Short.MAX_VALUE)
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                            .add(layout.createSequentialGroup()
                                .add(backsAddButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(backsRemoveButton))
                            .add(layout.createSequentialGroup()
                                .add(scalesAddButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(scalesRemoveButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED))))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, layout.createSequentialGroup()
                        .add(jLabel4)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 325, Short.MAX_VALUE)
                        .add(nbaAddButton)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(nbaRemoveButton))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, layout.createSequentialGroup()
                        .add(jLabel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 61, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 361, Short.MAX_VALUE)
                        .add(shiftsAddButton)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(shiftsRemoveButton))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, shiftsScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE)
                    .add(nbsubsScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE)
                    .add(layout.createSequentialGroup()
                        .add(jLabel5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 125, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 297, Short.MAX_VALUE)
                        .add(nbsAddButton)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(nbsRemoveButton))
                    .add(layout.createSequentialGroup()
                        .add(jLabel6)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 372, Short.MAX_VALUE)
                        .add(resolAddButton)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(resolRemoveButton))
                    .add(resolutionScrollPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 554, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(backsRemoveButton)
                    .add(backsAddButton)
                    .add(jLabel1))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(backsScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 84, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(26, 26, 26)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(scalesAddButton)
                    .add(scalesRemoveButton)
                    .add(jLabel2))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(scalesScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 85, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(15, 15, 15)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel3)
                    .add(shiftsRemoveButton)
                    .add(shiftsAddButton))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(shiftsScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 83, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(24, 24, 24)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel4)
                    .add(nbaRemoveButton)
                    .add(nbaAddButton))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(nbairsScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 94, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(21, 21, 21)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(nbsAddButton)
                    .add(nbsRemoveButton)
                    .add(jLabel5))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(nbsubsScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 84, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(21, 21, 21)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                        .add(resolRemoveButton)
                        .add(resolAddButton))
                    .add(jLabel6))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(resolutionScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 84, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(19, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    public javax.swing.JButton backsAddButton;
    public javax.swing.JButton backsRemoveButton;
    public javax.swing.JScrollPane backsScrollPane;
    public javax.swing.JLabel jLabel1;
    public javax.swing.JLabel jLabel2;
    public javax.swing.JLabel jLabel3;
    public javax.swing.JLabel jLabel4;
    public javax.swing.JLabel jLabel5;
    public javax.swing.JLabel jLabel6;
    public javax.swing.JButton nbaAddButton;
    public javax.swing.JButton nbaRemoveButton;
    public javax.swing.JScrollPane nbairsScrollPane;
    public javax.swing.JButton nbsAddButton;
    public javax.swing.JButton nbsRemoveButton;
    public javax.swing.JScrollPane nbsubsScrollPane;
    public javax.swing.JButton resolAddButton;
    public javax.swing.JButton resolRemoveButton;
    public javax.swing.JScrollPane resolutionScrollPane;
    public javax.swing.JButton scalesAddButton;
    public javax.swing.JButton scalesRemoveButton;
    public javax.swing.JScrollPane scalesScrollPane;
    public javax.swing.JButton shiftsAddButton;
    public javax.swing.JButton shiftsRemoveButton;
    public javax.swing.JScrollPane shiftsScrollPane;
    // End of variables declaration//GEN-END:variables
    
}
