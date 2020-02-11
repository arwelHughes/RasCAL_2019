function UpdateResidChart()


problem = getappdata(0,'problem');
resids = problem.calculations.resids;
numberOfContrasts = problem.numberOfContrasts;
dataPresent = problem.dataPresent;
figure(1)
clf
hold on
colours = ['r' 'g' 'm' 'b' 'g' 'r' 'g' 'm' 'b' 'g'];
for i = 1:numberOfContrasts
    if dataPresent(i)
        thisResid = resids{i};
        plot(thisResid(:,1),thisResid(:,2)-(i*100), [colours(i) '-']);
        thisMask = problem.calculations.roiMasks{i};
        
        roi = find(thisMask ~= 1);
        plot(thisResid(roi,1),thisResid(roi,2)-(i*100), 'r.');        
    end
end
set(gca,'XScale','log');
hold off
drawnow;




