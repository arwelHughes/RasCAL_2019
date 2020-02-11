/*
 * SplashWindow1.java
 *
 * Created on 18 August 2008, 15:56
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
import java.awt.Dimension;
import java.awt.Toolkit;
import javax.swing.JWindow;
import java.awt.Frame;
import javax.swing.JLabel;
import javax.swing.ImageIcon;
import java.awt.BorderLayout;
import java.io.Serializable;

/**
 *
 * @author avh45
 */
class SplashWindow1 extends JWindow implements Serializable
{
    public SplashWindow1(String filename)
    {
        //super(f);
        JLabel l = new JLabel(new ImageIcon(filename));
        getContentPane().add(l, BorderLayout.CENTER);
        pack();
        Dimension screenSize =
          Toolkit.getDefaultToolkit().getScreenSize();
        Dimension labelSize = l.getPreferredSize();
        setLocation(screenSize.width/2 - (labelSize.width/2),
                    screenSize.height/2 - (labelSize.height/2));
        this.setAlwaysOnTop(true);
        setVisible(true);
        screenSize = null;
        labelSize = null;
    }
    
    public void CloseSplash() {
        super.dispose();
    }
}


