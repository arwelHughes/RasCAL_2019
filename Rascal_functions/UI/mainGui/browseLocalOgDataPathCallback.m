function browseLocalOgDataPathCallback(src,ev)

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');
prefsFrame = getappdata(0,'fittingOptionsFrame');

openFileWindow = JInternalFrame();
openFileWindow.setSize(500,400);
openFileWindow.setTitle('Choose Path');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(false);
setappdata(0,'ogpathFileDialogContainer',openFileWindow);

chooser = JFileChooser(pwd);
chooser.setAcceptAllFileFilterUsed(true);
set(chooser,'ActionPerformedCallback',@ogpathChosenCallback);

lockPreferencesFrame();
openFileWindow.add(chooser);

desktop.setLayer(openFileWindow,4);
desktop.add(openFileWindow);

p = prefsFrame.getLocation;
openFileWindow.setLocation(p.x+100,p.y+100);
openFileWindow.add(chooser);
openFileWindow.toFront();
openFileWindow.setVisible(true);


function ogpathChosenCallback(src,ev);

fr = getappdata(0,'ogpathFileDialogContainer');
prefsFrame = getappdata(0,'fittingOptionsFrame');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    rmappdata(0,'ogpathFileDialogContainer');
    unlockPreferencesFrame();
    return
end

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end


newDir = get(src,'SelectedFile');

fullFile = char(newDir.getPath);
slashes = find(fullFile == sep);
fullFile(slashes) = sep;

pathTextBox = prefsFrame.getlocalOGPathBox();
pathTextBox.setText(java.lang.String(fullFile));

fr.dispose;
unlockPreferencesFrame();
rmappdata(0,'ogpathFileDialogContainer');