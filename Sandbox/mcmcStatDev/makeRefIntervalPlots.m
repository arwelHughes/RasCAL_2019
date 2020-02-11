function makeRefIntervalPlots(ref,intervals,hRefFigure)

% Clear the figure ready for plotting.
figure(hRefFigure)
clf;
subplot(1,2,1);
set(gca,'YScale','log','XScale','log');
hold on

% Colour for the predint patches
col = [0.6 0.6 0.6];

% Load in problem
problem = getappdata(0,'problem');

% Get the data. To do this calculate using the 
% best fit parameters, as we need any shifts to be in the plot.
fitVals = intervals.values_95;
bestFit = fitVals(:,1);
problem.fitpars = bestFit;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');
allData = problem.shifted_data;

% Loop over the datasets, plotting the best-fits, data and
% patches.
numberOfContrasts = problem.numberOfContrasts;
shading = intervals.refShading_95;
for i = 1:numberOfContrasts
    
    % Get the intervals for the current contrast 
    thisInterval = shading{i};
    thisX = thisInterval(:,1);
    thisY = thisInterval(:,2);
    thisMin = thisInterval(:,3);
    thisMax = thisInterval(:,4);
    thisData = allData{i};
    
    % Curves are shifted along the Y axis for clarity
    if (i-1) > 0
        if i == 2
            mult = 1000;
        else
            mult = 10^(2*i);
        end
        thisMin = thisMin ./ mult;
        thisMax = thisMax ./ mult;
        thisY = thisY./mult;
        thisData(:,2) = thisData(:,2) ./ mult;
        thisData(:,3) = thisData(:,3) ./ mult;
    end
    
    %Now make the shaded plot
    allPoints = [length(thisX) length(thisY) length(thisMin) length(thisMax)];
    points = min(allPoints);
    makePatch(thisX(1:points),thisY(1:points),thisMin(1:points),thisMax(1:points),col);
    
    % Add the data
    %thisData = allData{i};
    errorbar(thisData(:,1),thisData(:,2),thisData(:,3),'.');
    
end

end


% -------------------------------------------------------------------------

function h = makePatch(x,y,minCurve,maxCurve,col)


%if any lb regions are negative, set them to same
%as previous point
sumOver = 1;
while any(find(minCurve<0))
    negs = find(minCurve<0);
    for n = 1:length(negs)
        if (negs(n) < (length(minCurve)+sumOver))
                minCurve(negs(n)) = (minCurve(negs(n)-sumOver) + minCurve(negs(n)+sumOver))/2;
        elseif (negs(n) == length(minCurve))
            minCurve(negs(n)) = minCurve(negs(n)-sumOver);
        end
    end
    sumOver = sumOver + 1;
end

yp = [minCurve',fliplr(maxCurve')];
xp = [x',fliplr(x')];

patchSaturation = 0.55;
patchColor = col+(1-col)*(1-patchSaturation);

edgeSaturation = 0.95;
edgeColor = col+(1-col)*(1-edgeSaturation);

set(gcf,'renderer','OpenGl')

patch(xp,yp,1,'facecolor',patchColor,'edgecolor',edgeColor);

h = plot(x,y,'k-');
set(h,'LineWidth',1.5)

set(gca,'Box','on');

end
