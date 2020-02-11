function rExportDataDialog(src,ev);

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

saveFileWindow = JInternalFrame();
saveFileWindow.setSize(500,400);
saveFileWindow.setTitle('Export Fits and Data');
saveFileWindow.setMaximizable(false);
saveFileWindow.setIconifiable(true);
saveFileWindow.setClosable(false);
saveFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',saveFileWindow);


chooser = JFileChooser(pwd);
%chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
%chooser.addChoosableFileFilter(myFilter);
set(chooser,'ActionPerformedCallback',@exportFitsChosenCallback);
saveFileWindow.add(chooser);

desktop.setLayer(saveFileWindow,3);
desktop.add(saveFileWindow);
saveFileWindow.setLocation(200,200);




function exportFitsChosenCallback(src,ev);
%addInfoText(get(src,'SelectedFile'));

problem = getappdata(0,'problem');

oldDir = problem.path;

fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand'),'CancelSelection') == 1;
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

where = findstr(name,path);
path = path(1:where-1);

ss = problem.shifted_data;
rr = problem.calculations.reflectivity;
slds = problem.calculations.slds;

number_of_datafiles  = size(ss,2);
mat = [];

point = findstr(name,'.');
if ~isempty(point)
    prefix = name(1:point-1);
else
    prefix = name;
end

%prefix = fullfile(path,prefix);

for i = 1:number_of_datafiles;
    thisdat = ss{i};
    thisfit = rr{i};
    thissld = slds{i};
    thisFileName = [prefix '_fit_contrast_' num2str(i) '.dat'];
    thisFullFile = fullfile(path,thisFileName);
    thisMat = [thisdat thisfit];
    dlmwrite(thisFullFile,thisMat,'\t');
    addInfoText(sprintf(['Writing contrast %d to ' thisFileName],i));
    
    thisFileNameSLD = [prefix '_sld_contrast_' num2str(i) '.dat'];
    thisFullFileSLD = fullfile(path,thisFileNameSLD);
    dlmwrite(thisFullFileSLD,thissld,'\t');
    addInfoText(sprintf(['Writing sld of contrast %d tp ' thisFileNameSLD],i));
    
end

fr.dispose();
