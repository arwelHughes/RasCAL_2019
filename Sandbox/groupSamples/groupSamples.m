function [newX, newY] = groupSamples(x,y,tolerance)


numberOfLayers = length(x);
count = 1;
newX = 0;
newY = 0;

thisLayerx = x(1);
thisLayery = y(1);
for i = 1:numberOfLayers-1
    diff = abs(y(i+1) - y(i));
    if diff <= tolerance 
        thisLayerx = [thisLayerx x(i)];
        thisLayery = [thisLayery (y(i)+(diff/2))];
    else
        newX = [newX sum(thisLayerx)];
        newY = [newY mean(thisLayery)];
        thisLayerx = [x(i)];
        thisLayery = [y(i)];
    end
end
    
newX = [newX sum(thisLayerx)];
newY = [newY mean(thisLayery)];  
    
end
