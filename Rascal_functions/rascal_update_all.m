function f = rascal_update_all()

%Updates all the calculations based on anything that's
%happened in the GUI's.
%Needs to .....

%1. run 'packparams'.
%2. Call the reflectivity calculation
%3. Call rascal plotting

reflectivity_calculation();
rascal_plotting();


