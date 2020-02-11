% compare output of coder generated callParatt with the matlab 
% version
clear; close all
addpath(fullfile(pwd,'codegen','mex','callParatt'));

% Make the inputs. Use three contrasts..
% (1) X data
% simXData = linspace(0.001,0.1);
simXData = {linspace(0.013,0.4), linspace(0.013,0.4), linspace(0.013,0.4)};

% Scattering Length Densities
slds = {...
    [60 1e-6 3];
    [100 5e-6 3];
    [40 2e-6 3];...
    };

% nbairs
nbairs = [0 0 0];

% nbsubs 
nbsubs = [0 6.35e-6 2.07e-6];

% repeats
repeats = [1 1 1];

% resolutions...
resolutions = [0.03 0.03 0.03];

% ssubs 
ssubs = [3 3 3];

% Now call the calculation
% (1) Use the matlab version
simRef = callParatt(simXData(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));

% (2) ....now check the 'Coder' version
simRef2 = callParatt_mex(simXData(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));

% ..and plot the results
figure (1);
clf; hold on
for i = 1:length(simXData)
    plot(simXData{i}, simRef{i}, 'b--');
    plot(simXData{i}, simRef2{i}, 'r-');
    legend({'mlab', 'mex'});
end
set(gca,'YScale','log','XScale','log');