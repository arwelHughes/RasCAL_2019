function out = makeSLDProfileXY(nbair,nbsub,ssub,layers,numberOfLayers,nrepeats)

if numberOfLayers>0
    layerThicks = sum(layers(:,1));
    totalRange = (layerThicks*nrepeats) + 150;  
    x = 0:totalRange;
    Lays = zeros(length(x),(numberOfLayers*nrepeats)+2);
    boxCen = 0;
    boxWidth = 100;
    nextLayRough = layers(1,3);
    airBox = asymconvstep(x,boxWidth,boxCen,nextLayRough,nextLayRough,nbair);
    lastBoxEdge = boxCen + (boxWidth/2);
    for n = 1:nrepeats
        for i = 1:numberOfLayers
            thisLayThick = layers(i,1);
            thisLaySLD = layers(i,2);
            thisLayRough = layers(i,3);
            if i<numberOfLayers
                nextLayRough = layers(i+1,3);
%             elseif (i == numberOfLayers) && (n < nrepeats)
%                 nextLayRough = layers(1,3);
            else
                nextLayRough = ssub;
            end
            thisBoxCentre = lastBoxEdge + (thisLayThick/2);
            thisBox = asymconvstep(x,thisLayThick,thisBoxCentre,thisLayRough,nextLayRough,thisLaySLD);
            Lays(:,i+(numberOfLayers*(n-1))) = thisBox;
            lastBoxEdge = thisBoxCentre + (thisLayThick/2);
            %plot(x,Lays(:,i));
        end
    end
    thisLayRough = nextLayRough;%layers(end,3);
    thisLayThick = (x(end)-lastBoxEdge)*2;
    thisLaySLD = nbsub;
    nextLayRough = ssub;
    thisBoxCentre = x(end);
    Lays(:,(numberOfLayers*nrepeats)+1) = asymconvstep(x,thisLayThick,thisBoxCentre,thisLayRough,nextLayRough,thisLaySLD);
    %plot(x,Lays(:,(numberOfLayers*nrepeats)+1))
    
    Lays(:,(numberOfLayers*nrepeats)+2) = airBox;
    %plot(x,Lays(:,(numberOfLayers*nrepeats)+2))
    SLD = sum(Lays,2);
else
    x = 0:100;
    subsBoxCen = max(x);
    airBoxCen = 0;
    widths = max(x);
    airBox = asymconvstep(x,widths,airBoxCen,ssub,ssub,nbair);
    subBox = asymconvstep(x,widths,subsBoxCen,ssub,ssub,nbsub);
    SLD = airBox + subBox;
end

%plot(x,SLD)
out = [x(:),SLD(:)];




