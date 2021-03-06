function [layersList,sub_rough] = standard_box_new(problem,Contrast);

%which contrast are we calculating
%contrast = problem.which_contrast;     

%Split up the parameters into layer details 
params = problem.params;
number_of_layers = problem.numberOfLayers;
if number_of_layers == 0
    sub_rough = params(1);
    layersList = [];
else
    layers = problem.layersDetails;
    layersValues = zeros(number_of_layers,4);
    for n = 1:number_of_layers
        thisLayer = layers{n};
        for m = 1:4
%   This is a change from the old version
%   Values used to be strings but the conversion]
%   was very slow. Now should have changed to
%   numbers for this version using 
%   'dealWithLegacyIssues.m'
            thisItem = thisLayer{m};
            if ~isnan(thisItem)
                layersValues(n,m) = params(thisItem);
            else
                layersValues(n,m) = NaN;
            end
        end
        whichBulk = thisLayer{6};
        if strcmp(whichBulk,'bulk in')
            layersValues(n,5) = 0;
        else
            layersValues(n,5) = 1;
        end
    end

    thisContrast = problem.contrastLayers(Contrast);
    a = str2num(thisContrast{:});
    if ~isempty(a)
        for n = 1:length(a)
            thisRow = a(n);
            layersList(n,:) = layersValues(thisRow,:);
        end
    else
        sub_rough = params(1);
        layersList = [];
    end
end

sub_rough = params(1);



