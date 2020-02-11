function contrastFileNameBrowseButton(src,ev)

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');
mainFrame = getappdata(0,'mainFrame');
allContrastPanels = getappdata(0,'allContrastPanels');

openFileWindow = JInternalFrame();
openFileWindow.setSize(500,400);
openFileWindow.setTitle('Choose Path');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(false);
setappdata(0,'thisFileDialogContainer',openFileWindow);

chooser = JFileChooser(pwd);
chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
chooser.setAcceptAllFileFilterUsed(false);
set(chooser,'ActionPerformedCallback',@directoryChosenCallback);

openFileWindow.add(chooser);

desktop.add(openFileWindow);

p = mainFrame.getLocation;
openFileWindow.setLocation(p.x+100,p.y+100);
openFileWindow.add(chooser);
openFileWindow.toFront();
openFileWindow.setVisible(true);

