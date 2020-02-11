%Test of new Matlab Coder reflectivity calculation.

clear all;


geometry = 'air liquid';
%geometry = 'solid liquid';

if strcmpi(geometry,'air liquid')

    slds = {
        [20 5e-6 3;...
        10 1.4e-6 3],...
        };
    
    nbairs = 0;
    nbsubs = 2.073e-6; % SMW
    
    ssubs = 5;
    
    simXData = linspace(0.01,0.3,500);
    repeats = 1;
    resolutions = 0.03;
    numberOfContrasts = 1;
    
elseif strcmpi(geometry,'solid liquid')

    slds = {[10 1.4e-6 3,...
        20 -5e-7 3;...
        6 -8e-7, 3;...
        20 -5e-7, 3;...
        10 1.4e-6 3],...
        };
    
    nbairs = 2.073e-6;  % Si
    nbsubs = 6.35e-6;   % D2O
    ssubs = 5;
    repeats = 1;
    resolutions = 0.03;
end

% The paratt calculation procedds through the 
% z,rho,rough stack, and the parameter 'ssub' in
% callParatt is the final roughness encountered. 
% For air liquid 'ssub' is therefore the substrate roughness.
% For solid liquid, the substrate roughness is the first roughness
% encountered, and 'ssub' is then the roughness of the outermost layer.
% The rougnesses need to be arranged accordingly.
switch geometry
    case 'air liquid'
        % The stack is used as is. Substrate
        % roughness is the last roughness to
        % be encountered.
        for i = 1:numberOfContrasts
            thisSld = slds{i};
            numberOfLayers = size(thisSld,1);
            ssubs(i) = ssubs(i);
         end
    case 'solid liquid'
        % In this case the 'substrate roughness' is
        % the first roughness to be encountered. So, make
        % this roughness the first in the 'slds' stack, with the
        % other roughness' shifting down through the stack.
        % 'ssubs' then is the roughness of the final layer.
        numberOfContrasts = length(slds);
        for i = 1:numberOfContrasts
            thisSLD = slds{i};
            allRoughs = slds(:,3);
            subRough = ssubs(i);
            ssub = allRoughs(end);
            allRoughs = circShift(allRoughs,1);
            allRoughs(1) = subRough;
            thisSLD(:,3) = allRoughs;
            slds{i} = thisSLD;
            ssubs(i) = ssub;
        end
end

%Now the new way
simRef2 = callParatt2(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));

% figure(1); clf; set(gca,'YScale','log'); hold on
% for i = 1:length(simXdata)
%     plot(simXdata{i},simRef{i},'r-');
%     plot(simXdata{i},simRef2{i},'b-')
% end
% 
% set(gca,'YScale','log');

disp('debug');
