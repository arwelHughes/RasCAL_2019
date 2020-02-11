function fitcontrol(varargin)
%Start routine for all the fitting
%1. Get the current values of everything 
problem = getappdata(0,'problem');
fitopts = getappdata(0,'fittingOptions');

%2. Set up all the parameters from fitting.
%Get check status and pack the fitting params
%accordingly. Reset the stop-flag.
setStopFlag(0);
[problem,out] = fitsetup(problem);
if strcmp(out{1},'fail')
    return
end

controlsPanel = getappdata(0,'controlsPanel');
awtinvoke(controlsPanel,'changeIconToHourglass');
statusBox = getappdata(0,'statusBox');

%3. Turn off calculation of SLD profile
% unless needed for update of the contrast
% is being resampled
problem.calcSLD = 0;

%4 Decide what we're fitting and call
%the correct fitting algorithm
switch problem.algorithm
    case 'simplex'
        awtinvoke(statusBox,'setText','Running Simplex');
        problem.Update = 10;
        problem = rascal_simplex(problem);
    case 'cmaes'
        awtinvoke(statusBox,'setText','Running CMAES');
        problem = rascal_cmaes_scaled(problem,fitopts);
    case 'MCS'
        awtinvoke(statusBox,'setText','Running MCS');
        problem = rascal_mcs(problem);
    case 'DE'
        awtinvoke(statusBox,'setText', 'Running Differential Evolution');
        %problem = rascal_differential_evolution(problem);
        x = rascal_DE_new_test(problem);
        problem.fitpars = x;
end

%problem = hPSO(problem);

%Clean up after the fit.
problem.calcSLD = 1;
problem = fitfinish(problem);
awtinvoke(statusBox,'setText','Ready');
awtinvoke(controlsPanel,'changeIconToReady');


%Save everything to memory
setappdata(0,'problem',problem);








