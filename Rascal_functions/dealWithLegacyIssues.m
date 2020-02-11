function problem = dealWithLegacyIssues(problem)


if strcmp(problem.module.type,'Standard Layers')
    if (~any(ismember(fields(problem),'repeatLayers')))
        for i = 1:problem.numberOfContrasts
            problem.repeatLayers{i} = [0 1];
        end
    end
    for i = 1:problem.numberOfContrasts
        if length(problem.repeatLayers{i}) < 2
            problem.repeatLayers{i} = [0 1];
        end
    end
end

%Deal with the fact that fittable resolution may have been absent in previous
%versions
if ~any(ismember(fields(problem),'resolution_constr'))
    numberOfResolutions = length(problem.resolution);
    problem.numberOfResolutions = numberOfResolutions;
    for i = 1:numberOfResolutions
        problem.resolution_constr(i,1) = 0.01;
        problem.resolution_constr(i,2) = 0.05;
        problem.resolution_fityesno(i) = 0;
        problem.resolNames{i} = ['Resolution ' num2str(i)];
    end
    
    for i = 1:problem.numberOfContrasts
        problem.contrastResolutions(i) = 1;
    end
end

%Resolution type not saved in previous versions
if ~any(ismember(fields(problem),'resolType'))
    problem.resolType = 1;
end

%Deal with fact that file type was not saved in previous versions..
if ~any(ismember(fields(problem),'contrastFileTypes'))
    problem.contrastFileTypes = ones(problem.numberOfContrasts,1);
    problem.forceReload = zeros(problem.numberOfContrasts,1);
end

%Deal with the introduction of ROI's
if ~any(ismember(fields(problem.calculations),'rois'))
    problem.calculations.rois = {};
end

% Change the LayersDetails to make the strings into
% numbers in the cells to speed up the calculation
layersDetails = problem.layersDetails;
numberOfLayers = length(layersDetails);
for i = 1:numberOfLayers
    thisLayer = layersDetails{i};
    % Need to convert first 4 params if they are strings
    for n = 1:4
        thisVal = thisLayer{n};
        if ischar(thisVal)
            newVal = str2num(thisVal);
            thisLayer{n} = newVal;
        end
    end
    layersDetails{i} = thisLayer;
end
problem.layersDetails = layersDetails;    
        
% If not currently present, include flags to 
% show which contrasts should be resampled
% Also need to make sure there is one flag
% for each contrast.
numberOfContrasts = problem.numberOfContrasts;
if ~any(ismember(fields(problem),'resample')) || ...      
      (length(problem.resample) ~= numberOfContrasts)
   problem.resample = zeros(1,numberOfContrasts);
end

if ~isfield(problem,'calcSLD')
    problem.calcSLD = 1;
end
        
if ~isfield(problem,'resampleNLayers')
    problem.resampleNLayers = 50;
end
    
if ~isfield(problem,'resampleAngle')
    problem.resampleAngle = 0.7;
end

% Add a priors structure if not already present
priors = {};
if ~isfield(problem,'priors')
   nParams = length(problem.params);
   nBacks = problem.numberOfBacks;
   nShifts = problem.numberOfShifts;
   nScales = problem.numberOfScales;
   nNbas = problem.numberOfNbas;
   nNbss = problem.numberOfNbss;
   nResol = problem.numberOfResolutions;
   
   totalPars = nParams + nBacks + nShifts + nScales + ...
       nNbas + nNbss + nResol;
   counter = 1;
   
   for i = 1:nParams
       thisName = problem.paramnames{i};
       thisVal = problem.params(i);
       thisMin = problem.constr(i,1);
       thisMax = problem.constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end
   
   for i = 1:nBacks
       thisName = problem.backsNames{i};
       thisVal = problem.backs(i);
       thisMin = problem.backs_constr(i,1);
       thisMax = problem.backs_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end
   
   for i = 1:nShifts
       thisName = problem.shiftsNames{i};
       thisVal = problem.shifts_horisontal(i);
       thisMin = problem.shifts_constr(i,1);
       thisMax = problem.shifts_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end
   
    for i = 1:nScales
       thisName = problem.scalesNames{i};
       thisVal = problem.scalefac(i);
       thisMin = problem.scale_constr(i,1);
       thisMax = problem.scale_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end  
    
   for i = 1:nNbas
       thisName = problem.nbaNames{i};
       thisVal = problem.nba(i);
       thisMin = problem.nbairs_constr(i,1);
       thisMax = problem.nbairs_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end    


   for i = 1:nNbss
       thisName = problem.nbsNames{i};
       thisVal = problem.nbs(i);
       thisMin = problem.nbsubs_constr(i,1);
       thisMax = problem.nbsubs_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end    
 
   for i = 1:nResol
       thisName = problem.resolNames{i};
       thisVal = problem.resolution(i);
       thisMin = problem.resolution_constr(i,1);
       thisMax = problem.resolution_constr(i,2);
       mu = 0;
       sig = Inf;
       thisRow = {thisName thisVal thisMin thisMax mu sig};
       priors{counter,1} = thisRow;
       counter = counter + 1;
   end    
   
   problem.priors = priors;
end