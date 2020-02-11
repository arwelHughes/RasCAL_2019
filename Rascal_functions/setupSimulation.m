function problem = setupSimulation(problem,i);

if ~any(strcmp('simLimits',fields(problem))) 
    for n = 1:problem.numberOfContrasts
        problem.simLimits{n} = [0.007 0.5];
    end
end

if ~any(strcmp('simNPoints',fields(problem))) 
    for n = 1:problem.numberOfContrasts
        problem.simNPoints(n) = 100;
    end
end

if length(problem.simLimits) < i
    problem.simLimits{i} = [0.007 0.5];
end

lowPoint = problem.simLimits{i}(1);
hiPoint = problem.simLimits{i}(2);

problem.dataLimits{i}(1) = lowPoint;
problem.dataLimits{i}(2) = hiPoint;
problem.simLimits{i}(1) = lowPoint;
problem.simLimits{i}(2) = hiPoint;

npoints = problem.simNPoints(i);
step = (hiPoint-lowPoint)/npoints;

dummyXVals = [lowPoint:step:hiPoint];
dummyYVals = 1e-6.*ones(length(dummyXVals),1);
problem.data{i} = [dummyXVals(:) dummyYVals(:) dummyYVals(:)];
problem.include_data(i) = 0;

