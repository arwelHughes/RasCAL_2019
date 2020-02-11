function [intervals,paramIntervals,best] = calcMCMCStatErrors_mcmcPred(output,problem)

% Uses the functions from MCMCstat to calculate the prediction
% intervals of the data and the fit.

results = output.results;
chain = output.chain;
data = output.data;
bestPars = output.bestPars;

% Figure out the best fits
problem.fitpars = bestPars;
problem = unpackparams(problem);
problem = reflectivity_calculation(problem);
bestRef = problem.calculations.Simulation;
bestSld = problem.calculations.slds;

% Calculate the data confidence intervals
outRef = mcmcpred(results,chain,[],data,@refModel,300);
outSld = mcmcpredSld(results,chain,[],data,@sldModel,300);

best.bestRef = bestRef;
best.bestSld = bestSld;

intervals.outRef = outRef;
intervals.outSld = outSld;

% Finally the parameter intervals
predInt = 0.95; %95% confidence intervals
intervals_95 = confIntervals(chain,bestPars,predInt);

predInt = 0.65; %65% confidence intervals
intervals_65 = confIntervals(chain,bestPars,predInt);

predInt = 0.25; %25% confidence intervals
intervals_25 = confIntervals(chain,bestPars,predInt);

paramIntervals.intervals_95 = intervals_95;
paramIntervals.intervals_65 = intervals_65;
paramIntervals.intervals_25 = intervals_25;

end

% ------------------------------------------------------------------------

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

% -------------------------------------------------------------------------

function ymod = sldModel(data,theta,varargin)

% Returns the SLD profile. 

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
problem = reflectivity_calculation(problem);
ySim = problem.calculations.slds{contrast};
ymod = ySim(:,2);

% Debug plot to check that everything works..
%debugPlot = 0;
if debugPlot
    plot(thisData(:,1),thisData(:,2),'-');
end


end
