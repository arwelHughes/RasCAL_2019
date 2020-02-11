function problem = rascal_defaults(problem);

%

problem.algorithm = 'simplex';
problem.eb = 0;
problem.plotType = 2;
problem.dataShiftValue = 0;

problem.q4 = 'no';

if ~any(ismember(fields(problem),'useReducedChiSq'))
    problem.useReducedChiSquared = 1;
end

if strcmp(problem.module.type,'Standard Layers')
    for i = 1:problem.numberOfContrasts
        thisRepeats =  problem.repeatLayers{i};
        if length(thisRepeats) < 2
            problem.repeatLayers{i} = [0 1];
        end
    end
end


fitopts = getappdata(0,'fittingOptions');
if isempty(fitopts)
    fitopts.simplex.TargetChi = 1;
    fitopts.simplex.MaxFunEvals = 1e6;
    fitopts.simplex.stopTolParam = 1e-7;
    fitopts.simplex.stopFunTol = 1e-7;

    fitopts.cmaes.TargetChi = 1;
    fitopts.cmaes.MaxFunEval = 1e4;
    fitopts.cmaes.StopTolX = 1e-6;
    fitopts.cmaes.StopTolFun = 1e-6;
    fitopts.cmaes.PopSize= 50;
    fitopts.cmaes.Maxdp = inf;
    fitopts.cmaes.Mindp = 0;
    fitopts.cmaes.RecombW = 1;
    
    fitopts.DE.CrossOverProb = 0.8;
    fitopts.DE.ValueToReach = 1;
    fitopts.DE.PopSize = 50;
    fitopts.DE.StepSIze = 0.8;
    fitopts.DE.Strategy = 1;
end

if ~any(strcmp('simLimits',fields(problem))) 
    for n = 1:problem.numberOfContrasts
        problem.simLimits{n} = [0.007 0.5];
    end
end

if ~any(strcmp('simNPoints',fields(problem))) 
    for n = 1:problem.numberOfContrasts
        problem.simNPoints(n) = 500;
    end
end

% Convert strings in LayersDetails calls to
% numbers to speed up the calculation
disp('debug');
setappdata(0,'fittingOptions',fitopts);
setappdata(0,'problem',problem);



