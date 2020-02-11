function reflectivity_calculation_fast

problem = getappdata(0,'problem');

%Apply corrections to all datasets.
problem = backsorts(problem);
problem = shiftdata(problem);

%Carry out the actual reflectivity calculations.
whichtype = problem.module.type;
switch whichtype
    case 'Custom XY Profile'
        problem = xy_profile_calc(problem);
    otherwise
        problem = callReflectivityCalculation(problem);
end


%Work out chi squared.
number_of_contrasts = problem.numberOfContrasts;

for i = 1:number_of_contrasts;
    this_data = problem.shifted_data{i};
    xdata = this_data(:,1);
    
    lolimit = find(xdata < problem.fitlowrange(i));
    if isempty(lolimit)
        limits(1) = 1;
    else
        limits(1) = lolimit(end);
    end

    hilimit = find(xdata > problem.fithirange(i));
    if isempty(hilimit)
        limits(2) = length(this_data(:,1));
    else
        limits(2) = hilimit(1);
    end
    
    switch problem.q4
        case 'yes'
            thisref = problem.calculations.reflectivity{i};
            fresnel = problem.fresnel{i};
            simFresnel = problem.calculations.simFresnel{i};
            
            thisref(:,2) = thisref(:,2) ./ fresnel;
            problem.calculations.reflectivity{i} = thisref;
            
            thisSim = problem.calculations.Simulation{i};
            thisSim(:,2) = thisSim(:,2) ./ simFresnel(:,2);
            problem.calculations.Simulation{i} = thisSim;
            
        case 'no'
            thisref = problem.calculations.reflectivity{i};
            thisref(:,2) = thisref(:,2) + problem.backgrounds(i);
            problem.calculations.reflectivity{i} = thisref;
            
            thisSim = problem.calculations.Simulation{i};
            thisSim(:,2) = thisSim(:,2) + problem.backgrounds(i);
            problem.calculations.Simulation{i} = thisSim;
    end
    problem.calculations.all_chis(i) = rascal_chi_squared(thisref(limits(1):limits(2),2),this_data((limits(1):limits(2)),2),length(problem.params),this_data((limits(1):limits(2)),3),[]);
 end

%Need to output a combined squared
%Only use the 'included' datasets'
problem.calculations.all_chis = problem.calculations.all_chis .* problem.include_data;  %acts as a mask
problem.calculations.sum_chi = sum(problem.calculations.all_chis) + sum(problem.calculations.xtra_fitness);
setappdata(0,'problem',problem);

end




    