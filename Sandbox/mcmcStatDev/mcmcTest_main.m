clear;
clc;
close all;

%problem = load('defaultProject.mat');
problem = load('20mN_data.mat');
%problem = load('original_dspc_bilayer.mat');
problem = problem.problem;
problem.calcSLD = 0;
problem = packparams(problem);

setappdata(0,'problem',problem);

addpath('mcmcstat');
run = true;
switch run
    case true
        [res, chain] = runFit_MCMCstat(0);
    otherwise
        prevFit = load('prevFit');
        prevFit = prevFit.prevFit;
        res = prevFit.res;
        chain = prevFit.chain;
end

[ref, intervals] = calcMCMCstatRefErrors(res,chain);

%Make the plots.
hRefFigure = figure(1);
makeRefIntervalPlots(ref,intervals,hRefFigure);




