function makeRefAndSldWindow(output,reflectivityFig)

thisHandle = reflectivityFig;
set(thisHandle,'Resize','on');

refAxis = findobj(thisHandle,'Tag','refAxis'); 
cla(refAxis);
hold(refAxis,'on');

sldAxis = findobj(thisHandle,'Tag','sldAxis'); 
cla(sldAxis);
hold(sldAxis,'on');

numberOfContrasts = length(output.data);

for i = 1:numberOfContrasts
    thisData = output.data{i};
    thisFit = output.bestRefs{i};
    shiftValue = 150;
    offset = 10.^((i/100)*shiftValue);
    addRefPlot(thisData,thisFit,offset,refAxis);
end

for i = 1:numberOfContrasts
    thisSLD = output.bestSlds{i};
    addSLDPlot(thisSLD,sldAxis);
end
   
end

%--------------------------------------------------------------------------

function addRefPlot(thisData,thisFit,offset,refAxis)

xdata = thisData(:,1);
thisData(:,2) = thisData(:,2) ./  offset;
thisData(:,3) = thisData(:,3) ./ offset;
thisFit(:,2) = thisFit(:,2) ./offset;

hData = errorbar(xdata,thisData(:,2),thisData(:,3),'k.','Parent',refAxis);
hold(refAxis,'on');
hFit = plot(thisFit(:,1),thisFit(:,2),'k-','Parent',refAxis);
set(hFit,'LineWidth',1.1)
set(hData,'MarkerSize',5)
set(refAxis,'YScale','log','XScale','log');

end


%--------------------------------------------------------------------------

function addSLDPlot(thisFit,sldAxis)

%Plot

xdata = thisFit(:,1);

hFit = plot(thisFit(:,1),thisFit(:,2),'k-','Parent',sldAxis);
hold(sldAxis,'on');
drawnow;

set(hFit,'LineWidth',1.1)


end

%--------------------------------------------------------------------------
