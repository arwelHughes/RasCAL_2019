function [out,problem] = makeProblemFromGui()

out = [];
newProblem = [];
oldProblem = getappdata(0,'originalProblem');
clearInfoText();

mainPane = getappdata(0,'mainPane');
internalFrame = getappdata(0,'mainFrame');
allPanels = getappdata(0,'allPanels');
internalFrame = getappdata(0,'internalFrame');

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end


%1 General.
generalPanel = allPanels.generalPanel;
pathTextField = generalPanel.getPathTextField();
path = pathTextField.getText;
if exist(char(path))~=7
    addInfoText('Specified path is not a directory. Please check');
    out{1} = 'fail';
    out{2} = 'Problem path not found';
    return
end
problem.path = char(path);

nameTextField = generalPanel.getNameTextField();
name = nameTextField.getText;
problem.name = {char(name)};

numberOfContTxtField = generalPanel.getNumberOfContrastsTextField();
numberOfContrasts = str2double(numberOfContTxtField.getText);
problem.numberOfContrasts = numberOfContrasts;

typeComboBox = generalPanel.getTypeComboBox();
item = char(typeComboBox.getSelectedItem());
problem.module.type = item;

fileTextField = generalPanel.getCustomFileTextField();
switch item
    case 'Standard Layers'
        problem.module.name = 'standard_box_new';
    otherwise
        problem.module.name = char(fileTextField.getText);
end

problem.module.calculation_type = 'parratt';

typeTextField = generalPanel.getGeometryComboBox();
problem.module.experiment_type = char(typeTextField.getSelectedItem);


%2 Parameters.
paramsTable =  getappdata(0,'editGuiParamsTable');
paramsTableModel = paramsTable.getModel;
numberOfRows = paramsTableModel.getRowCount;
for i = 1:numberOfRows;
    thisPName = paramsTableModel.getValueAt(i-1,0);
    thisPMin = paramsTableModel.getValueAt(i-1,1);
    thisPVal = paramsTableModel.getValueAt(i-1,2);
    thisPMax = paramsTableModel.getValueAt(i-1,3);
    
    if ~isfinite(thisPMin)
        %addInfoText(sprintf('Parameter %d minimum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Parameter %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(thisPVal)
        %addInfoText(sprintf('Parameter %d value not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Parameter %d value not defined',i);
        return
    end
    
    if ~isfinite(thisPMax)
        %addInfoText(sprintf('Parameter %d maximum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Parameter %d maximum range not defined',i);
        return
    end
 
    problem.paramnames{i} = thisPName;
    problem.constr(i,1) = thisPMin;
    problem.constr(i,2) = thisPMax;
    problem.params(i) = thisPVal;
    problem.fityesno(i) = 1;
    problem.fiterrs(i) = 0;
end

allNames = problem.paramnames;
for i = 1:numberOfRows
    thisStr = problem.paramnames{i};
    where = any(strcmp(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('Two parameters have the same name. This is not allowed');
        return
    end
end

% 3 layers
% This has now been modified so that layers details
% are now stored as doubles rather than strings
% to speed up the later calculations.
switch item
    case 'Standard Layers'
        layersTable = getappdata(0,'layersTable');
        lTableModel = layersTable.getModel;
        numberOfLayers = lTableModel.getRowCount();
        problem.numberOfLayers = numberOfLayers;
        if numberOfLayers == 0
            problem.layersDetails = {};
            layNamesList = {};
        else

            for i = 1:numberOfLayers
                dThisLay = lTableModel.getValueAt(i-1,1);
                if isempty(dThisLay)
                    %addInfoText(sprintf('Layer %d thickness is undefined',i));
                    out{1} = 'fail';
                    out{2} = sprintf('Layer %d thickness is undefined',i);
                    return
                end
                where_d = find(strcmp(dThisLay,problem.paramnames));
                %thisLay{1} = num2str(where_d);
                thisLay{1} = where_d;
                %problem.layersDetails{i,1} = num2str(where_d);

                sldThisLay = lTableModel.getValueAt(i-1,2);
                if isempty(sldThisLay)
                    %addInfoText(sprintf('Layer %d thickness is undefined',i));
                    out{1} = 'fail';
                    out{2} = sprintf('Layer %d SLD is undefined',i);
                    return
                end                
                where_sld = find(strcmp(sldThisLay,problem.paramnames));
                %thisLay{2} = num2str(where_sld);
                thisLay{2} = where_sld;
                %problem.layersDetails{i,2} = num2str(where_sld);

                rThisLay = lTableModel.getValueAt(i-1,3);
                if isempty(rThisLay)
                    %addInfoText(sprintf('Layer %d thickness is undefined',i));
                    out{1} = 'fail';
                    out{2} = sprintf('Layer %d roughness is undefined',i);
                    return
                end                 
                where_rough = find(strcmp(rThisLay,problem.paramnames));
                %thisLay{3} = num2str(where_rough);
                thisLay{3} = where_rough;
                %problem.layersDetails{i,3} = num2str(where_rough);

                covThisLay = lTableModel.getValueAt(i-1,4);
                where_cov = find(strcmp(covThisLay,problem.paramnames));
                %thisLay{4} = num2str(where_cov);
                thisLay{4} = where_cov;
                %problem.layersDetails{i,4} = num2str(where_cov);

                nameThisLay = lTableModel.getValueAt(i-1,0);
                thisLay{5} = nameThisLay;
                layNamesList{i} = nameThisLay;
                %problem.layersDetails{i,5} = nameThisLay;
                
                fillWithWhatThisLay = lTableModel.getValueAt(i-1,5);
                thisLay{6} = fillWithWhatThisLay;
                
                problem.layersDetails{i} = thisLay;
            end
        end
    otherwise
        problem.layersDetails = '';
        problem.numberOfLayers = 0;
end


%Experiment Params....
%1. backgrounds....
backsTable = getappdata(0,'editGuiBacksTable');
bTableModel = backsTable.getModel;
numberOfBacks = bTableModel.getRowCount;
problem.numberOfBacks = numberOfBacks;
for i = 1:numberOfBacks;
    problem.backgrounds_fityesno(i) = 0;
    problem.backsNames{i} = bTableModel.getValueAt(i-1,0);
    problem.backs_constr(i,1) = bTableModel.getValueAt(i-1,1);
    problem.backs(i) = bTableModel.getValueAt(i-1,2);
    problem.backs_constr(i,2) = bTableModel.getValueAt(i-1,3);
    
    if ~isfinite(problem.backs_constr(i,1))
        %addInfoText(sprintf('Parameter %d minimum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Background %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.backs(i))
        %addInfoText(sprintf('Parameter %d value not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Background %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.backs_constr(i,2))
        %addInfoText(sprintf('Parameter %d maximum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('Background %d maximum range not defined',i);
        return
    end
end

allNames = problem.backsNames;
for i = 1:numberOfBacks
    thisStr = problem.backsNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('Two backgrounds have the same name. This is not allowed');
        return
    end
end

%2. Qshifts
shiftsTable = getappdata(0,'editGuiShiftsTable');
shTableModel = shiftsTable.getModel;
numberOfShifts = shTableModel.getRowCount;
problem.numberOfShifts = numberOfShifts;
for i = 1:numberOfShifts
    problem.shifts_fityesno(i) = 0;
    problem.shiftsNames{i} = shTableModel.getValueAt(i-1,0);
    problem.shifts_constr(i,1) = shTableModel.getValueAt(i-1,1);
    problem.shifts_horisontal(i) = shTableModel.getValueAt(i-1,2);
    problem.shifts_constr(i,2) = shTableModel.getValueAt(i-1,3);
    
    if ~isfinite(problem.shifts_constr(i,1))
        %addInfoText(sprintf('Parameter %d minimum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('qz shift %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.shifts_horisontal(i))
        %addInfoText(sprintf('Parameter %d value not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('qz shift %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.shifts_constr(i,2))
        %addInfoText(sprintf('Parameter %d maximum range not defined',i));
        out{1} = 'fail';
        out{2} = sprintf('qz shift %d maximum range not defined',i);
        return
    end
end

allNames = problem.shiftsNames;
for i = 1:numberOfShifts
    thisStr = allNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('Two qz shifts have the same name. This is not allowed');
        return
    end
end

%3. Scale factors 
scalesTable = getappdata(0,'editGuiScalesTable');
scTableModel = scalesTable.getModel;
numberOfScales = scTableModel.getRowCount;
problem.numberOfScales = numberOfScales;
for i = 1:numberOfScales
    problem.scalefac_fityesno(i) = 0;
    problem.scalesNames{i} = scTableModel.getValueAt(i-1,0);
    problem.scale_constr(i,1) = scTableModel.getValueAt(i-1,1);
    problem.scalefac(i) = scTableModel.getValueAt(i-1,2);
    problem.scale_constr(i,2) = scTableModel.getValueAt(i-1,3);
    
    if ~isfinite(problem.scale_constr(i,1))
        out{1} = 'fail';
        out{2} = sprintf('scalefactor %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.scalefac(i))
        out{1} = 'fail';
        out{2} = sprintf('scalefactor %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.scale_constr(i,2))
        out{1} = 'fail';
        out{2} = sprintf('scalefactor %d maximum range not defined',i);
        return
    end  
end

allNames = problem.scalesNames;
for i = 1:numberOfScales
    thisStr = allNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('Two scalefactors have the same name. This is not allowed');
        return
    end
end

%4. Nbairs 
nbaTable = getappdata(0,'editGuiNbaTable');
nbaTableModel = nbaTable.getModel;
numberOfNbas = nbaTableModel.getRowCount;
problem.numberOfNbas = numberOfNbas;
for i = 1:numberOfNbas
    problem.nbairs_fityesno(i) = 0;
    problem.nbaNames{i} = nbaTableModel.getValueAt(i-1,0);
    problem.nbairs_constr(i,1) = nbaTableModel.getValueAt(i-1,1);
    problem.nba(i) = nbaTableModel.getValueAt(i-1,2);
    problem.nbairs_constr(i,2) = nbaTableModel.getValueAt(i-1,3);
    
    if ~isfinite(problem.nbairs_constr(i,1))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk in %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.nba(i))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk in %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.nbairs_constr(i,2))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk in %d maximum range not defined',i);
        return
    end  
end

allNames = problem.nbaNames;
for i = 1:numberOfNbas
    thisStr = allNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('two bulk in parameters have the same name. This is not allowed');
        return
    end
end

%5 NbSubs
nbsTable = getappdata(0,'editGuiNbsTable');
nbsTableModel = nbsTable.getModel;
numberOfNbss = nbsTableModel.getRowCount;
problem.numberOfNbss = numberOfNbss;
for i = 1:numberOfNbss
    problem.nbsubs_fityesno(i) = 0;
    problem.nbsNames{i} = nbsTableModel.getValueAt(i-1,0);
    problem.nbsubs_constr(i,1) = nbsTableModel.getValueAt(i-1,1);
    problem.nbs(i) = nbsTableModel.getValueAt(i-1,2);
    problem.nbsubs_constr(i,2) = nbsTableModel.getValueAt(i-1,3);

    if ~isfinite(problem.nbsubs_constr(i,1))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk out %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.nbs(i))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk out %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.nbsubs_constr(i,2))
        out{1} = 'fail';
        out{2} = sprintf('sld bulk out %d maximum range not defined',i);
        return
    end  
end

allNames = problem.nbsNames;
for i = 1:numberOfNbss
    thisStr = allNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('two bulk out parameters have the same name. This is not allowed');
        return
    end
end    
    

%6. Resolutions
resolTable = getappdata(0,'editGuiResolTable');
resolTableModel = resolTable.getModel;
numberOfResolutions = resolTableModel.getRowCount;
problem.numberOfResolutions = numberOfResolutions;
for i = 1:numberOfResolutions
    problem.resolution_fityesno(i) = 0;
    problem.resolNames{i} = resolTableModel.getValueAt(i-1,0);
    problem.resolution_constr(i,1) = resolTableModel.getValueAt(i-1,1);
    problem.resolution(i) = resolTableModel.getValueAt(i-1,2);
    problem.resolution_constr(i,2) = resolTableModel.getValueAt(i-1,3);

    if ~isfinite(problem.resolution_constr(i,1))
        out{1} = 'fail';
        out{2} = sprintf('resolution %d minimum range not defined',i);
        return
    end
    
    if ~isfinite(problem.resolution(i))
        out{1} = 'fail';
        out{2} = sprintf('resolution %d value not defined',i);
        return
    end
    
    if ~isfinite(problem.resolution_constr(i,2))
        out{1} = 'fail';
        out{2} = sprintf('resolution %d maximum range not defined',i);
        return
    end  
end

allNames = problem.resolNames;
for i = 1:numberOfResolutions
    thisStr = allNames{i};
    where = cell2mat(strfind(allNames,thisStr));
    if length(where) > 1
        %addInfoText(sprintf('Parameters %d and %d have the same name. this is not allowed',where(1),where(2)));
        out{1} = 'fail';
        out{2} = sprintf('two resolution parameters have the same name. This is not allowed');
        return
    end
end  

%7 Now the contrasts
theContrastPanels = getappdata(0,'allContrastPanels');
theContrastTables = getappdata(0,'allContrastTables');
%numberOfContrasts = length(theContrastPanels);
problem.numberOfContrasts = numberOfContrasts;

for i = 1:numberOfContrasts
    thePanel = theContrastPanels{i};
    thisContrastTable = theContrastTables{i};
    
    nameTextField = thePanel.getContrastNameTextField();
    typeComboBox = thePanel.getTypeComboBox();
    fileTextField = thePanel.getFileTextField();
    backgroundComboBox = thePanel.getBackgroundComboBox();
    scalefacComboBox = thePanel.getScalefacComboBox();
    shiftsComboBox = thePanel.getShiftComboBox();
    numberOfLayersBox = thePanel.getNumberOfLaysTextBox();
    resolComboBox = thePanel.getResolComboBox();
    dataTypeComboBox = thePanel.getFileTypeComboBox();
    reloadRadioButton = thePanel.getReloadFileButtonGroup();
    
    thisType = typeComboBox.getSelectedItem();
    problem.contrastTypes{i} = thisType;
    
    thisDataType = dataTypeComboBox.getSelectedIndex();
    problem.contrastFileTypes(i) = thisDataType;
    
    problem.forceReload(i) = reloadRadioButton.isSelected;
    
    previous = getappdata(thePanel,'UserData');
    ff = fields(previous);
    if any(strcmp(ff,'data'))
        oldData{i} = previous.data;
    else
        oldData{i} = [];
    end
    
    minSimVal = str2num(previous.simMin);
    maxSimVal = str2num(previous.simMax);
    problem.simLimits{i} = [minSimVal maxSimVal];
    
    minDatVal = str2num(previous.datMin);
    maxDatVal = str2num(previous.datMax);
    problem.dataLimits{i} = [minDatVal maxDatVal];
    problem.fitlowrange(i) = minDatVal;
    problem.fithirange(i) = maxDatVal;
    
    repeatsOn = previous.repeatsOn;
    repeatsNum = str2num(previous.repeatNumber);
    problem.repeatLayers{i} = [repeatsOn repeatsNum];
    
    fullPath = char(fileTextField.getText());
    if ~isempty(find(fullPath == '\', 1))
        slashes = find(fullPath == '\');
    else
        slashes = find(fullPath == '/');
    end
    
    if ~isempty(slashes)
        problem.datapath{i} = fullPath(1:slashes(end));
        problem.contrastFiles{i} = fullPath(slashes(end)+1:end);
    else
        problem.datapath{i} = fullfile(problem.path,'datafiles');
        if length(oldProblem.contrastFiles) >= i
            problem.contrastFiles{i} = oldProblem.contrastFiles{i};
        else
            problem.contrastFiles{i} = '';
        end
    end
    
    problem.contrastNames{i} = nameTextField.getText();
    
    back = backgroundComboBox.getSelectedItem();
    problem.contrastBacks(i) = find(strcmp(back,problem.backsNames));
    
    scale = scalefacComboBox.getSelectedItem();
    problem.contrastScales(i) = find(strcmp(scale,problem.scalesNames));   
    
    shift = shiftsComboBox.getSelectedItem();
    problem.contrastShifts(i) = find(strcmp(shift,problem.shiftsNames));  
    
    resolution = resolComboBox.getSelectedItem();
    problem.contrastResolutions(i) = find(strcmp(resolution,problem.resolNames));  
    
    tableModel = thisContrastTable.getModel();
    nba = tableModel.getValueAt(0,1);
    if isempty(nba)
        out{1} = 'fail';
        out{2} = sprintf('Missing value for bulk out in contrast %d',i);
        return
    end
   
    problem.contrastNbas(i) = find(strcmp(nba,problem.nbaNames)); 

    nbs = tableModel.getValueAt(thisContrastTable.getRowCount-1,1);
    if isempty(nbs)
        out{1} = 'fail';
        out{2} = sprintf('Missing value for bulk out on contrast %d',i);
        return
    end
    problem.contrastNbss(i) = find(strcmp(nbs,problem.nbsNames));
    
    %problem.repeatLayers{i} = '1';
    
    switch item
        case 'Standard Layers'
            thisContrastTable = theContrastTables{i};
            thisModel = thisContrastTable.getModel;
            layString = '';
            for n = 1:str2double(numberOfLayersBox.getText())
                thisLay = thisModel.getValueAt(n,1);
                whichLayer = find(strcmp(layNamesList,thisLay));
                if isempty(whichLayer)
                    out{1} = 'fail';
                    out{2} = sprintf('layer %d in contrast %d is not defined',n,i);
                    return
                end
                layString = [layString num2str(whichLayer) ','];
            end
            problem.contrastLayers{i} = layString;
            problem.contrastsNumberOfLayers(i) = str2double(numberOfLayersBox.getText());
        otherwise
            problem.contrastLayers{i} = '';
            problem.contrastsNumberOfLayers(i) = 0;
    end
%    problem = parseOpenGenieWindow(problem,i);
end

%Deal with loading data
try
    problem = rLoadDataFile(problem);
catch
    out{1} = 'fail';
    out{2} = 'there was a serious problem with loading one of the datafiles';
    return
end
 
%re-set the data limits if the data is different
for i = 1:numberOfContrasts
    thisData = problem.data{i};
    prevData = oldData{i};
    if ~isequal(thisData,prevData)
        problem.dataLimits{i} = [thisData(1,1) thisData(end,1)];
        problem.simLimits{i} = [thisData(1,1) thisData(end,1)];
    end
end





if strcmp(item,'Standard Layers')
    setappdata(0,'layersNamesList',layNamesList)
end

problem.calculations.xtra_fitness = 0;
problem.calculations.reflectivity = {};
problem.calculations.Simulation = {};
problem.calculations.simFresnel = {};
problem.calculations.slds = {};
problem.calculations.all_chis = [];
problem.calculations.sum_chi = [];
problem.calculations.rois = [];
problem.calculations.roiMasks = {};
problem.calculations.resids = {};

%legacy....
% for i = 1:numberOfContrasts;
%     problem.backgrounds_appliesto{i} = '1';
%     problem.shifts_appliesto{i} = '1';
%     problem.scalefac_appliesto{i} = '1';
%     problem.nbairs_appliesto{i} = '1';
%     problem.nbsubs_appliesto{i} = '1';
%     %problem.repeatLayers{i} = [0 1];
% 
% end

out{1} = 'ok';




