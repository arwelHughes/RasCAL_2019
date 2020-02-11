clear

simXdata = linspace(0.01,0.7,200);
slds = [eps eps eps];
nbairs = 2.073e-6;
nbsubs = 6.35e-6;
repeats = 1;
resolutions = 0.03;
ssubs = 3;

layers = 1;
points = length(simXdata);


thisRef = paratt(simXdata,slds,nbairs,nbsubs,repeats,ssubs,layers,points);

figure(1); clf
semilogy(simXdata,thisRef);
