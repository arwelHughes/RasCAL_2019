function problem =  fitfinish(problem)

%Unpack the parameters
problem = unpackparams(problem);

setappdata(0,'problem',problem);

%Update calculations and plots;
reflectivity_calculation();
updateTheGraphs();
setappdata(0,'problem',problem);

%Update the tables
update_params();

unlockMainGuiFrame();
enableMenus();

rascalMemoryCleanup;
