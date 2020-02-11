function makeSLDIntervalPlots(ref,intervals,hRefFigure, which)

% Clear the figure ready for plotting.
figure(hRefFigure)
subplot(1,2,2);
cla;
hold on

% Load in problem
problem = getappdata(0,'problem');

% Make sure the best fit is up to date.
fitVals = intervals.values_95;
bestFit = fitVals(:,1);
problem.fitpars = bestFit;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');

% Loop over the datasets, plotting the best-fits SLD's and
% patches.
numberOfContrasts = problem.numberOfContrasts;
shading = intervals.sldShading_95;
for i = 1:numberOfContrasts
    
    % Get the intervals for the current contrast 
    thisInterval = shading{i};
    thisX = thisInterval(:,1);
    thisY = thisInterval(:,2);
    thisMin = thisInterval(:,3);
    thisMax = thisInterval(:,4);
    
    %Now make the shaded plot
    allPoints = [length(thisX) length(thisY) length(thisMin) length(thisMax)];
    points = min(allPoints);
    makePatch(thisX(1:points),thisY(1:points),thisMin(1:points),thisMax(1:points),i);    
end

end


% -------------------------------------------------------------------------

function h = makePatch(x,y,minCurve,maxCurve,which)

% Determine the plot colour
colours = get(gca,'ColorOrder');
if which > size(colours,1)
    which = 1;
end
col = colours(which,:);

yp = [minCurve',fliplr(maxCurve')];
xp = [x',fliplr(x')];

patchSaturation = 0.25;
edgeSaturation = 0.55;

set(gcf,'renderer','OpenGl')

h = plot(x,y,'k-');
set(h,'LineWidth',2)

patch(xp,yp,1,'FaceColor',col,'EdgeColor',col,'FaceAlpha',patchSaturation,'EdgeAlpha',edgeSaturation);

set(gca,'Box','on');

end
