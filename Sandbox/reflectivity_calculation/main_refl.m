clear

a = load('Monolayer_8_contrasts.mat');
problem = a.problem;

outSlds = load('outSlds.mat');
slds = outSlds.slds;

numberOfContrasts = problem.numberOfContrasts;

calcRef = problem.calculations.reflectivity;
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
simLimits = problem.simLimits;
resolutions = problem.resolutions;
allData = problem.shifted_data;
ssubs = ones(numberOfContrasts,1).*6.99;
repeats = ones(numberOfContrasts,1);

for i = 1:numberOfContrasts
    thisData = allData{i};
    thisX = thisData(:,1);
    allXData{i} = thisX;
end

tic
for i = 1:100
    outRefl = abeles_loop_OMP(allXData(:),slds(:),nbairs(:),nbsubs(:),repeats(:), resolutions(:), ssubs(:));
end
toc

figure(1); clf; hold on
for i = 1:numberOfContrasts
    semilogy(allXData{i},outRefl{i},'-');
end
set(gca,'YScale','log');

