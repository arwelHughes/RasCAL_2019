% Tests the new calculation with custom layers
addpath('/home/arwel/Desktop/RasCAL/Sandbox/newCoderParatt/');
addpath('/home/arwel/Desktop/RasCAL/Sandbox/newCoderParatt/codegen/mex/callParatt');
addpath('/home/arwel/Documents/RascalDev/RAT/targetFunctions/common/resampleLayers');


% Load in the problem
addpath('/home/arwel/Desktop/RasCAL/Sandbox/models/mol_model_sam_supported_bilayer');

problem = load('mol_model_sam_supported_bilayer.mat');
problem = problem.problem;

setappdata(0,'problem',problem);

reflectivity_calculation();

% Now plot the results
figure(1); clf; 
problem = getappdata(0,'problem');
numberOfContrasts = problem.numberOfContrasts;
data = problem.shifted_data;
ref = problem.calculations.reflectivity;
sld = problem.calculations.slds;

for i = 1:numberOfContrasts
    subplot(1,2,1); hold on
    thisSim = ref{i};
    thisData = data{i};
    mult = 10.^((i/100)*100);
    thisData(:,2) = thisData(:,2) ./ mult;
    thisData(:,3) = thisData(:,3) ./ mult;
    errorbar(thisData(:,1),thisData(:,2),thisData(:,3),'.');
    thisSim(:,2) = thisSim(:,2) ./ mult;
    plot(thisSim(:,1),thisSim(:,2));
    
    subplot(1,2,2); hold on
    plot(sld{i}(:,1),sld{i}(:,2));
end
subplot(1,2,1)
set(gca,'YScale','log','XScale','log');

figure(2); clf; hold on
layers = problem.calculations.layers;
stepPlot(sld,layers);



