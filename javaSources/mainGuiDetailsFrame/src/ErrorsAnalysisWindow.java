/*
 * ErrorsAnalysisWindow.java
 *
 * Created on 23 January 2009, 09:44
 */
import java.io.Serializable;

/**
 *
 * @author  avh45
 */
public class ErrorsAnalysisWindow extends javax.swing.JInternalFrame implements Serializable  {
    
    /** Creates new form ErrorsAnalysisWindow */
    public ErrorsAnalysisWindow() {
        initComponents();
    }

    public javax.swing.JComboBox getParsComboBox() {
        return parsComboBox;
    }

    public javax.swing.JPanel getCutThroughsPanel() {
        return cutThroughsPanel;
    }

    public javax.swing.JButton getOkButton() {
        return okButton;
    }

    public javax.swing.JButton getCalcStatsButton() {
        return calcStatsButton;
    }

    public errorStatsPanel getErrorStatsPanel1() {
        return errorStatsPanel1;
    }
    
    public bootstrapPanel getBootstrapPanel() {
        return bootstrapPanel1;
    }

    public javax.swing.JPanel getBootStrapTab() {
        return bootStrapTab;
    }

    public javax.swing.JPanel getFitStatsTab() {
        return fitStatsTab;
    }

    public javax.swing.JPanel getMonovariateTab() {
        return monovariateTab;
    }

    public javax.swing.JButton getExportResultsButton() {
        return exportResultsButton;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel2 = new javax.swing.JPanel();
        okButton = new javax.swing.JButton();
        EAnalysisTabbedPane = new javax.swing.JTabbedPane();
        monovariateTab = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        parsComboBox = new javax.swing.JComboBox();
        cutThroughsPanel = new javax.swing.JPanel();
        fitStatsTab = new javax.swing.JPanel();
        calcStatsButton = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        errorStatsPanel1 = new errorStatsPanel();
        bootStrapTab = new javax.swing.JPanel();
        bootstrapPanel1 = new bootstrapPanel();
        exportResultsButton = new javax.swing.JButton();

        org.jdesktop.layout.GroupLayout jPanel2Layout = new org.jdesktop.layout.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 100, Short.MAX_VALUE)
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 100, Short.MAX_VALUE)
        );

        setMaximizable(true);
        setResizable(true);

        okButton.setText("Ok");

        jLabel1.setText("View Parameter");

        cutThroughsPanel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        org.jdesktop.layout.GroupLayout cutThroughsPanelLayout = new org.jdesktop.layout.GroupLayout(cutThroughsPanel);
        cutThroughsPanel.setLayout(cutThroughsPanelLayout);
        cutThroughsPanelLayout.setHorizontalGroup(
            cutThroughsPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 744, Short.MAX_VALUE)
        );
        cutThroughsPanelLayout.setVerticalGroup(
            cutThroughsPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(0, 626, Short.MAX_VALUE)
        );

        org.jdesktop.layout.GroupLayout monovariateTabLayout = new org.jdesktop.layout.GroupLayout(monovariateTab);
        monovariateTab.setLayout(monovariateTabLayout);
        monovariateTabLayout.setHorizontalGroup(
            monovariateTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(monovariateTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(monovariateTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(cutThroughsPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .add(monovariateTabLayout.createSequentialGroup()
                        .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 121, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(parsComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 163, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .add(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        monovariateTabLayout.setVerticalGroup(
            monovariateTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, monovariateTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(cutThroughsPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(monovariateTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel1)
                    .add(parsComboBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        EAnalysisTabbedPane.addTab("Monovariate Analysis", monovariateTab);

        calcStatsButton.setText("Calculate");

        jScrollPane1.setViewportView(errorStatsPanel1);

        org.jdesktop.layout.GroupLayout fitStatsTabLayout = new org.jdesktop.layout.GroupLayout(fitStatsTab);
        fitStatsTab.setLayout(fitStatsTabLayout);
        fitStatsTabLayout.setHorizontalGroup(
            fitStatsTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(fitStatsTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(fitStatsTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jScrollPane1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 767, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, calcStatsButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 95, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );
        fitStatsTabLayout.setVerticalGroup(
            fitStatsTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(fitStatsTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(calcStatsButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 37, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jScrollPane1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 612, Short.MAX_VALUE)
                .addContainerGap())
        );

        EAnalysisTabbedPane.addTab("Fit Statistics", fitStatsTab);

        org.jdesktop.layout.GroupLayout bootStrapTabLayout = new org.jdesktop.layout.GroupLayout(bootStrapTab);
        bootStrapTab.setLayout(bootStrapTabLayout);
        bootStrapTabLayout.setHorizontalGroup(
            bootStrapTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(bootStrapTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(bootstrapPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 767, Short.MAX_VALUE)
                .addContainerGap())
        );
        bootStrapTabLayout.setVerticalGroup(
            bootStrapTabLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, bootStrapTabLayout.createSequentialGroup()
                .addContainerGap()
                .add(bootstrapPanel1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 655, Short.MAX_VALUE)
                .addContainerGap())
        );

        EAnalysisTabbedPane.addTab("Bootstrap Error Estimate", bootStrapTab);

        exportResultsButton.setText("Export Results");

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .addContainerGap()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(EAnalysisTabbedPane, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 792, Short.MAX_VALUE)
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                        .add(exportResultsButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 119, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(okButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 68, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .add(EAnalysisTabbedPane)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(okButton)
                    .add(exportResultsButton))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTabbedPane EAnalysisTabbedPane;
    private javax.swing.JPanel bootStrapTab;
    private bootstrapPanel bootstrapPanel1;
    private javax.swing.JButton calcStatsButton;
    private javax.swing.JPanel cutThroughsPanel;
    private errorStatsPanel errorStatsPanel1;
    private javax.swing.JButton exportResultsButton;
    private javax.swing.JPanel fitStatsTab;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JPanel monovariateTab;
    private javax.swing.JButton okButton;
    private javax.swing.JComboBox parsComboBox;
    // End of variables declaration//GEN-END:variables
    
}
