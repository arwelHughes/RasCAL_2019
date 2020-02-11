clear

inp = load('inputs.mat');
inp = inp.inp;

simXData_all = inp.simXData;
sldLayers_all = inp.sldLayers;
nbairs_all = inp.nbairs;
nbsubs_all = inp.nbsubs;
repeats_all = inp.repeats;
resolutions_all = inp.resolutions;
allRoughs_all = inp.allRoughs;


% for n = 1:12
% simXData = simXData_all(1:n);
% sldLayers = sldLayers_all(1:n);
% nbairs = nbairs_all(1:n);
% nbsubs = nbsubs_all(1:n);
% repeats = repeats_all(1:n);
% resolutions = resolutions_all(1:n);
% allRoughs = allRoughs_all(1:n);

%tic
%for i = 1:1000
    Ref = abeles_loop_new(simXData_all(:),sldLayers_all(:),nbairs_all(:),...
        nbsubs_all(:),repeats_all(:),resolutions_all(:),allRoughs_all(:));
%end

% tim(n,:) = [n toc];
% 
% end
% 
% figure(1); clf
% plot(tim(:,1),tim(:,2),'ro');
