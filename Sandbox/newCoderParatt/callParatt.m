function simRef = callParatt(simXdata,slds,nbairs,nbsubs,repeats,resolutions,ssubs)

numberOfContrasts = length(simXdata);
Ref = cell(numberOfContrasts,1);

for i = 1:numberOfContrasts
    layers = size(slds{i},1);
    points = length(simXdata{i});
    thisRef = paratt(simXdata{i},slds{i},nbairs(i),nbsubs(i),repeats(i),ssubs(i),layers,points);
    Ref{i} = resolution_polly(simXdata{i},thisRef,resolutions(i),points);
end
    
simRef = Ref;

end