function ret = makeRefAndSldWindow(output,bayesHandles);

%Reflectivity window.....
thisHandle = figure(bayesHandles);
numberOfContrasts = length(output.data);


if ~isempty(output.refBounds)
    subplot(1,2,1); cla; set(gca,'YScale','log'); hold on
    for i=1:numberOfContrasts;
        thisData = output.data{i};
        thisFit = output.bestRefs{i};
        thisMinCurve = output.refBounds{1}{i};
        thisMaxCurve = output.refBounds{2}{i};
        col = [0.3 0.3 0.3];
        nbair = 6.35e-6;
        nbSub = 2.073e-6;
        %offset = i*10000;
        shiftValue = 150;
        offset = 10.^((i/100)*shiftValue);
        addRefPlot(thisData,thisFit,thisMinCurve,thisMaxCurve,col,offset,nbair,nbSub);
    end
    
    %SLD window.......
    subplot(1,2,2); hold on
    for i = 1:numberOfContrasts;
        thisSLD = output.bestSlds{i};
        v = rand();col = [rand rand rand];
        minCurve = output.sldBounds{1}{i};
        maxCurve = output.sldBounds{2}{i};
        addSLDPlot(thisSLD,minCurve,maxCurve,col);
    end
else
    subplot(1,2,1); set(gca,'YScale','log'); hold on
    for i = 1:numberOfContrasts
        thisData = output.data{i};
        thisFit = output.bestRefs{i};
        shiftValue = 150;
        offset = 10.^((i/100)*shiftValue);
        addNoShadingRefPlot(thisData,thisFit,offset);
    end
        subplot(1,2,2); hold on
    for i = 1:numberOfContrasts;
        thisSLD = output.bestSlds{i};
        col = [rand rand rand];
        addNoShadingSLDPlot(thisSLD);
    end
    
end

ret = 'ok';



end

%--------------------------------------------------------------------------


function addRefPlot(thisData,thisFit,minCurve,maxCurve,col,offset,nbair,nbsub);
%Find the relevant struntural parameters....
slds = [0 0 0];
repeats = 1;
resolType = 2;
resol = 0.06;

%Make the fresnel
% xdata = thisData(:,1);
% fresnel = abeles_new_2(xdata(:),slds,nbair,nbsub,0,1,resolType,resol);
% 
% thisData(:,2) = (thisData(:,2) ./ fresnel) + offset;
% thisData(:,3) = (thisData(:,3) ./ fresnel);
% thisFit(:,2) = (thisFit(:,2) ./ fresnel) + offset;
% 
% minCurve = (minCurve ./ fresnel) + offset;
% maxCurve = (maxCurve ./ fresnel) + offset;

xdata = thisData(:,1);
thisData(:,2) = thisData(:,2) ./  offset;
thisData(:,3) = thisData(:,3) ./ offset;
thisFit(:,2) = thisFit(:,2) ./offset;

minCurve = minCurve ./ offset;
maxCurve = maxCurve ./ offset;


%Plot
patchSaturation = 0.35;
patchColor = col+(1-col)*(1-patchSaturation);
edgeSaturation = 0.55;
edgeColor = col+(1-col)*(1-edgeSaturation);

yp = [minCurve',fliplr(maxCurve')];
xp = [xdata',fliplr(xdata')];
patch(xp,yp,1,'facecolor',patchColor,'edgecolor',edgeColor);
hData = errorbar(xdata,thisData(:,2),thisData(:,3),'k.');
%errorbarlogx(0.003);
hFit = plot(thisFit(:,1),thisFit(:,2),'k-');
set(hFit,'LineWidth',1.1)
%set(hData,'LineWidth',1)
set(hData,'MarkerSize',5)

end



%--------------------------------------------------------------------------

function addSLDPlot(thisFit,minCurve,maxCurve,col);

%Plot
patchSaturation = 0.45;
patchColor = col+(1-col)*(1-patchSaturation);
edgeSaturation = 0.65;
edgeColor = col+(1-col)*(1-edgeSaturation);

xdata = thisFit(:,1);
if length(xdata) < length(minCurve);
    minCurve = minCurve(1:length(xdata));
    maxCurve = maxCurve(1:length(xdata));
else
    xdata = xdata(1:length(minCurve));
end

yp = [minCurve',fliplr(maxCurve')];
xp = [xdata',fliplr(xdata')];
hp = patch(xp,yp,1,'facecolor',patchColor,'edgecolor',edgeColor,'LineSmoothing','on');
hFit = plot(thisFit(:,1),thisFit(:,2),'k-','LineSmoothing','on');
drawnow;
set(hp,'FaceAlpha',0.3);
hp.Face.ColorType = 'truecoloralpha';
hp.Face.ColorData(4) = 255 * patchSaturation;
set(hFit,'LineWidth',1.1)
%set(hData,'LineWidth',1)
% set(hp,'FaceAlpha',patchSaturation);
% set(hp,'EdgeAlpha',edgeSaturation);

end

%--------------------------------------------------------------------------


function addNoShadingRefPlot(thisData,thisFit,offset);
%Find the relevant struntural parameters....
slds = [0 0 0];
repeats = 1;
resolType = 2;
resol = 0.06;

%Make the fresnel
% xdata = thisData(:,1);
% fresnel = abeles_new_2(xdata(:),slds,nbair,nbsub,0,1,resolType,resol);
% 
% thisData(:,2) = (thisData(:,2) ./ fresnel) + offset;
% thisData(:,3) = (thisData(:,3) ./ fresnel);
% thisFit(:,2) = (thisFit(:,2) ./ fresnel) + offset;
% 
% minCurve = (minCurve ./ fresnel) + offset;
% maxCurve = (maxCurve ./ fresnel) + offset;

xdata = thisData(:,1);
thisData(:,2) = thisData(:,2) ./  offset;
thisData(:,3) = thisData(:,3) ./ offset;
thisFit(:,2) = thisFit(:,2) ./offset;

%Plot

hData = errorbar(xdata,thisData(:,2),thisData(:,3),'k.');
%errorbarlogx(0.003);
hFit = plot(thisFit(:,1),thisFit(:,2),'k-');
set(hFit,'LineWidth',1.1)
set(hData,'MarkerSize',5)

end


%--------------------------------------------------------------------------

function addNoShadingSLDPlot(thisFit);

%Plot

xdata = thisFit(:,1);

hFit = plot(thisFit(:,1),thisFit(:,2),'k-','LineSmoothing','on');
drawnow;

set(hFit,'LineWidth',1.1)
%set(hData,'LineWidth',1)
% set(hp,'FaceAlpha',patchSaturation);
% set(hp,'EdgeAlpha',edgeSaturation);

end

%--------------------------------------------------------------------------
