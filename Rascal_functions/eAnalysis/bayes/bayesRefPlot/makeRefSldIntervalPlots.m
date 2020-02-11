function makeRefSldIntervalPlots(intervals,reflectivityFig,problem,best,predInt)

thisHandle = reflectivityFig;
figure(thisHandle);
% refIntervals = intervals.outRef;
% sldIntervals = intervals.outSld;

% Clear the figure ready for plotting.
refAxis = findobj(thisHandle,'Tag','refAxis'); 
cla(refAxis);
hold(refAxis,'on');

sldAxis = findobj(thisHandle,'Tag','sldAxis'); 
cla(sldAxis);
hold(sldAxis,'on');

% Start woth the reflectivity plot.
% Get the data
allData = problem.shifted_data;

% Loop over the datasets, plotting the best-fits, data and
% patches.
numberOfContrasts = problem.numberOfContrasts;
for i = 1:numberOfContrasts
    switch predInt
        case 95
            allShadingRef = intervals.refShading_95;
            allShadingSld = intervals.sldShading_95;
            %theseLimsRef = refIntervals.predlims{i};
            %theseLimsSld = sldIntervals.predlims{i};
            
            %thisMin = theseLimsRef{:}(1,:);
            %thisMax = theseLimsRef{:}(7,:);
            thisMin = allShadingRef{i}(:,3);
            thisMax = allShadingRef{i}(:,4);
            
            thisScalefactor = problem.scalefactors(i);
            
            shadingRef{i} = [thisMin(:) thisMax(:)];%./thisScalefactor;
            
            %thisMin = theseLimsSld{:}(1,:);
            %thisMax = theseLimsSld{:}(7,:);
            thisMin = allShadingSld{i}(:,3);
            thisMax = allShadingSld{i}(:,4);
            
            shadingSld{i} = [thisMin(:) thisMax(:)];
            
        case 65
             allShadingRef = intervals.refShading_65;
             allShadingSld = intervals.sldShading_65;
            %theseLimsRef = refIntervals.predlims{i};
            %theseLimsSld = sldIntervals.predlims{i};
            
           %thisMin = theseLimsRef{:}(1,:);
            %thisMax = theseLimsRef{:}(7,:);
            thisMin = allShadingRef{i}(:,3);
            thisMax = allShadingRef{i}(:,4);
            
            thisScalefactor = problem.scalefactors(i);
            
            shadingRef{i} = [thisMin(:) thisMax(:)];%./thisScalefactor;
            
            %thisMin = theseLimsSld{:}(1,:);
            %thisMax = theseLimsSld{:}(7,:);
            thisMin = allShadingSld{i}(:,3);
            thisMax = allShadingSld{i}(:,4);
            
            shadingSld{i} = [thisMin(:) thisMax(:)];
        case 25
            allShadingRef = intervals.refShading_25;
            allShadingSld = intervals.sldShading_25;
            %theseLimsRef = refIntervals.predlims{i};
            %theseLimsSld = sldIntervals.predlims{i};
            
            %thisMin = theseLimsRef{:}(1,:);
            %thisMax = theseLimsRef{:}(7,:);
            thisMin = allShadingRef{i}(:,3);
            thisMax = allShadingRef{i}(:,4);
            
            thisScalefactor = problem.scalefactors(i);
            
            shadingRef{i} = [thisMin(:) thisMax(:)];%./thisScalefactor;
            
            %thisMin = theseLimsSld{:}(1,:);
            %thisMax = theseLimsSld{:}(7,:);
            thisMin = allShadingSld{i}(:,3);
            thisMax = allShadingSld{i}(:,4);
            
            shadingSld{i} = [thisMin(:) thisMax(:)];
        otherwise
            shadingRef = intervals.refShading_95;
            shadingSld = intervals.sldShading_95;
    end
end


saturation = 0.2;
for i = 1:numberOfContrasts
    
    % Get the intervals for the current contrast 
    thisInterval = shadingRef{i};
    thisBest = best.bestFits{i};
    thisX = thisBest(:,1);
    thisY = thisBest(:,2);
    thisMin = thisInterval(:,1);
    thisMax = thisInterval(:,2);
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
    
    % Now make the shaded plot
    % A quick hack to get the next defaultPlotColor
    % is to make an (invisible) plot and get its color property.
    % This Color is then used to set the patch colour.
    h = plot(nan,nan);
    col = get(h,'Color');
    
    allPoints = [length(thisX) length(thisY) length(thisMin) length(thisMax)];
    points = min(allPoints);
    makePatch(thisX(1:points),thisY(1:points),thisMin(1:points),thisMax(1:points),...
        col,saturation,refAxis);
    
    % Add the data
    %thisData = allData{i};
    errorbar(thisData(:,1),thisData(:,2),thisData(:,3),'.','Parent',refAxis);
end

% Now do the same for the SLD plots.
saturation = 0.2;
for i = 1:numberOfContrasts
    
    % Get the intervals for the current contrast 
    thisInterval = shadingSld{i};
    bestSld = best.bestSlds{i};
    thisX = bestSld(:,1);
    thisY = bestSld(:,2);
    thisMin = thisInterval(:,1);
    thisMax = thisInterval(:,2);
    
    h = plot(nan,nan);
    col = get(h,'Color');

    %Now make the shaded plot
    allPoints = [length(thisX) length(thisY) length(thisMin) length(thisMax)];
    points = min(allPoints);
    makePatchNeg(thisX(1:points),thisY(1:points),thisMin(1:points),thisMax(1:points),...
        col,saturation,sldAxis);    
end


end


% -------------------------------------------------------------------------

function h = makePatch(x,y,minCurve,maxCurve,col,saturation,thisAxis)


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

patchSaturation = saturation;
patchColor = col+(1-col)*(1-patchSaturation);

edgeSaturation = 0.95;
edgeColor = col+(1-col)*(1-edgeSaturation);

set(gcf,'renderer','OpenGl')

patch(xp,yp,1,'facecolor',patchColor,'edgecolor',edgeColor,'Parent',thisAxis);

h = plot(x,y,'k-','Parent',thisAxis);
set(h,'LineWidth',1.5)

set(gca,'Box','on');

end



% -----------------------------------------------------------------------

function h = makePatchNeg(x,y,minCurve,maxCurve,col,saturation,thisAxis)


%if any lb regions are negative, set them to same
%as previous point
% sumOver = 1;
% while any(find(minCurve<0))
%     negs = find(minCurve<0);
%     for n = 1:length(negs)
%         if (negs(n) < (length(minCurve)+sumOver))
%                 minCurve(negs(n)) = (minCurve(negs(n)-sumOver) + minCurve(negs(n)+sumOver))/2;
%         elseif (negs(n) == length(minCurve))
%             minCurve(negs(n)) = minCurve(negs(n)-sumOver);
%         end
%     end
%     sumOver = sumOver + 1;
% end

yp = [minCurve',fliplr(maxCurve')];
xp = [x',fliplr(x')];

patchSaturation = saturation;
patchColor = col+(1-col)*(1-patchSaturation);

edgeSaturation = 0.95;
edgeColor = col+(1-col)*(1-edgeSaturation);

set(gcf,'renderer','OpenGl')

patch(xp,yp,1,'facecolor',patchColor,'edgecolor',edgeColor,'faceAlpha',0.5,'Parent',thisAxis);

h = plot(x,y,'k-','Parent',thisAxis);
set(h,'LineWidth',2)

set(gca,'Box','on');

end

