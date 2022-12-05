function problem = unpackparams(problem)

%Unpack the params out of the fitparsma and otherparams arrays
%back into problem.params

%problem = getappdata(0,'problem');

uppars = [];
unpacked_counter = 1;
packed_counter = 1;
for i = 1:length(problem.fityesno)
    if problem.fityesno(i) == 1
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.params = uppars;

uppars = [];
%Also the backgrounds
for i = 1:length(problem.backgrounds_fityesno);
    if problem.backgrounds_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.backs = uppars;

uppars = [];
%And scalefactors...
for i = 1:length(problem.scalefac_fityesno);
    if problem.scalefac_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.scalefac = uppars;

uppars = [];
%Now the qshifts
for i = 1:length(problem.shifts_fityesno);
    if problem.shifts_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.shifts_horisontal = uppars;


uppars = [];
%Now the Nbairs
for i = 1:length(problem.nbairs_fityesno);
    if problem.nbairs_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.nba = uppars;

uppars = [];
%Now the qshifts
for i = 1:length(problem.nbsubs_fityesno);
    if problem.nbsubs_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.nbs = uppars;


%Finally resolutions
uppars = [];
%Now the qshifts
for i = 1:length(problem.resolution_fityesno);
    if problem.resolution_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.resolution = uppars;


%setappdata(0,'problem',problem);