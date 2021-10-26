abelesInputs.simXdata = simXdata;
abelesInputs.slds = slds;
abelesInputs.nbairs = nbairs;
abelesInputs.nbsubs = nbsubs;
abelesInputs.repeats = repeats;
abelesInputs.resolutions = resolutions;
abelesInputs.ssubs = ssubs;

simRef = abeles_loop_new(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));


