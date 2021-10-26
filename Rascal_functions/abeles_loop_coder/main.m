
abelesInputs = load('abelesInputs.mat');
abelesInputs = abelesInputs.abelesInputs;

simXdata = abelesInputs.simXdata;
slds = abelesInputs.slds;
nbairs = abelesInputs.nbairs;
nbsubs = abelesInputs.nbsubs;
repeats = abelesInputs.repeats;
resolutions = abelesInputs.resolutions;
ssubs = abelesInputs.ssubs;

simRef = abeles_loop_new(simXdata,slds,nbairs,nbsubs,repeats,resolutions,ssubs);

