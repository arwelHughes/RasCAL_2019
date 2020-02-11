function rSaveProjectDialog(src,ev);

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

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
set(chooser,'ActionPerformedCallback',@saveFileChosenCallback);
saveFileWindow.add(chooser);

desktop.setLayer(saveFileWindow,3);
desktop.add(saveFileWindow);
saveFileWindow.setLocation(200,200);




function saveFileChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));

problem = getappdata(0,'problem');

oldDir = problem.path;

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
name = char(thisFile.getName);

if ~((exist(path) ~= 7) || (exist(path) ~=0))
    addInfoText('Chosen path does not seem to be a directory. Please check');
    addInfoIext(['(' path ')']);
end

if (exist(path) == 0);
    [success,message] = mkdir(path); 
else
    success = 1;
end

if success == 0
    addInfoText(message);
    return
end




problem.name = name;
problem.path = path;


mkdir(fullfile(path,'dataFiles'));
cd(fullfile(path,'dataFiles'));

numberOfContrasts = problem.numberOfContrasts;
for i = 1:numberOfContrasts
    if problem.dataPresent(i)
        thisData = problem.data{i};
        thisDataName = problem.contrastFiles{i};
        dlmwrite(thisDataName,thisData);
        problem.datapath{i} = [path '\dataFiles\'];;
    end
end
    
cd ..


%transfer any mfiles...
oldDirM_files = dir(fullfile(oldDir,'*.m'));
for i = 1:size(oldDirM_files,1)
    [a,b,c] = copyfile(fullfile(oldDir,oldDirM_files(i).name),path);
end

%also any .mat files...
% oldDirMat_files = dir(fullfile(oldDir,'*.mat'));
% for i = 1:size(oldDirMat_files,1)
%     [a,b,c] = copyfile(fullfile(oldDir,oldDirMat_files(i).name),path);
% end

%also any rascal model files...
oldDirRmf_files = dir(fullfile(oldDir,'*.rmf'));
for i = 1:size(oldDirRmf_files,1)
    [a,b,c] = copyfile(fullfile(oldDir,oldDirRmf_files(i).name),path);
end

setappdata(0,'problem',problem);
savePosWindows;

if iscell(problem.name)
    name = problem.name{:};
else
    name = problem.name;
end
save(name,'problem');

setappdata(0,'problem',problem);
fr.dispose();


