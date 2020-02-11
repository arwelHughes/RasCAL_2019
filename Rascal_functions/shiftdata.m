function problem = shiftdata(problem)

%Shifts the data according to scale factor
scalefac = problem.scalefactors;
horshift = problem.qshifts;

for i = 1:problem.numberOfContrasts
    switch problem.dataPresent(i)
        case 1
            data = problem.data{i};
            if scalefac(i) == 0
                scalefac(i) = 1e-30;
            end
            data(:,1) = data(:,1) + horshift(i);
            data(:,2) = data(:,2) ./ scalefac(i);
            data(:,3) = data(:,3) ./ scalefac(i);
            
            lowLimit = problem.dataLimits{i}(1);
            hiLimit = problem.dataLimits{i}(2);
            
            lowIndex = find(data(:,1) < lowLimit);
            if ~isempty(lowIndex)
                lowIndex = lowIndex(end);
            else
                lowIndex = 1;
            end
            
            hiIndex = find(data(:,1) > hiLimit);
            if  ~isempty(hiIndex)
                hiIndex = hiIndex(1);
            else
                hiIndex = length(data(:,1));
            end
    
            problem.shifted_data{i} = data(lowIndex:hiIndex,:);
            
%             if (strcmp(problem.q4,'yes'))
% %                
%                 
% %                 x  = dat(:,1);
% %                 y = dat(:,2)-back;
% %                 e = dat(:,3);%-back;
% % 
% %                 q4 = x.^4;
% % 
% %                 yn = (y .* q4) + 1e-3 ;
% %                 en = (e.* q4) ;
%                 ref = makeFresnelData(problem,i);
%                 dat = problem.shifted_data{i};
%                 back = problem.backgrounds(i);
%                 x  = dat(:,1);
%                 y = dat(:,2)-back;
%                 e = dat(:,3)-back;
%                 
%                 yn = y./ref;
%                 en = e./ref;
%                 
%                 all = [x(:) yn(:) en(:)];
%                 problem.shifted_data{i} = all;
%                 problem.fresnel{i} = ref;
%             end
        case 0
            data = problem.data{i};
            problem.shifted_data{i} = data;
            problem.fresnel{i} = ones(length(data(:,1)),1);
    end
end
 
end

% ------------------------------------------------------------------------

function Ref = makeFresnelData(problem,contrast)

    this_data = problem.shifted_data{contrast};
    xdata = this_data(:,1);
    nbair = problem.nbairs(contrast);
    nbsub = problem.nbsubs(contrast);
    slds = [0 0 0];
    resol = problem.resolution;
    resolType = problem.resolType;
    %abeles(xdata,SLDs,nbair,nbsub,ssub,nrepeats,sinter,resol)
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,repeats,
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,0,1,resolType,resol);
    xCell = cell(1,1); xCell{1} = xdata';
    sldCell = cell(1,1); sldCell{1} = slds;
    %simRef = callParatt(simXdata,slds,nbairs,nbsubs,repeats,resolutions,ssubs)
    Ref = callParatt_mex(xCell,sldCell,nbair,nbsub,1,resol,eps);
    Ref = cell2mat(Ref);

end
 

    