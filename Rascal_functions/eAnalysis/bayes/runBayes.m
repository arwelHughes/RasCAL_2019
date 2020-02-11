function output = runBayes(loop,nsimu,burnin,params)

% Clear any values from previous runs if prsent
clear model data options

problem = getappdata(0,'problem');
oldCalcSLD = problem.calcSLD;
problem.calcSLD = 0;
problem = packparams(problem);

% fitpars = problem.fitpars;
% fitNames = problem.fitNames;
% limits = problem.fitconstr;

%data = problem.data;
% Arrange the data into the format mcmcstat requires 
% We have the same number of 'batches' as contrasts.
% Also need to pass problem in order to access this
% from the subfunctions.
numberOfContrasts = problem.numberOfContrasts;
for i = 1:numberOfContrasts
    thisData = problem.data{i};
    data{i}.ydata = [thisData(:,1:2)];
    data{i}.problem = problem;
end


% Define model and method options.
model.modelfun      =   @refModel;     % will return a reflectivity curve
model.ssfun         =   @fitModel;     % will return chi squared
%model.sigma2        =   1;          % initial error variance
%model.N0            =   1;             % prior (invchisq) weight for sigma2
model.nbatch        = numberOfContrasts;

options.method      = 'dram';          % adaptation method (mh, am, dr, dram)
options.nsimu       = nsimu;           % no of simulation
%options.qcov        = eye(3)*0.001;    % proposal covariance (not sure why 11....)
%options.adaptint    = adaptint;        % adaptation interval
options.printint    = 200;             % how often to show info of acceptance ratios
options.verbosity   = 1;               % how much to show output
options.waitbar     = 1;               % show graphical waitbar
options.updatesigma = 0;               % update error variance
options.stats       = 1;               % save extra statistics in result
options.burnintime  = burnin;      % burn in time..

% options.method = 'dram';
% options.nsimu = nsimu;%50000;
% options.verbosity = 1;
% options.adaptint = 500;
% options.burnintime = burnin;
% 
% model.ssfun = @MCMC_Intrafun;

res = [];
for i = 1:loop
    bayesInfoText(sprintf('Running loop %d of %d',i,loop));
    [results,chain,s2chain,sschain] = mcmcrun(model, data, params, options, res);
end

output.results = results;
output.chain = chain;
output.s2chain = s2chain;
output.sschain = sschain;
output.bestPars = results.mean;
output.data = data;

problem.calcSLD = oldCalcSLD;
setappdata(0,'problem',problem)

end

%-------------------------------------------------------
function ss = fitModel(theta,data)

% Sum of squares function used in the calculation
% Calls reflectivity calculation and returns the value of chisquared

pars = theta;                         % Current parameter values from mcmcstat
problem = data{1}.problem;              % Struct needed for the calculation

problem.fitpars = pars;
problem = unpackparams(problem);
%setappdata(0,'problem',problem);
problem = reflectivity_calculation(problem);
%problem = getappdata(0,'problem');
ss = problem.calculations.sum_chi;

end


%---------------------------------------------------------
function ymod = refModel(data,theta,varargin)

% Returns the reflectivity profile. Need to do some extra work because
% 'reflectivity-calculation' adjusts the data according to scalefactor.
% We need to reverse this correction, and actually return the simulation
% corrected for the scalefactor. We have to do this because the scalefactor 
% is in itself one of our fitting parameters (no need to correct the data -
% problem.shifted_data contains the corrected data, but
% problem.data is a record of the original).

if isempty(varargin)
    contrast = 1;
else
    contrast = varargin{1};
end

if iscell(data)
    thisData = data{contrast}.ydata;
    problem = data{contrast}.problem;
else
    thisData = data.ydata;
    problem = data.problem;
end

if nargin == 4
    debugPlot = varargin{2};
else
    debugPlot = 0;
end

params = theta;

problem.fitpars = params;
problem = unpackparams(problem);
%setappdata(0,'problem',problem);
problem = reflectivity_calculation(problem);
%problem = getappdata(0,'problem');
ySim = problem.calculations.Simulation{contrast};

% Need to correct the simulation for the scalefactor (i.e. move the sim to
% the data, unlike what we normally do)
scale = problem.scalefactors(1);        
ymod = ySim(:,2).*scale;        % Do something more flashy here for multiple contrasts

% Debug plot to check that everything works..
%debugPlot = 0;
if debugPlot
    plot(thisData(:,1),thisData(:,2),'o');
    hold on
    plot(ySim(:,1),ymod,'-');
    hold off
end

end
