clear all
figure(1); clf

model  = load('mol_model_sam_supported_bilayer.mat');
problem = model.problem;

sld = problem.calculations.slds{1};
x = sld(:,1);
prof = sld(:,2);

[hx,hy] = resample_sld(sld,1);
[newX,newY] = groupSamples(hx,hy,1e-7);

figure(1); clf; hold on
plot(x,prof,'k:');
hold on
blockPlot(newX,newY);
disp('debug');


