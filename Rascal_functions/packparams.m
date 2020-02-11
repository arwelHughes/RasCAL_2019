function problem = packparams(problem);

%Separate out the params array into fitting
%and unfitting arrays.


%problem = getappdata(0,'problem');


%We need to pack the parameters into seperate vectors
%of those that are being fitted, and those that are
%held constant.
problem.fitpars = [];
problem.otherpars = [];
problem.fitconstr = [];
problem.otherconstr = [];
problem.fitNames = {};
for i = 1:length(problem.fityesno);
    if problem.fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.params(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.paramnames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.params(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.constr(i,2);
    end
end

%Also do the same for backgrounds...
for i = 1:length(problem.backgrounds_fityesno);
    if problem.backgrounds_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.backs(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.backs_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.backs_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.backsNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.backs(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.backs_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.backs_constr(i,2);
    end
end

%..also for the scale factors
for i = 1:length(problem.scalefac_fityesno);
    if problem.scalefac_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.scalefac(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.scale_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.scale_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.scalesNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.scalefac(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.scale_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.scale_constr(i,2);
    end
end    

%Need qshifts
for i = 1:length(problem.shifts_fityesno);
    if problem.shifts_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.shifts_horisontal(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.shifts_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.shifts_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.shiftsNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.shifts_horisontal(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.shifts_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.shifts_constr(i,2);
    end
end 

%Nbairs
for i = 1:length(problem.nbairs_fityesno);
    if problem.nbairs_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.nba(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.nbairs_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.nbairs_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.nbaNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.nba(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.nbairs_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.nbairs_constr(i,2);
    end
end 

%NBsubs
for i = 1:length(problem.nbsubs_fityesno);
    if problem.nbsubs_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.nbs(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.nbsubs_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.nbsubs_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.nbsNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.nbs(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.nbsubs_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.nbsubs_constr(i,2);
    end
end 

%Resolution.....
for i = 1:length(problem.resolution_fityesno);
    if problem.resolution_fityesno(i) == 1;
        problem.fitpars(length(problem.fitpars)+1) = problem.resolution(i);
        problem.fitconstr(length(problem.fitpars),1) = problem.resolution_constr(i,1);
        problem.fitconstr(length(problem.fitpars),2) = problem.resolution_constr(i,2);
        problem.fitNames{length(problem.fitpars)} = problem.resolNames{i};
    else
        problem.otherpars(length(problem.otherpars)+1) = problem.resolution(i);
        problem.otherconstr(length(problem.otherpars),1) = problem.resolution_constr(i,1);
        problem.otherconstr(length(problem.otherpars),2) = problem.resolution_constr(i,2);
    end
end 


a = 1;

%setappdata(0,'problem',problem);