function stepPlot(SLDs,layers)

numberOfContrasts = length(SLDs);


thisLays = layers{1};
thisX = thisLays(:,1);
thisY = thisLays(:,2);

for n = 1:numberOfContrasts
    currX = 0;
    yLast = thisY(1);
    for i = 1:length(thisX)
        xStep = thisX(i);
        thisYnow = thisY(i);
        plot([currX, currX],[yLast, thisYnow],'b-');
        plot([currX, currX+xStep],[thisYnow, thisYnow],'b-');
        currX = currX + xStep;
        yLast = thisYnow;
    end
end