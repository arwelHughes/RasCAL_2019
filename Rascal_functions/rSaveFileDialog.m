function rSaveFileDialog(src,ev);

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

saveFileWindow = JInternalFrame();
saveFileWindow.setSize(500,400);
saveFileWindow.setTitle('Save Project File');
saveFileWindow.setMaximizable(false);
saveFileWindow.setIconifiable(true);
saveFileWindow.setClosable(false);
saveFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',saveFileWindow);


chooser = JFileChooser(pwd);
%chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
filter = ExampleFileFilter('mat');
filter.setDescription('Rascal Project Files');
chooser.addChoosableFileFilter(filter);

%chooser.addChoosableFileFilter(myFilter);
set(chooser,'ActionPerformedCallback',@saveFileChosenCallback);
saveFileWindow.add(chooser);

desktop.setLayer(saveFileWindow,3);
desktop.add(saveFileWindow);
saveFileWindow.setLocation(200,200);




function saveFileChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end

problem = getappdata(0,'problem');

fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    return
end

thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);
slash = findstr(sep,path);
newName = path(slash(end)+1:end);
problem.name = newName;

save(path,'problem');

setappdata(0,'problem',problem);

reSetProblem(problem);
fr.dispose();


