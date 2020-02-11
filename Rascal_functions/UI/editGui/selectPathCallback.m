function selectPathCallback(src,ev);

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');
mainFrame = getappdata(0,'mainFrame');

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

lockEditGuiFrame;

p = mainFrame.getLocation;
openFileWindow.setLocation(p.x+100,p.y+100);
openFileWindow.add(chooser);
openFileWindow.toFront();
openFileWindow.setVisible(true);



function directoryChosenCallback(src,ev);

fr = getappdata(0,'thisFileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(whatHappened.actionCommand ,'CancelSelection') == 1;
    fr.dispose();
    rmappdata(0,'thisFileDialogContainer');
    unlockEditGuiFrame;
    return
end

newDir = get(src,'SelectedFile');

thePanels = getappdata(0,'allPanels');
generalPanel = thePanels.generalPanel;

pathTextBox = generalPanel.getPathTextField();
pathTextBox.setText(newDir.getPath);



fr.dispose;
unlockEditGuiFrame;
rmappdata(0,'thisFileDialogContainer');



