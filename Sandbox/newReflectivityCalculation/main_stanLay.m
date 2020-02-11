% Tests the new calculation with standard layers
addpath('/home/arwel/Desktop/RasCAL/Sandbox/newCoderParatt/');
addpath('/home/arwel/Desktop/RasCAL/Sandbox/newCoderParatt/codegen/mex/callParatt');

% Load in the problem
problem = load('monolayerStandardLayers.mat');
problem = problem.problem;

setappdata(0,'problem',problem);

% Call the calculation
reflectivity_calculation();

% Now plot the results
figure(1); clf; hold on
problem = getappdata(0,'problem');
numberOfContrasts = problem.numberOfContrasts;
data = problem.shifted_data;
ref = problem.calculations.reflectivity;


for i = 1:numberOfContrasts
    thisSim = ref{i};
    thisData = data{i};
    mult = 10.^((i/100)*100);
    thisData(:,2) = thisData(:,2) ./ mult;
    thisData(:,3) = thisData(:,3) ./ mult;
    errorbar(thisData(:,1),thisData(:,2),thisData(:,3),'.');
    thisSim(:,2) = thisSim(:,2) ./ mult;
    plot(thisSim(:,1),thisSim(:,2));
end
set(gca,'YScale','log','XScale','log');

