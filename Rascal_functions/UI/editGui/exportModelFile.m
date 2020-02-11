function exportModelFile(src,ev)

modelDetails = [];
MPcomponents = getappdata(0,'MPComponents');
modelDetails.type = MPcomponents.typeComboBox().getSelectedItem();

%Params....
table = getappdata(0,'editGuiParamsTable');
paramsTableModel = table.getModel;
numberOfParams = paramsTableModel.getRowCount;
for i = 0:numberOfParams-1;
    paramNames{i+1} = paramsTableModel.getValueAt(i,0);
    for n = 0:3
        thisParams{n+1} = paramsTableModel.getValueAt(i,n);
    end
    params{i+1} = thisParams;
end
modelDetails.params = params;

out = {};


%layers (if there)
if strcmp(modelDetails.type,'Standard Layers');
    out = {};
    layersTable = getappdata(0,'layersTable');
    lTableModel = layersTable.getModel;
    numberOfLayers = lTableModel.getRowCount();
    for i = 1:numberOfLayers;
        dThisLay = lTableModel.getValueAt(i-1,1);
        if isempty(dThisLay)
            out{1} = 'fail';
            out{2} = sprintf('Cant save model:- Layer %d thickness is undefined',i);
            return
        end
        where_d = find(strcmp(dThisLay,paramNames));
        thisLay{1} = num2str(where_d);

        sldThisLay = lTableModel.getValueAt(i-1,2);
        if isempty(sldThisLay);
            out{1} = 'fail';
            out{2} = sprintf('Cant save model:- Layer %d SLD is undefined',i);
            return
        end
        where_sld = find(strcmp(sldThisLay,paramNames));
        thisLay{2} = num2str(where_sld);

        rThisLay = lTableModel.getValueAt(i-1,3);
        if isempty(rThisLay)
            out{1} = 'fail';
            out{2} = sprintf('Cant save model:- Layer %d roughness is undefined',i);
            return
        end
        where_rough = find(strcmp(rThisLay,paramNames));
        thisLay{3} = num2str(where_rough);

        covThisLay = lTableModel.getValueAt(i-1,4);
        where_cov = find(strcmp(covThisLay,paramNames));
        thisLay{4} = num2str(where_cov);

        nameThisLay = lTableModel.getValueAt(i-1,0);
        thisLay{5} = nameThisLay;
        layNamesList{i} = nameThisLay;

        fillWithWhatThisLay = lTableModel.getValueAt(i-1,5);
        thisLay{6} = fillWithWhatThisLay;

        layersDetails{i} = thisLay;
    end
  modelDetails.layersDetails = layersDetails;  
end

if strcmp(modelDetails.type,'Custom Layers') || strcmp(modelDetails.type,'Custom XY Profile');
    out = {};
    customFile = MPcomponents.customFileTextField().getText();
    if exist(char(customFile)) ~= 2
        out{1} = 'fail';
        out{2} = ['Custom M-file ' customFile ' cannot be found in current directory. Please check'];
        return
    end
    modelDetails.customFile = char(customFile);
end

if isempty(out)
    exportModelFileDialog();
else
    addInfoText(['Failed because ' out{2}]);
end

% ------------------------------------------------------------------------


function exportModelFileDialog();

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

saveFileWindow = JInternalFrame();
saveFileWindow.setSize(500,400);
saveFileWindow.setTitle('Export Filename?');
saveFileWindow.setMaximizable(false);
saveFileWindow.setIconifiable(true);
saveFileWindow.setClosable(false);
saveFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',saveFileWindow);


chooser = JFileChooser(pwd);

filter = ExampleFileFilter('rmf');
filter.setDescription('Rascal Model Files');
chooser.addChoosableFileFilter(filter);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
set(chooser,'ActionPerformedCallback',@exportModelFileChosenCallback);
saveFileWindow.add(chooser);

desktop.setLayer(saveFileWindow,3);
desktop.add(saveFileWindow);
saveFileWindow.setLocation(200,200);

end

%--------------------------------------------------------------------------

function exportModelFileChosenCallback(src,ev);

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
charThisFile = char(thisFile);

currentDirectory = pwd;
targetDirectory = charThisFile(1:slash(end)-1);

isThereADot = findstr(charThisFile,'.');
if~isempty(isThereADot)
    extens = charThisFile(isThereADot+1:end);
    if strcmp(extens,'rmf')
        strng = ['save ' char(39) char(thisFile) char(39) ' modelDetails -mat']; 
    else
        strng = ['save ' char(39) char(thisFile) char(39) '.rmf modelDetails -mat'];
    end
else
    strng = ['save ' char(39) char(thisFile) char(39) '.rmf modelDetails -mat'];
end
eval(strng);

if any(strcmp(fields(modelDetails),'customFile'))
    if strcmp(currentDirectory,targetDirectory)
        return
    else
        try
            targetFile = fullfile(targetDirectory,modelDetails.customFile);
            originalFile = fullfile(currentDirectory,modelDetails.customFile);
            [success,message,id] = copyfile(originalFile,targetFile);
            %copyString = ['!xcopy /s /d /y "' originalFile '" "' targetFile '"'];
            originalFile(findstr(sep,originalFile)) = '/';
            targetFile(findstr(sep,targetFile)) = '/';
            addInfoText(['Copying ' char(39) originalFile char(39) ' to ' char(39) targetFile char(39) ]);
            %eval(copyString);
        catch
            addInfoText('Warning: custom m-file could not be found');
        end
    end  
end

fr.dispose();

end

%-------------------------------------------------------------------------

end