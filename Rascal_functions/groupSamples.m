%-------------------------------------------------------------------------
function [x, y] = groupSamples(x,y,tolerance)


debug = 0;

numberOfLayers = length(x);
count = 1;
newX = [];
newY = [];

thisLayerx = [x(1)];
thisLayery = [y(1)];
try
for i = 1:numberOfLayers-1;
    %debug
    diff = abs(y(i+1) - y(i));
    if debug; fprintf('Diff:- %5.5g  y(i):- %5.3g   pos:-  %5.2f \n',diff,y(i),i);end
    if diff <= tolerance ;
        thisLayerx = [thisLayerx x(i)];
        thisLayery = [thisLayery (y(i)+(diff/2))];
    else
        if debug; disp('grouping \n'); end
        newX = [newX sum(thisLayerx)];
        newY = [newY mean(thisLayery)];
        thisLayerx = [x(i)];
        thisLayery = [y(i)];
    end
end
catch
    [a,b] = lasterr;
    disp('debug');
end

    
newX = [newX sum(thisLayerx)];
newY = [newY mean(thisLayery)];  
    
x = newX;
y = newY;
end
