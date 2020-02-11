function makeCheckResamplePlot(resamFig,problem,values)

global sldProfile

% Function handle for adaptive resampling
f = @(x) sldFunc(x);

resampleOptionsPanel = getappdata(0,'resampleOptionsPanel');

figure(resamFig);
clf;
hold on;

nPoints = values.Nlayers;
angle = values.angle;

slds = problem.calculations.slds;
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
ssubs = problem.calculations.ssubs;


numberOfContrasts = problem.numberOfContrasts;
for i = 1:numberOfContrasts
    sldProfile = slds{i};
    plot(sldProfile(:,1),sldProfile(:,2),'k-');
    
    x = sldProfile(:,1);
    prof = sldProfile(:,2);
    
    xstart = x(1);
    xend = x(end);
    newX = linspace(xstart,xend,100);
    yy = adaptive(f, [xstart xend], 'minAngle', angle*pi, 'nPoints', nPoints);
    
    newX = yy(:,1);
    newY = yy(:,2);
    layers = zeros(length(newX)-1,3);
    
    % Now build a layer model from these resampled points
    for n = 1:length(newX)-1
        thisX = newX(n);
        nextX = newX(n+1);
        thisY = newY(n);
        nextY = newY(n+1);
        
        thisLayThick = nextX - thisX;
        if nextY > thisY
            thisLayRho = ((nextY - thisY)/2) + thisY;
        else
            thisLayRho = ((thisY - nextY)/2) + nextY;
        end
        
        layers(n,:) = [thisLayThick thisLayRho eps];
    end
    nlays = size(layers,1);
    repeats = 1;
    prof = makeSLDProfileXY(nbairs(i),nbsubs(i),ssubs(i),layers,nlays,repeats);
    plot(prof(:,1)-50,prof(:,2),'r-')
end

end