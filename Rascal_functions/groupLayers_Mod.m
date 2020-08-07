function [outLayers, outSsubs] = groupLayers_Mod(allLayers,allRoughs,geometry,nbair,nbsubs)

%Arrange layers according to geometry and apply any coverage correction.
%
%[outLayers, outSsubs] = groupLayers_Mod(allLayers,allRoughs,numberOfContrasts,geometry,nbairs,nbsubs)
% Inputs:
%     allLayers = cell array, one for each contrast. Each cell is the 
%                 list of layer values for each contrast.
%                 e.g. allLayers{1} = [d1, rho1, r1, %hyd, hyd_which
%                                      d2, rho2, r2, %hyd2, hyd_which_2..
%                                      etc]
%     allRoughs = Double of substrate roughness for each contrast.
%     numberOfContrasts = double.
%     geometry =  'Air / Liquid (or solid)' or 'Solid / Liquid'
%     nbairs = vector of nbair values.
%     nbsubs = vector of nbsub values.
%
%     The paratt calculation procedds through the 
%     z,rho,rough stack, and the parameter 'ssub' in
%     callParatt is the final roughness encountered. 
%     For air liquid 'ssub' is therefore the substrate roughness.
%     For solid liquid, the substrate roughness is the first roughness
%     encountered, and 'ssub' is then the roughness of the outermost layer.
%     The rougnesses need to be arranged accordingly.
%
%
% Outputs:
%     outLayers = cell array of layers param values for each contrast.
%                 e.g. outLayers{1} = [d1 rho1 r1;
%                                      d2 rho2 r2
%                                      ... etc   ]
%     outSsubs = vector of substrate roughness values.
%


%outLayers = cell(1,numberOfContrasts);
%outSsubs = zeros(1,numberOfContrasts);


%coder.varsize('layers',[Inf,5],[1 1]);

%for i = 1:numberOfContrasts
    output = allLayers;
    s_sub = allRoughs;
    outSsubs = allRoughs;
    layers = zeros(size(output));
    if ~isempty(output)
        switch geometry
            case 'Air / Liquid (or solid)'
                layers = output;
                %s_sub = rsub;
            otherwise
                roughs = output(:,3);
                sldss = output(:,2);
                thicks = output(:,1);
                rsub = roughs(end);
                roughs = [s_sub ; roughs(1:end-1)];
                n = size(output,2);
                if n == 5
                    cov = output(:,4);
                    layers = [thicks(:) sldss(:) roughs(:) cov(:)];
                else
                    layers = [thicks(:) sldss(:) roughs(:)];
                end
                s_sub = rsub;
        end
        
        %Deal with the %coverage if present
        n = size(output,2);
        l = size(output,1);
        if n == 5
            for j = 1:l
                this_pcw = output(j,4);
                if output(j,5) == 1
                    pc_add = nbsubs;
                else
                    pc_add = nbair;
                end
                if ~isnan(this_pcw)
                    layers(j,2) = pc_add*(this_pcw/100) + (1-(this_pcw/100))*layers(j,2);
                end
            end
        end 
    end
%     problem.layers{i} = layers;
%     problem.ssubs(i) = s_sub;
if ~isempty(layers)
    outLayers = layers(:,1:3);
else
    outLayers = zeros(1,3);
end
outSsubs = s_sub;


end


%end
    