function problem =  fitfinish(problem)

%Unpack the parameters
problem = unpackparams(problem);

%setappdata(0,'problem',problem);

%Update calculations and plots;
problem = reflectivity_calculation(problem);
setappdata(0,'problem',problem);
updateTheGraphs();
%Update the tables
update_params();

unlockMainGuiFrame();
enableMenus();

rascalMemoryCleanup;
