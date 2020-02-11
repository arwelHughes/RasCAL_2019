clear

inp = load('inputs.mat');
inp = inp.inp;

simXData = inp.simXData;
sldLayers = inp.sldLayers;
nbairs = inp.nbairs;
nbsubs = inp.nbsubs;
repeats = inp.repeats;
resolutions = inp.resolutions;
allRoughs = inp.allRoughs;


Ref = abeles_loop_3(simXData(:),sldLayers(:),nbairs(:),...
        nbsubs(:),repeats(:),resolutions(:),allRoughs(:));
