function layersList = customLayers(problem)

% This function deals with a 'Custom Layers'
% calculation type. It calls the user supplied function which
% must output either a [d rho rough] array or a 
% [d rho rough hydration which-bulk] array. We need to do this for
% each contrast.

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

% Loop over the contrasts and get the custom layers for each one
for i = 1:numberOfContrasts
    try
        eval(['[out,s_sub] = ' name '(params,nbairs,nbsubs,i);'])
    catch
        disp('Error in custom file \n');
        disp(lasterr);
        return
    end
    
    layersList{i} = out;
end


end

