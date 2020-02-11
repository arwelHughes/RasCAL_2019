function problem = backsorts(problem)

%Distributes the background and shift values 
%Among the relevant datasets.


for i = 1:problem.numberOfContrasts
    thisBack = problem.contrastBacks(i);
    problem.backgrounds(i) = problem.backs(thisBack);

    thisShift = problem.contrastShifts(i);
    problem.qshifts(i) = problem.shifts_horisontal(thisShift);

    thisScale = problem.contrastScales(i);
    problem.scalefactors(i) = problem.scalefac(thisScale);

    thisNbair = problem.contrastNbas(i);
    problem.nbairs(i) = problem.nba(thisNbair);

    thisNbsub = problem.contrastNbss(i);
    problem.nbsubs(i) = problem.nbs(thisNbsub);
    
    thisResol = problem.contrastResolutions(i);
    problem.resolutions(i) = problem.resolution(thisResol);
end




