function contrastOpenGenieEditButtonCallback(src,ev)

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');
mainFrame = getappdata(0,'mainFrame');
allContrastPanels = getappdata(0,'allContrastPanels');
thisContrast = getappdata(src,'UserData');

allOpenGenieWindows = getappdata(0,'allOpenGenieWindows');
thisogWindow = allOpenGenieWindows{thisContrast};
thisogWindow.setVisible(true);
lockEditGuiFrame();
