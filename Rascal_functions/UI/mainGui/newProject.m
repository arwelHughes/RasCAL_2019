function newProject(src,ev)

import javax.swing.JInternalFrame;
import javax.swing.JFileChooser;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

saveFileWindow = JInternalFrame();
saveFileWindow.setSize(500,400);
saveFileWindow.setTitle('Select New Project Directory');
saveFileWindow.setMaximizable(false);
saveFileWindow.setIconifiable(true);
saveFileWindow.setClosable(false);
saveFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',saveFileWindow);


chooser = JFileChooser(pwd);
chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
%chooser.addChoosableFileFilter(myFilter);
set(chooser,'ActionPerformedCallback',@newProjectChosenCallback);
saveFileWindow.add(chooser);

desktop.setLayer(saveFileWindow,3);
desktop.add(saveFileWindow);
saveFileWindow.setLocation(200,200);

problem = getappdata(0,'problem');
savePosWindows
%editGuiTest(problem);

end




%________________________________________________________________
function newProjectChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));

problem = getappdata(0,'problem');

fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    return
end

thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);
%a = ['!mkdir ' char(34) path char(34)];
%eval(a);
[a,b,c] = mkdir(path);

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end

slash = findstr(sep,path);
newDir = path(slash(end)+1:end);
cd(path);

[a,b,c] = mkdir('dataFiles');
%!mkdir dataFiles

defaultPath = getappdata(0,'rascalPath');
fullPath = fullfile(defaultPath,'defaultProject','defaultProject.mat');
prob = load(fullPath,'problem');
problem = prob.problem;

name = path(slash(end)+1:end);
problem.path = path;
problem.name = name;


save(name,'problem');
savePosWindows();

reSetProblem(problem);
tileWindows();
cd(path)
fr.dispose();

end






