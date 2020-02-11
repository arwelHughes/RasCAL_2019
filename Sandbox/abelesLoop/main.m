clear

inp = load('indat.mat');
inp = inp.indat;

simXdata = inp.simXdata;
slds = inp.slds;
nbairs = inp.nbairs;
nbsubs = inp.nbsubs;
repeats = inp.repeats;
resolutions = inp.resolutions;
ssubs = inp.ssubs;

simRef = abeles_loop_2(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));
