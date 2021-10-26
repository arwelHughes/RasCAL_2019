function simRef = abeles_loop_new(simXdata,slds,nbairs,nbsubs,repeats,resolutions,ssubs)

numberOfContrasts = length(simXdata);
simRef = cell(numberOfContrasts,1);

for i = 1:numberOfContrasts
    thisX = simXdata{i};
    thisSld = slds{i};
    thisNbair = nbairs(i);
    thisNbsub = nbsubs(i);
    thisRepeats = repeats(i);
    thisResolution = resolutions(i);
    thisSsubs = ssubs(i);
    
    points = length(thisX);
    layers = size(thisSld,1);
    
    ref = abeles(thisX,thisSld,thisNbair,thisNbsub,thisRepeats,thisSsubs,layers,points);
    ref = resolution_polly(thisX,ref,thisResolution,points);
    
    simRef{i} = ref(:);
end


end
