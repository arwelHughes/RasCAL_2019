

clear all

global sldProfile

figure(1); clf

model  = load('mol_model_sam_supported_bilayer.mat');
problem = model.problem;

sld = problem.calculations.slds{1};
x = sld(:,1);
prof = sld(:,2);
%setappdata(0,'sldFuncSLD',sld);
sldProfile = sld;

z = 0.034;
    
f = @(x) sldFunc(x);

xstart = x(1);
xend = x(end);
newX = linspace(xstart,xend,100);
for i = 1:length(newX)
    y(i) = f(newX(i));
end

tic
yy = adaptive(f, [xstart xend], 'minAngle',0.7*pi, 'nPoints', 50, 'vectorize', 'true');
toc

tic
yy = adaptive(f, [xstart xend], 'minAngle',0.7*pi, 'nPoints', 50, 'vectorize', 'false');
toc
%yy = adaptive(f, newX, 'minLength',100,'minAngle',0.92*pi);

subplot(1,2,1)
plot(x,prof,'b-',newX,y,'k:');
hold on
plot(yy(:,1),yy(:,2),'o');
plot(x,prof,'r.')

newX = yy(:,1);
newY = yy(:,2);
layers = zeros(length(newX)-1,2);

for i = 1:length(newX)-1
    thisX = newX(i);
    nextX = newX(i+1);
    thisY = newY(i);
    nextY = newY(i+1);
    
    thisLayThick = nextX - thisX;
    if nextY > thisY
        thisLayRho = ((nextY - thisY)/2) + thisY;
    else
        thisLayRho = ((thisY - nextY)/2) + nextY;
    end
   
   layers(i,:) = [thisLayThick thisLayRho];
end


%[resX, resY] = groupSamples(layers(:,1),layers(:,2),1e-9);
%resX = layers(:,1);
%resY = layers(:,2);

subplot(1,2,2)
plot(x+50,prof,'b-');
hold on
%blockPlot(layers(:,1),layers(:,2));
%blockPlot(resX,resY);

%layerPlot([resX(:),resY(:)]);
numberOfLayers = size(layers,1);
roughs = ones(numberOfLayers,1).*eps;
pLayers = [layers, roughs];
out = makeSLDProfileXY(layers(1,2),layers(end,2),eps,pLayers,size(pLayers,1),1);

plot(out(:,1),out(:,2),'r-');    
    


