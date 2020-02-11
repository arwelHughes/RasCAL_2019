function [allData, allSims] = applyQ4(problem)

warning('off','MATLAB:Axes:NegativeDataInLogAxis');

debugPlot = 0;

allData = problem.shifted_data;
allSims = problem.calculations.Simulation;
numberOfContrasts = problem.numberOfContrasts;

switch debugPlot
    case 1
        figure(1);
        clf
        subplot(2,1,1)
        for i = 1:numberOfContrasts
            errorbar(allData{i}(:,1),allData{i}(:,2),allData{i}(:,3),'.');
            hold on;
            plot(allSims{i}(:,1),allSims{i}(:,2));
        end
        set(gca,'YScale','log','XScale','log');   
end

for i = 1:numberOfContrasts
    thisData = allData{i};
    thisBackground = problem.backgrounds(i);
    q4 = thisData(:,1).^4;
    thisData(:,2) = thisData(:,2)-thisBackground;
    thisData(:,3) = thisData(:,3)-thisBackground;
    thisData(:,2) = thisData(:,2) .* q4;
    thisData(:,3) = thisData(:,3) .* q4;
    allData{i} = thisData;
    
    thisSim = allSims{i};
    q4 = thisSim(:,1).^4;
    thisSim(:,2) = thisSim(:,2);%-thisBackground;
    thisSim(:,2) = thisSim(:,2) .* q4;
    allSims{i} = thisSim;
end

switch debugPlot
    case 1
        subplot(2,1,2)
        for i = 1:numberOfContrasts
            errorbar(allData{i}(:,1),allData{i}(:,2),allData{i}(:,3),'.');
            hold on;
            plot(allSims{i}(:,1),allSims{i}(:,2));
        end
        set(gca,'YScale','log','XScale','log');
end

end