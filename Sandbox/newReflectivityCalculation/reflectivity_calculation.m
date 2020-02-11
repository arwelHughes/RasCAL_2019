function reflectivity_calculation()
% Reflectivity_calculation is called without an argument
% but fetches 'problem' from 'appdata'. It relies on the 
% rest of RasCAL to ensure that this is up to date

% Load 'problem'
problem = getappdata(0,'problem');
numberOfContrasts = problem.numberOfContrasts;
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
simLimits = problem.simLimits;
geometry = problem.module.experiment_type;

%Apply corrections to all datasets.
problem = unpackparams(problem);
problem = backsorts(problem);
problem = shiftdata(problem);

% Decide what kind of problem it is
% and call the relevant routine
switch problem.module.type
    case 'Standard Layers'
        contrastLayersList = standardLayers(problem);
    case 'Custom Layers'
        contrastLayersList = customLayers(problem);
    case 'Custom XY Profile'
        [contrastLayersList, SLDs] = customXY(problem);
end

% Now we need to loop over all the contrasts (if a layers model)
% and deal with the hydration of each layer, and also the geometry.
for i = 1:numberOfContrasts
   switch problem.module.type
       case {'Standard Layers', 'Custom Layers'}
           theseLayers = contrastLayersList{i};
           if isempty(theseLayers)
               theseLayers = [0 0 0];
           end
           %layers = zeros(size(theseLayers,1),3);
           
           % Need the thicks and roughs and SLD for each layer
           % but then correct the SLD for hydration (unless already
           % done in a custom layers model).
           cols = size(theseLayers,2);
           if cols == 5
               layers = theseLayers(:,1:3);
               for j = 1:size(theseLayers,1)
                   this_pcw = theseLayers(j,4);
                   if theseLayers(j,5) == 1
                       pc_add = nbsubs(i);
                   else
                       pc_add = nbairs(i);
                   end
                   if ~isnan(this_pcw)
                       layers(j,2) = pc_add*(this_pcw/100) + (1-(this_pcw/100))*layers(j,2);
                   end
               end
           else
               layers = theseLayers;
           end
           
           % Layers is now an N x 3 array of [d rho rough]
           % Now we need to correct for geometry. The substrate roughness
           % is a key parameter in soft-matter since it
           % can affect sample physics, so it is always
           % defined in a RasCAL model. For each layer model
           % there are always n+1 roughness' for an n layer stack
           % The reflectivity calculation expects the first roughness
           % in the nx3 stack to be the first interface the beam meets
           % and then last interface it sees is passed as an extra
           % parameter. For solid-liquid the substrate roughness is the
           % first interface met, whereas for air solid it is the last
           % so we arrange the stack accordingly.
           switch geometry
               case 'Air / Liquid (or solid)'
                   % Nothing needs to be done and we use the layers stack
                   % as is. The last roughness is substrate roughness
                   rLast(i) = problem.params(1);
                   
               case 'Solid / Liquid'
                   % Now we need to rearrange things
                   % ssub needs to be the first roughness
                   % in the stack, and the last roughness of
                   % the layer stack is 'rLast'
                   allRoughs = layers(:,3);
                   subRough = problem.params(1);
                   rLast(i) = allRoughs(end);
                   allRoughs = circshift(allRoughs,1);
                   allRoughs(1) = subRough;
                   layers(:,3) = allRoughs;
           end               
       case 'Custom XY Profile'
           layers = contrastLayersList{i};
   end
   allLayers{i} = layers;
   rLast(i) = eps;  %All roughness' are in the XY curve
end
           
% Now deal with the qz range of each contrast. It is possible for the
% simulation range to be larger than the data range. So, we make 'xdata'
% for each contrast to extend the range if necessary. If there is no 
% data then make a uniform xdata between the relevant simulation 
% limits.
for i = 1:numberOfContrasts
    if problem.dataPresent(i)
        thisData = problem.data{i};
        xdata = thisData(:,1);
        
        simXLo = simLimits{i}(1);
        simXHi = simLimits{i}(2);
        
        middleSection = thisData(:,1);
        
        if simXLo < xdata(1)
            step = (xdata(2)-xdata(1));
            firstSection = [simXLo:step:(xdata(1)-step)];
        else
            firstSection = [];
        end
        
        if simXHi > xdata(end)
            step = (xdata(end)-xdata(end-1,1));
            lastSection = [xdata(end,1)+step:step:simXHi];
        else
            lastSection = [];
        end
        
        simXdata{i}= [firstSection(:) ; middleSection ; lastSection(:)]';
        trueXdata{i} = middleSection(:);
        simXdata_splits{i} = [length(firstSection) length(middleSection(:,1)) length(lastSection)];
        repeats(i) = problem.repeatLayers{i}(2);
    end
end

% Now we need to call the paratt calculation. 
% 'callParatt' calculates the reflectivity profile of each contrast
% and applies the resolution smearing. When using the
% mex version it paralellises using openMP. The matlab
% version will parallelise using the paralell computing
% toolbox if present.
repeats = problem.repeatLayers;     %Number of times the stack repeats
resolutions = problem.resolutions;
repeats = cell2mat(repeats');
repeats = repeats(:,2);

% This parallelises over the contrasts with OpenMP. It calculates the 
% reflectivity using Parrat's recursive algorithm, and then applies
% a Gaussian smearing with a constant resolution.
simRef = callParatt_mex(simXdata(:),allLayers(:),nbairs(:),nbsubs(:),repeats(:),resolutions(:),rLast(:));

% Need to break out the reflectivity for the actual data range
% from the potentially bigger simulation. Also, we add backgrounds.
% Where required we also calculate the SLD profiles.
backgrounds = problem.backgrounds;
for i = 1:numberOfContrasts
    splits = simXdata_splits{i};
    firstSection = splits(1);
    middleSection = splits(2);
    Ref = simRef{i};
    Ref = Ref((firstSection+1):(firstSection+middleSection));
    Ref = Ref + backgrounds(i);
    simRef{i} = simRef{i} + backgrounds(i);
    reflectivity{i} = [trueXdata{i} Ref(:)];
    Simulation{i} = [simXdata{i}' simRef{i}];
    
    switch problem.module.type
        case {'Standard Layers', 'Custom Layers'}
            theseLayers = allLayers{i};
            numberOfLayers = size(theseLayers,1);
            sldProfiles{i} = makeSLDProfileXY(nbairs(i),nbsubs(i),rLast(i),allLayers{i},numberOfLayers,repeats(i));
        case 'Custom XY Profile'
            sldProfiles{i} = SLDs{i};
    end
end

problem.calculations.reflectivity = reflectivity;
problem.calculations.Simulation = Simulation;
problem.calculations.slds = sldProfiles;
problem.calculations.layers = allLayers;

% Now calculate the chi-squareds
% First we need to apply the scalefactors to the data
problem = shiftdata(problem);

for i = 1:numberOfContrasts
    thisData = problem.shifted_data{i};
    thisFit = problem.calculations.reflectivity{i};
    thisChi = rascal_chi_squared(thisFit(:,2),thisData(:,2),length(problem.fitpars),thisData(:,3),[]);
    problem.calculations.all_chis(i) = thisChi;
end

problem.calculations.sum_chi = sum(problem.calculations.all_chis);

setappdata(0,'problem',problem);
end

           
 



           
           
