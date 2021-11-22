function problem = xy_profile_calc(problem)

global sldProfile

% Function handle for adaptive resampling
f = @(x) sldFunc(x);

% Get all the parameters out
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
params = problem.params;
geometry = problem.module.experiment_type;
simLimits = problem.simLimits;
resolutions = problem.resolutions;
allData = problem.shifted_data;

% Loop over each contrast
number_of_contrasts = problem.numberOfContrasts;
for loop = 1:number_of_contrasts
%     problem.which_contrast = loop;
%     params = problem.params;
    bulk_in = problem.nbairs;
    bulk_out= problem.nbsubs;
    name = problem.module.name;
    point = findstr(name,'.');
    if ~isempty(point)
        name = name(1:point-1);
    end
    a = ['[output] = ' name '(params,bulk_in,bulk_out,loop);'];
    eval(a);
    
    if (size(output,2) ~= 2)
        addInfoText('For this type of problem, module output needs to be SLD profile as two columns of z-values(in �) and SLD');
        return
    end
    problem.calculations.slds{loop} = output;

    % Now need to change the SLD profile into layers.
    % We use adaptive resampling to ensure that there
    % are more layers where the gradient is changing quickly and
    % vice versa.
    % First save the SLD profile so that sldFunc can access it...
    %setappdata(0,'sldFuncSLD',output);
    sldProfile = output;
    x = output(:,1);
    prof = output(:,2);
    
    xstart = x(1);
    xend = x(end);
    newX = linspace(xstart,xend,100);
    nResamPoints = problem.resampleNLayers;
    angle = problem.resampleAngle;
    yy = adaptive(f, [xstart xend], 'minAngle',angle*pi, 'nPoints', nResamPoints);
    
    newX = yy(:,1);
    newY = yy(:,2);
    layers = zeros(length(newX)-1,3);
    
    % Now build a layer model from these resampled points
    for i = 1:length(newX)-1
        thisX = newX(i);
        nextX = newX(i+1);
        thisY = newY(i);
        nextY = newY(i+1);
        
        thisLayThick = nextX - thisX;
        if nextY > thisY
            thisLayRho = ((nextY - thisY)/2) + thisY;
        else
            thisLayRho = ((thisY - nextY)/2) + nextY;
        end
        
        layers(i,:) = [thisLayThick thisLayRho eps];
    end
   
    nbsub = problem.nbsubs(loop);
    nbair = problem.nbairs(loop);
    
    this_data = problem.shifted_data{loop};
    xdata = this_data(:,1);

%     thicks = layers(:,1);
%     slds = layers(:,2);

    %resol = problem.resolution;
    %resolType = problem.resolType;
    %abeles(xdata,SLDs,nbair,nbsub,ssub,nrepeats,sinter,resol)
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,repeats,
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,0,1,resolType,resol);
    %
    simXLo = simLimits{loop}(1);
    simXHi = simLimits{loop}(2);
    
    middleSection = this_data(:,1);
    
    if simXLo < xdata(1)
        step = (xdata(2)-xdata(1));
        firstSection = [simXLo:step:(xdata(1)-step)];
        firstSection = firstSection(:);
    else
        firstSection = [];
    end
    
    if simXHi > xdata(end)
        step = (xdata(end)-xdata(end-1,1));
        lastSection = [xdata(end,1)+step:step:simXHi];
        lastSection = lastSection(:);
    else
        lastSection = [];
    end
    
    simXdata{loop}= [firstSection(:) ; middleSection(:); lastSection(:)];
    trueXdata{loop} = middleSection(:);
    simXdata_splits{loop} = [length(firstSection) length(middleSection(:,1)) length(lastSection)];
    if isfield(problem,'repeatLayers')
        repeats(loop) = problem.repeatLayers{loop}(2);
    else
        repeats(loop) = 1;
    end
    problem.calculations.sldLayers{loop} = layers;
end

% Now call the reflectivity calculation for all the contrasts
sldLayers = problem.calculations.sldLayers;
allRoughs = zeros(number_of_contrasts,1);
simRef = abeles_loop_new(simXdata(:),sldLayers(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), allRoughs(:));

% Chop up the reflectivity back into it's splits
for i = 1:number_of_contrasts
    splits = simXdata_splits{i};
    firstSection = splits(1);
    middleSection = splits(2);
    Ref = simRef{i};
    Ref = Ref((firstSection+1):(firstSection+middleSection));
    reflectivity{i} = [trueXdata{i} Ref(:)];
    Simulation{i} = [simXdata{i}(:) simRef{i}(:)];

    % Also need an SLD profile from the resampled layers
    layers = problem.calculations.sldLayers{i};
    %xyProfile = makeSLDProfileXY(layers(1,2),layers(end,2),eps,layers,size(layers,1),1);
    %problem.calculation.resampledSldProfiles{i} = xyProfile;
end

 problem.calculations.reflectivity = reflectivity;
 problem.calculations.Simulation = Simulation;
 problem.calculations.ssubs = allRoughs;

end
        