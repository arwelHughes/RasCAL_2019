function importModelFile(src,ev)


import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');

loadFileWindow = JInternalFrame();
loadFileWindow.setSize(500,400);
loadFileWindow.setTitle('Import Filename?');
loadFileWindow.setMaximizable(false);
loadFileWindow.setIconifiable(true);
loadFileWindow.setClosable(false);
loadFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',loadFileWindow);

chooser = JFileChooser(pwd);

filter = ExampleFileFilter('rmf');
filter.setDescription('Rascal Model Files');
chooser.addChoosableFileFilter(filter);
chooser.setDialogType(JFileChooser.OPEN_DIALOG);
set(chooser,'ActionPerformedCallback',@importModelFileCallback);
loadFileWindow.add(chooser);

desktop.setLayer(loadFileWindow,3);
desktop.add(loadFileWindow);
loadFileWindow.setLocation(200,200);


end

%--------------------------------------------------------------------------

function importModelFileCallback(src,ev)

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end


fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened,'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    return
end

MPcomponents = getappdata(0,'MPComponents');

thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);


strng = ['load -mat ' char(39) path char(39)];
eval(strng);
%load -mat samOnly.rmf

if ~exist('model','var') && exist('modelDetails','var')
    model = modelDetails;
end

%Replace the Params....
paramsTable = getappdata(0,'editGuiParamsTable');
paramsTableModel = paramsTable.getModel;

numberOfParams = paramsTableModel.getRowCount;

%Remove the old parameters....
for i = 0:numberOfParams-1
    switch model.type
        case 'Standard Layers'
            thisName = awtinvoke(paramsTableModel,'getValueAt(II)',0,0);
            cboxremoveItem(thisName);
    end
    awtinvoke(paramsTableModel,'removeRow(I)',0);
end

%add the new ones....
newParamsNamesList = {};
for i = 1:length(model.params);
    thisNewRow = model.params{i};
    paramsTableModel.addRow(thisNewRow);
    newParamName = thisNewRow{1};
    newParamsNamesList{i} = newParamName;
    cboxAddItem(newParamName);
end

setappdata(0,'paramsNamesList',newParamsNamesList);

%Now, if necessary do the layers table mods....

switch modelDetails.type
    case 'Standard Layers'
        MPcomponents.typeComboBox.setSelectedIndex(0);
        layersTable = getappdata(0,'layersTable');
        layersModel = layersTable.getModel;
        numberOfLayersOld = layersModel.getRowCount();

        for i = 0:numberOfLayersOld-1;
            awtinvoke(layersModel,'removeRow(I)',0);
        end

        theNewLayers = model.layersDetails;
        newLayersNamesList = {};

        numberOfLayersNew = length(theNewLayers);
        for i = 0:numberOfLayersNew-1;
            thisRow = theNewLayers{i+1};
            name = thisRow{5};
            rowData = { name , '' , '' , '', '' , 'bulk out'};
            layersModel.addRow(rowData);
            newLayersNamesList{i+1} = name;
        end

        for i = 0:numberOfLayersNew-1;
            thisRow = theNewLayers{i+1};

            dThisRow = thisRow{1};
            dThisRowName = newParamsNamesList{str2num(dThisRow)};
            awtinvoke(layersModel,'setValueAt',dThisRowName,i,1);

            sldThisRow = thisRow{2};
            sldThisRowName = newParamsNamesList{str2num(sldThisRow)};
            awtinvoke(layersModel,'setValueAt',sldThisRowName,i,2);

            roughThisRow = thisRow{3};
            roughThisRowName = newParamsNamesList{str2num(roughThisRow)};
            awtinvoke(layersModel,'setValueAt',roughThisRowName,i,3);

            hydrThisRow = thisRow{4};
            if ~isempty(hydrThisRow)
                hydrThisRowName = newParamsNamesList{str2num(hydrThisRow)};
                awtinvoke(layersModel,'setValueAt',hydrThisRowName,i,4);
            else
                awtinvoke(layersModel,'setValueAt','',i,4);
            end

            hydrWithWhat =  thisRow{6};
            awtinvoke(layersModel,'setValueAt',hydrWithWhat,i,5);

            pause(0.1)
        end

        %The combo-boxes from the contrast tables....
        boxes = getappdata(0,'contrastEditPanelTablesCombos');
        layersComboBox = boxes.layers;

        %Get all the contrasts panels layers tables....
        tables = getappdata(0,'allContrastTables');

        %Make a list of the layers names im the existing tables...
        for i = 1:length(tables);
            thisTable = tables{i};
            thisModel = thisTable.getModel;
            numberOfRows = thisModel.getRowCount();
            thisTableVals = {};
            for n = 1:numberOfRows-2;
                thisTableVals{n} = thisModel.getValueAt(n,1);
            end
            oldTableVals{i} = thisTableVals;
        end

        %Clear the existing layers tables combo box...
        NumberOfoldLayersNames = layersComboBox.getItemCount();
        for i = 1:NumberOfoldLayersNames;
            layersComboBox.removeItemAt(0);
        end

        %Add the new Layers names..
        for i = 1:length(newLayersNamesList);
            layersComboBox.addItem(newLayersNamesList{i});
        end

        %Go through each contrast panel table combo box. Select the layer name if it is the same as the
        %old. Otherwise, leave blank.
        for i = 1:length(tables);
            thisTable = tables{i};
            thisModel = thisTable.getModel;
            thisOldVals = oldTableVals{i};
            for n = 1:length(thisOldVals);
                oldValue = thisOldVals{n};
                if any(strcmp(oldValue,newLayersNamesList));
                    thisModel.setValueAt(oldValue,n,1);
                else
                    thisModel.setValueAt('',n,1);
                end
            end
        end
    
    case 'Custom Layers'
        MPcomponents.typeComboBox.setSelectedIndex(1);
        
    otherwise
        MPcomponents.typeComboBox.setSelectedIndex(2);
        disp('test');
end

%if necessary, copy the custom file.
if ~strcmp(modelDetails.type,'Standard Layers');
    details = get(src,'SelectedFile');
    path = char(details.getPath);
    name = char(details.getName);
    justPath = path(1:(findstr(name,path)-1));
    originalFile = fullfile(justPath,modelDetails.customFile);
    targetFile = fullfile(pwd,modelDetails.customFile);
    [success,message,id] = copyfile(originalFile,targetFile);
    %copyString = ['!xcopy /s /d /y "' originalFile '" "' targetFile '"'];
    originalFile(findstr(sep,originalFile)) = '/';
    targetFile(findstr(sep,targetFile)) = '/';
    addInfoText(['Copying ' char(39) originalFile char(39) ' to ' char(39) targetFile char(39) ]);
    MPcomponents.customFileTextField.setText(modelDetails.customFile);
end

%Finally need to set the custom model name....




fr.dispose;

end












