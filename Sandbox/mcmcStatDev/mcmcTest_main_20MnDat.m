clc;
close all;
clear model data params options

%problem = load('20mN_data.mat');
problem = load('original_dspc_bilayer.mat');

problem = problem.problem;
problem.calcSLD = 0;
problem = packparams(problem);

setappdata(0,'problem',problem);

addpath('mcmcstat');
run = true;
switch run
    case true
        [res, chain, bestVals_max] = runFit_MCMCstat(3);
    otherwise
        prevFit = load('prevFit_20MnDat');
        prevFit = prevFit.prevFit;
        res = prevFit.res;
        chain = prevFit.chain;
end

[ref, intervals] = calcMCMCstatRefErrors(res,chain,bestVals_max);

%Make the plots.
hRefFigure = figure(1);
makeRefIntervalPlots(ref,intervals,hRefFigure);




