function rFileDialog(src,ev)

import javax.swing.*;
import java.awt.*;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

openFileWindow = javaObjectEDT(JInternalFrame());
openFileWindow.setSize(500,400);
openFileWindow.setTitle('Open File');
openFileWindow.setMaximizable(false);
openFileWindow.setIconifiable(true);
openFileWindow.setClosable(false);
openFileWindow.setResizable(true);
setappdata(0,'FileDialogContainer',openFileWindow);

chooser = javaObjectEDT(JFileChooser(pwd));
filter = javaObjectEDT(ExampleFileFilter('mat'));
filter.setDescription('Rascal Project Files');
chooser.addChoosableFileFilter(filter);
set(chooser,'ActionPerformedCallback',@fileChosenCallback);
openFileWindow.add(chooser);

desktop.setLayer(openFileWindow,3);
desktop.add(openFileWindow);
openFileWindow.setLocation(200,200);




function fileChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));
fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1
    fr.dispose();
    return
end

thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);
name = char(thisFile.getName);
path = path(1:(strfind(path,name)-1));
originalProblem = getappdata(0,'problem');

%try 
problem = rLoadProblem(path,name);
reSetProblem(problem);
defaultPosWindows();
fr.dispose();

%catch
   %addInfoText('Sorry, Rascal had problems loading this file');
   %setappdata(0,'problem',originalProblem);
   %fr.dispose();
%end

