function [layersList, SLDs] = customXY(problem)

% This function deals with a 'custom XY' calculation type.
% It calls the user function which returns an XY profile 
% as a two column array. This is then treated as 1 A
% unroughened slabs, but then these are grouped to 
% minimise the calculation load.

% First get the relevant information out
nbairs = problem.nbairs;
nbsubs = problem.nbsubs;
params = problem.params;
numberOfContrasts = problem.numberOfContrasts;

% Get the name of the module
name = problem.module.name;

% Strip ouut the extension if it's present
extens = strfind(name,'.m');
if ~isempty(extens)
    name = problem.module.name(1:extens-1);
end

% pre-allocation
layersList = cell(1,numberOfContrasts);

% Loop over the contrasts and get the custom XY profile for each one
for i = 1:numberOfContrasts
    try
        eval(['sld = ' name '(params,nbairs,nbsubs,i);'])
    catch
        disp('Error in custom file \n');
        disp(lasterr);
        return
    end

    % Now we need to chop up the SLD profile into grouped layers
    layersList{i} = resampleLayers(sld,1e-8);
    SLDs{i} = sld;
end


end
