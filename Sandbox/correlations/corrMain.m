clear
a = load('mon_8_contrasts.mat');
output = a.output;
chain = output.chain;

b = load('Monolayer_8_contrasts.mat');
problem = b.problem;

names = problem.fitNames;

h = figure(1);
clf;
hold on

pointsFlag = 1;
[p,npars] = size(chain);

points = 100;

makeCorrelationPlot_new(h,chain,npars,names,pointsFlag,points)