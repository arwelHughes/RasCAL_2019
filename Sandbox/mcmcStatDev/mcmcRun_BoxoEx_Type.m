function mcmcRun_BoxoEx_Type()

clear all

setappdata(0,'whichContrast',1);

method = 'dram';    % Adaptation method
nsimu = 20000;      % number of simulations
adaptint = 500;     % adaptation interval

% Load in the problem....
problem = load('20mN_data.mat');
problem = problem.problem;
problem = packparams(problem);
setappdata(0,'problem',problem);
numberOfContrasts = problem.numberOfContrasts;
fitNames = problem.fitNames;
fitpars = problem.fitpars;
limits = problem.fitconstr;

% Use the example method to put things in 'batches'...
allData = problem.data;

for i = 1:numberOfContrasts
    data{i}.ydata = allData{i}(:,2);
    data{i}.xdata = allData{i}(:,1);
    data{i}.weights = 1./(allData{i}(:,3));
    data{i}.problem = problem;
end

% Now make the params structure..
params = {};
for i = 1:length(fitNames)
    thisParam{1} = fitNames{i};
    thisParam{2} = fitpars(i);
    thisParam{3} = limits(i,1);
    thisParam{4} = limits(i,2);
    params{i,1} = thisParam;
end

% Set the model options..
model.modelfun = @thisFitFun;    % 
model.sigma2 = 0.01;
model.N0 = 4;

options.method = method;
options.nsimu = nsimu;
options.adaptint = adaptint;
options.printint = 200;
options.verbosity = 1;
options.waitbar = 1;
options.updatesigma = 1;
options.stats = 1;

results = [];
[results, chain, s2chain, sschain] = mcmcrun(model, data, params, options, results);
[results, chain, s2chain, sschain] = mcmcrun(model, data, params, options, results);
[results, chain, s2chain, sschain] = mcmcrun(model, data, params, options, results);

figure(1);
clf
mcmcplot(chain,[],results,'chainpanel');




numPars = length(fitNames);
rows = ceil(numPars/4);
cols = 4;
for i = 1:numPars
    subplot(rows,cols,i);
    [n,x] = hist(chain(:,i),30);
    n = n./ max(n);
    bar(x,n);
end





disp('debug');

end


function y = thisFitFun(data,theta)

problem = data.problem;
whichContrast = getappdata(0,'whichContrast');
numberOfContrasts = problem.numberOfContrasts;
if whichContrast >= numberOfContrasts
    newWhichContrast  = 1;
else
    newWhichContrast = whichContrast + 1;
end

% Get this data
thisData = data.ydata;
problem = data.problem;

problem.fitpars = theta;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');

thisRef = problem.calculations.reflectivity{whichContrast};

y = thisRef(:,2);

setappdata(0,'whichContrast',newWhichContrast);



end




