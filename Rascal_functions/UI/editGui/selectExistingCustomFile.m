function selectExistingCustomFile(src,ev)

import javax.swing.JInternalFrame;
import javax.swing.JFileChooser;
%import java.awt.*;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');
lockEditGuiFrame;

openFileWindow = JInternalFrame();
openFileWindow.setSize(500,400);
openFileWindow.setTitle('New Custom File');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',openFileWindow);


chooser = JFileChooser(pwd);
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
if strcmp(get(whatHappened, 'ActionCommand') ,'CancelSelection') == 1;
    unlockEditGuiFrame;
    fr.dispose();
    return
end



switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end

%***NEED TO MODIFY THIS BIT***
%**so that - name only of file goes into box
%**..and that the file gets copied to the local directory at this point??


thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);
slash = findstr(sep,path);
path = path(1:slash(end));
name = char(thisFile.getName);

% createNewCustomLayersFile(path,name);
% edit([path name]);

allPanels = getappdata(0,'allPanels');
mainPanel = allPanels.generalPanel;
nameBox = mainPanel.getCustomFileTextField();
nameBox.setText(name);
allPanels.generalPanel = mainPanel;
setappdata(0,'allPanels',allPanels);




fr.dispose();
unlockEditGuiFrame;