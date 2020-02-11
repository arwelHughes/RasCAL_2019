function contrastFileNameBrowseButtonCallback(src,ev)

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');
mainFrame = getappdata(0,'mainFrame');
allContrastPanels = getappdata(0,'allContrastPanels');
thisContrast = getappdata(src,'UserData');


openFileWindow = JInternalFrame();
openFileWindow.setSize(500,400);
openFileWindow.setTitle('Choose Path');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(false);
setappdata(0,'thisFileDialogContainer',openFileWindow);

hchooser = handle(JFileChooser(pwd), 'CallbackProperties');
set(hchooser,'AcceptAllFileFilterUsed',1);
setappdata(hchooser,'UserData',thisContrast);
set(hchooser,'ActionPerformedCallback',@fileChosenCallback);

lockEditGuiFrame();
openFileWindow.add(hchooser);

desktop.setLayer(openFileWindow,3);
desktop.add(openFileWindow);

p = mainFrame.getLocation;
openFileWindow.setLocation(p.x+100,p.y+100);
openFileWindow.add(hchooser);
openFileWindow.toFront();
openFileWindow.setVisible(true);


function fileChosenCallback(src,ev);

fr = getappdata(0,'thisFileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand'),'CancelSelection');
    fr.dispose();
    rmappdata(0,'thisFileDialogContainer');
    unlockEditGuiFrame;
    return
end

whichContrast = getappdata(src,'UserData');
newDir = get(src,'SelectedFile');

thePanels = getappdata(0,'allContrastPanels');
thisPanel = thePanels{whichContrast};

fullFile = char(newDir.getPath);
%slashes = find(fullFile == '\');
%file = fullFile(slashes(end)+1:end);

pathTextBox = thisPanel.getFileTextField();
pathTextBox.setText(java.lang.String(fullFile));

fr.dispose;
unlockEditGuiFrame();
rmappdata(0,'thisFileDialogContainer');

