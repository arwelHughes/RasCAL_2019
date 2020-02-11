function contrastLayersList = standardLayers(problem)

% This function deals with a 'Standard Layers'
% calculation type. It takes the call array of layers details
% and makes up a N x 5 array of [d rho rough Hydration HydrateWhat] of
% actual values from the parameters array. 
% It does this for all the layers in problem.layersDetails.
% It then 

% First get the relevant information out
layers = problem.layersDetails;
numberOfLayers = problem.numberOfLayers;
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
params = problem.params;
geometry = problem.module.experiment_type;
params = problem.params;
numberOfContrasts = problem.numberOfContrasts;

% LayersDetails comes in as a cell array, with parameters as indicies
% to the relevant parameters in the params array. We need to replace
% this with an array of the actual parameter values in problem.layersList

% pre-allocation
layersList = cell(1,numberOfContrasts);

% If there are no layers then layersList is empty
if numberOfLayers == 0
    layersList = [];
else
    % Loop over the number of layers
    for n = 1:numberOfLayers
        thisLayer = layers{n};
        
        % Get the relevant parameters from the params array
        for m = 1:4
            thisItemString = thisLayer{m};
            if isempty(findstr(thisItemString,'NaN')) && ~isempty(thisItemString);
                layersValues(n,m) = params(str2double(thisItemString));
            else
                layersValues(n,m) = NaN;
            end
        end
        
        % Determine which bulk is doing the 'hydrating'
        whichBulk = thisLayer{6};
        if strcmp(whichBulk,'bulk in')
            layersValues(n,5) = 0;
        else
            layersValues(n,5) = 1;
        end
    end
end

% We now have real parameters in the layers array in 'layersValues'
% Now we need to arrange these for each contrast
for i = 1:numberOfContrasts  
    thisLayersList = [];
    thisContrast = problem.contrastLayers(i);
    a = cell2mat(cellfun(@str2num,thisContrast,'uniform',0));
    if ~isempty(a)
        for n = 1:length(a)
            thisRow = a(n);
            thisLayersList(n,:) = layersValues(thisRow,:);
        end
    else
        thisLayersList = [];
    end
    contrastLayersList{i} = thisLayersList;
end

end