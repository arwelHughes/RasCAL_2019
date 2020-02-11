function fitcontrol(varargin)
%Start routine for all the fitting
%1. Get the current values of everything 
problem = getappdata(0,'problem');
fitopts = getappdata(0,'fittingOptions');

%2. Set up all the parameters from fitting.
%Get check status and pack the fitting params
%accordingly. Reset the stop-flag.
setStopFlag(0);
[problem,out] = e_fitsetup(problem);
if strcmp(out{1},'fail')
    return
end

controlsPanel = getappdata(0,'controlsPanel');
awtinvoke(controlsPanel,'changeIconToHourglass');
statusBox = getappdata(0,'statusBox');

%3 Decide what we're fitting and call
%the correct fitting algorithm

%problem.algorithm = 'DE';

switch problem.algorithm
    case 'simplex'
        awtinvoke(statusBox,'setText','Running Simplex');
        addInfoText('Update of display set to every 500 iterations for error analysis');
        problem.Update = 500;
        problem = rascal_simplex(problem);
    case 'cmaes';
        awtinvoke(statusBox,'setText','Running CMAES');
        problem = rascal_cmaes_scaled(problem,fitopts);
    case 'DE';
        awtinvoke(statusBox,'setText','Running DE');
        x = rascal_DE_new_test(problem);
        problem.fitpars = x;
end

%problem = hPSO(problem);

%Clean up after the fit.
problem = e_fitfinish(problem);
awtinvoke(statusBox,'setText','Ready');
awtinvoke(controlsPanel,'changeIconToReady');
%Java garbage collect...
java.lang.System.gc();


%Save everything to memory
setappdata(0,'problem',problem);








