/*
 * Notepad.java
 *
 * Created on 21 May 2007, 15:26
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

import javax.swing.*;
import java.awt.event.*;
import java.awt.*;



public class Notepad extends JFrame {
    private MDIDesktopPane desktop = new MDIDesktopPane();
    private JScrollPane scrollPane = new JScrollPane();
    
    public MDIDesktopPane Notepad() {
        System.out.println("Debug");
        scrollPane.getViewport().add(desktop);
        this.getContentPane().setLayout(new BorderLayout());
        this.getContentPane().add(scrollPane,BorderLayout.CENTER);
        
        return desktop;
    }
    
}


/**
 *
 * @author avh45
 */
