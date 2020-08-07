function problem = callReflectivityCalculation(problem)

global sldProfile

% Function handle for adaptive resampling
f = @(x) sldFunc(x);

number_of_contrasts = problem.numberOfContrasts;

if isfield(problem,'calcSLD')
   calcSLD = problem.calcSLD;
else
    calcSLD = 1;
end

resample = problem.resample;

%Divide everything up before entering the calculation...
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
params = problem.params;
geometry = problem.module.experiment_type;
simLimits = problem.simLimits;
resolutions = problem.resolutions;
allData = problem.shifted_data;
switch problem.module.type
    case {'Standard Layers',1}
        name = 'standard_box_new';
        type = 1;
    case {'Custom Layers',2}
        extens = strfind(problem.module.name,'.m');
        if ~isempty(extens)
            name = problem.module.name(1:extens-1);
        else
            name = problem.module.name;
        end
        type = 2;
end

sldProfiles = cell(1,number_of_contrasts);
for i = 1:number_of_contrasts
    if (type == 2 || type == 3)
        eval(['[out,s_sub] = ' name '(params,nbairs,nbsubs,i);']);
    else
        [out,s_sub] = standard_box_new(problem,i);
    end
    
    outputs{i} = out;
    ssubs(i) = s_sub;
    output = outputs{i};
    
    sub_rough = params(1);
    [layers, ssubs(i)] = groupLayers_Mod(output,sub_rough,geometry,nbairs(i),nbsubs(i));
    
    this_data = allData{i};
    xdata = this_data(:,1);

    if isempty(output)
        slds{i} = [0 problem.nbairs(i) 0];
        lays(i) = 0;
    else
        slds{i} = layers(:,1:3);
        lays(i) = size(slds{i},1);
    end
    
    simXLo = simLimits{i}(1);
    simXHi = simLimits{i}(2);
    
    middleSection = this_data(:,1);
    
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
    
    simXdata{i}= [firstSection(:) ; middleSection ; lastSection(:)];
    trueXdata{i} = middleSection(:);
    simXdata_splits{i} = [length(firstSection) length(middleSection(:,1)) length(lastSection)];
    repeats(i) = problem.repeatLayers{i}(2);
    
    if calcSLD || resample(i)
        sldProfiles{i} = makeSLDProfileXY(nbairs(i),nbsubs(i),ssubs(i),slds{i},lays(i),repeats(i));
        
        if resample(i)
            sldProfile = sldProfiles{i};
            x = sldProfile(:,1);
            prof = sldProfile(:,2);
            
            xstart = x(1);
            xend = x(end);
            newX = linspace(xstart,xend,100);
            yy = adaptive(f, [xstart xend], 'minAngle',0.7*pi, 'nPoints', 50);
            
            newX = yy(:,1);
            newY = yy(:,2);
            layers = zeros(length(newX)-1,3);
            
            % Now build a layer model from these resampled points
            for n = 1:length(newX)-1
                thisX = newX(n);
                nextX = newX(n+1);
                thisY = newY(n);
                nextY = newY(n+1);
                
                thisLayThick = nextX - thisX;
                if nextY > thisY
                    thisLayRho = ((nextY - thisY)/2) + thisY;
                else
                    thisLayRho = ((thisY - nextY)/2) + nextY;
                end
                
                layers(n,:) = [thisLayThick thisLayRho eps];
            end
            slds{i} = layers;
        end
    else
        sldProfiles{i} = [0 0];
    end
end
    
simRef = abeles_loop_new(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));

for i = 1:number_of_contrasts
    splits = simXdata_splits{i};
    firstSection = splits(1);
    middleSection = splits(2);
    Ref = simRef{i};
    Ref = Ref((firstSection+1):(firstSection+middleSection));
    reflectivity{i} = [trueXdata{i} Ref(:)];
    Simulation{i} = [simXdata{i} simRef{i}];
    fresnel{i} = [];
end

 problem.calculations.reflectivity = reflectivity;
 problem.calculations.Simulation = Simulation;
 problem.calculations.slds = sldProfiles;
 problem.calculations.simFresnel = fresnel;
 problem.calculations.ssubs = ssubs;
 
end