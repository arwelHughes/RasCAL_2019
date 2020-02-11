%Test of new Matlab Coder reflectivity calculation.
clear 
% Load in example data...

inputDat = load('inputDat.mat');
dat = inputDat.dat;

simXdata = dat.simXdata;
slds = dat.slds;
nbairs = dat.nbairs;
nbsubs = dat.nbsubs;
repeats = dat.repeats;
resolutions = dat.resolutions;
ssubs = dat.ssubs;




%Now the new way
simRef2 = callParatt(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));

% figure(1); clf; set(gca,'YScale','log'); hold on
% for i = 1:length(simXdata)
%     plot(simXdata{i},simRef{i},'r-');
%     plot(simXdata{i},simRef2{i},'b-')
% end
% 
% set(gca,'YScale','log');

disp('debug');
