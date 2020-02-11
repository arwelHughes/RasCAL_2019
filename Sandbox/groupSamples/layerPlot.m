function layerPlot(layers)


% make the xy 'block' plot
% from the inputted layers
x = layers(:,1);
y = layers(:,2);

xPos = x(1);
allLays = [0 0];

for i = 1:length(x)-1
    thisLayThick = x(i);
    thisLayRho = y(i);
    nextLayRho = y(i+1);
    
    xs1 = [xPos thisLayRho];
    xs2 = [(xPos+thisLayThick) thisLayRho];
    xs3 = [(xPos+thisLayThick) nextLayRho];
    
    xPos = xPos + thisLayThick;
        
    thisLay = [xs1 ; xs2 ; xs3];
    allLays = [allLays ; thisLay];
end

allLays(:,1) = allLays(:,1)-5;

plot(allLays(:,1),allLays(:,2),'r-');
    