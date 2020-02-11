function makeNewCustomFile(src,ev)

import javax.swing.JInternalFrame;
import javax.swing.JFileChooser;
%import java.awt.*;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');




openFileWindow = JInternalFrame();
openFileWindow.setSize(500,400);
openFileWindow.setTitle('New Custom File');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',openFileWindow);


chooser = JFileChooser(pwd);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
filter = ExampleFileFilter('m');
filter.setDescription('Custom Layer Model');
chooser.addChoosableFileFilter(filter);
set(chooser,'ActionPerformedCallback',@fileChosenCallback);
openFileWindow.add(chooser);

desktop.setLayer(openFileWindow,3);
desktop.add(openFileWindow);
openFileWindow.setLocation(200,200);

%__________________________________________________________________________

function fileChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));
fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    return
end

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end


thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);
slash = findstr(sep,path);
path = path(1:slash(end));
name = char(thisFile.getName);

allPanels = getappdata(0,'allPanels');
mainPanel = allPanels.generalPanel;

typeBox = mainPanel.getTypeComboBox();
whatType = typeBox.getSelectedItem();

switch whatType
    case 'Custom Layers'
        createNewCustomLayersFile(path,name);
        edit([path name]);
    case 'Custom XY Profile'
        createNewCustomXYProfileFile(path,name);
        edit([path name]);
end

nameBox = mainPanel.getCustomFileTextField();
nameBox.setText(name);
allPanels.generalPanel = mainPanel;
setappdata(0,'allPanels',allPanels);

fr.dispose();