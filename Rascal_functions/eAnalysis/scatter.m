load('processed_BS_750_runs_bootStrapResults.mat','bs')

bsResults = a.bsResults;

pars = [16 13];
v1 = bsResults.pars(:,pars(1));
v2 = bsResults.pars(:,pars(2));

figure(3); hold on
plot(v1,v2,'k.')
