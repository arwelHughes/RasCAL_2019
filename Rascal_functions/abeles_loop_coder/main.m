
abelesInputs = load('abelesLoopInputs.mat');
abelesInputs = abelesInputs.abelesLoopInputs;

simXdata = abelesInputs{1};
slds = abelesInputs{2};
nbairs = abelesInputs{3};
nbsubs = abelesInputs{4};
repeats = abelesInputs{5};
resolutions = abelesInputs{6};
ssubs = abelesInputs{7};

simRef = abeles_loop_new(simXdata,slds,nbairs,nbsubs,repeats,resolutions,ssubs);

