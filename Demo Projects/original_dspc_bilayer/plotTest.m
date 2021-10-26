problem = getappdata(0,'problem');
%problem = reflectivity_calculation(problem);

data = problem.shifted_data;
sims = problem.calculations.Simulation;

figure(1); clf; hold on
for n = 1:2
   thisDat = data{n};
   errorbar(thisDat(:,1),thisDat(:,2),thisDat(:,3),'.');
   thisSim = sims{n};
   plot(thisSim(:,1),thisSim(:,2));
end

set(gca,'YScale','log','XScale','log');

