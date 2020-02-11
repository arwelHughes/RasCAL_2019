function out = posterior(choose,gridPoints,minorGridPoints);

% choose = [1 2];
% gridPoints = 45;
% minorGridPoints = 5;

problem = getappdata(0,'problem');
oldProblem = problem;
problem = packparams(problem);
setappdata(0,'problem',problem);

type = problem.module.type;
if strcmp(type,'Custom Layers');
    calcFun = @fastParatt;
elseif strcmp(type,'Standard Layers');
    calcFun = @fastParatt_StanLay;
end

limits = problem.fitconstr;
params = problem.fitpars;
names = problem.fitNames;

numberOfDims = length(params);
%minorGridPoints = 10;


%Make the grid
s = ones(1,numberOfDims)*minorGridPoints;
s(choose) = gridPoints;

grid = zeros(s);

for i = 1:length(s);
    steps(i) = (limits(i,2)-limits(i,1))/(s(i)-1);
end

%calculate at each point using linesr indexing
noOfElements = prod(size(grid));

%Time test
i = 1;
tic;
[els{1:numberOfDims}] = ind2sub(size(grid),i);
elements = cell2mat(els);
for n = 1:length(elements)
    thisMin = limits(n,1);
    thesePars(n) = ((elements(n)-1)*steps(n))+thisMin;
end
problem.fitpars = thesePars;
problem = unpackparams(problem);
problem = calcFun(problem);
tt = toc;

estTime = (tt * noOfElements)/3600;
disp(['Number of elements is '  num2str(noOfElements)]);
disp(['Time per iter is '  num2str(tt) ' seconds.']);

 a = input(['Est Time is ' num2str(estTime) ' hours. Continue y\n?'],'s');
if strcmp(a,'n')
    out = [];
    return
end



for i = 1:noOfElements
    elements = ind2sub_wrap(grid,i,numberOfDims);
    %[els{1:numberOfDims}] = ind2sub(size(grid),i);
    %elements = cell2mat(els);
    for n = 1:length(elements)
        thisMin = limits(n,1);
        thesePars(n) = ((elements(n)-1)*steps(n))+thisMin;
    end
    problem.fitpars = thesePars;
    problem = unpackparams(problem);
    problem = calcFun(problem);
    chisq = problem.calculations.sum_chi;
    grid(i) = exp(-chisq/2);
    if ~rem(i,100)
        disp([num2str((i/noOfElements)*100) '%']);
    end
end

fullGrid = grid;

axisVals = [];
for i = 1:numberOfDims
    for n = 1:s(i);
        axisVals(n,i) = ((n-1) * steps(i))+limits(i,1);
    end
end


%Note - when integrating over dimensions, will always go in the
%order params/backs/scales/shifts/nbairs/nbsubs/resols
%choose = [1 1];
mask = zeros(numberOfDims,1);
mask(choose) = 1;
for i = 1:length(mask)
    if mask(i) == 0
        grid = trapz(grid,i);
    end
end

grid = squeeze(grid);

xIndex = max(choose);
yIndex = min(choose);

valsx = axisVals(:,max(choose));
valsy = axisVals(:,min(choose));

figure(1); clf
subplot(3,1,1);
contour(valsx,valsy,grid,'k-');
xlabel(names{xIndex});
ylabel(names{yIndex});

gaussx = trapz(grid,1);
gaussy = trapz(grid,2);

gaussx = gaussx/trapz(gaussx);
gaussy = gaussy/trapz(gaussy);

subplot(3,1,2);
plot(valsx,gaussx,'k-');
xlabel(names(xIndex))

subplot(3,1,3);
plot(valsy,gaussy,'k-');
xlabel(names(yIndex))

out.fullGrid = fullGrid;
out.fullAxisVals = axisVals;
out.limits = limits;
out.names = names;
out.grid = grid;
out.xlabel = names(xIndex);
out.ylabel = names(yIndex);
out.xGauss = gaussx;
out.yGauss = gaussy;
out.xAxisVals = valsx;
out.yAxisVals = valsy;

end

%--------------------------------------------------------------------------
function elements = ind2sub_wrap(grid,i,numberOfDims)

[els{1:numberOfDims}] = ind2sub(size(grid),i);
elements = cell2mat(els);

end

%-----------------------------------------------

function problem = fastParatt(problem)

%problem = getappdata(0,'problem');


%Start by applying all the shifys to the data.....
problem = shiftdata(problem);

%Now do the parrat calc with custom model....
number_of_contrasts = problem.numberOfContrasts;
for i = 1:number_of_contrasts;
    problem.which_contrast = i;
    extens = findstr(problem.module.name,'.m');
    if ~isempty(extens)
        name = problem.module.name(1:extens-1);
    else
        name = problem.module.name;
    end
    eval(['[output,s_sub] = ' name '(problem.params,problem.nbairs,problem.nbsubs,i);']);
    layers = output;
    n = size(output);
    if n(2) == 5;
        for j = 1:n(1);
            this_pcw = output(j,4);
            if output(j,5) == 1
                pc_add = nbsub;
            else
                pc_add = nbair;
            end
            if ~isnan(this_pcw)
                layers(j,2) = pc_add*(this_pcw/100) + (1-(this_pcw/100))*layers(j,2);
            end
        end
    end
    
    
    this_data = problem.shifted_data{i};
    xdata = this_data(:,1);
    ydata = this_data(:,2);
    eb = this_data(:,3);
    
    points = length(xdata);
    if isempty(output)
        slds = [0 nbair 0];
        lays = 0;
    else
        slds = layers(:,1:3);
        lays = size(slds,1);
    end
    
    layers = size(slds,1);
    resol = problem.resolutions(i);
    resolType = problem.resolType;
    nbsub = problem.nbsubs(i);
    nbair = problem.nbairs(i);
    Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,1,resolType,resol);
    Ref = Ref + problem.backgrounds(i);
    problem.calculations.reflectivity{i} = [xdata(:) Ref(:)];
    
    P = length(problem.params);
    problem.calculations.all_chis(i) = chi_squared(Ref,ydata,P,eb);
end

problem.calculations.sum_chi = sum(problem.calculations.all_chis);

end

%-------------------------------------------------------------------------

function problem = fastParatt_StanLay(problem)

%problem = getappdata(0,'problem');


%Start by applying all the shifys to the data.....
problem = shiftdata(problem);

%Now do the parrat calc with custom model....
number_of_contrasts = problem.numberOfContrasts;
for i = 1:number_of_contrasts;
    problem.which_contrast = i;
    [output,s_sub] = standard_box_new(problem);
    layers = output;
    
    this_data = problem.shifted_data{i};
    xdata = this_data(:,1);
    ydata = this_data(:,2);
    eb = this_data(:,3);
    
    points = length(xdata);
    if isempty(output)
        slds = [0 nbair 0];
        lays = 0;
    else
        slds = layers(:,1:3);
        lays = size(slds,1);
    end
    
    layers = size(slds,1);
    resol = problem.resolutions(i);
    resolType = problem.resolType;
    nbsub = problem.nbsubs(i);
    nbair = problem.nbairs(i);
    Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,1,resolType,resol);
    Ref = Ref + problem.backgrounds(i);
    problem.calculations.reflectivity{i} = [xdata(:) Ref(:)];
    
    P = length(problem.params);
    problem.calculations.all_chis(i) = chi_squared(Ref,ydata,P,eb);
end

problem.calculations.sum_chi = sum(problem.calculations.all_chis);

end

%-------------------------------------------------------------------------

function problem = shiftdata(problem);

%Shifts the data according to scale factor
scalefac = problem.scalefactors;
horshift = problem.qshifts;

for i = 1:problem.numberOfContrasts;
    switch problem.dataPresent(i);
        case 1
            data = problem.data{i};
            if scalefac(i) == 0;
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
            
        case 0
            data = problem.data{i};
            problem.shifted_data{i} = data;
    end
end

end

%-------------------------------------------------------------------------

function chi2 = chi_squared(fit,y,P,eb)

N = max(size(y));
if N <= P
    N = (P + 1);
end
terms = ((y-fit)./eb).^2;
n = find(terms == Inf);
terms(n) = 0;
chi2 = 1/(N-P)*sum(terms);


end

%--------------------------------------------------------------------------

function problem = unpackparams(problem);

%Unpack the params out of the fitparsma and otherparams arrays
%back into problem.params

%problem = getappdata(0,'problem');

uppars = [];
unpacked_counter = 1;
packed_counter = 1;
for i = 1:length(problem.fityesno);
    if problem.fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.params = uppars;

uppars = [];
%Also the backgrounds
for i = 1:length(problem.backgrounds_fityesno);
    if problem.backgrounds_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.backs = uppars;

uppars = [];
%And scalefactors...
for i = 1:length(problem.scalefac_fityesno);
    if problem.scalefac_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.scalefac = uppars;

uppars = [];
%Now the qshifts
for i = 1:length(problem.shifts_fityesno);
    if problem.shifts_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.shifts_horisontal = uppars;


uppars = [];
%Now the Nbairs
for i = 1:length(problem.nbairs_fityesno);
    if problem.nbairs_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.nba = uppars;

uppars = [];
%Now the qshifts
for i = 1:length(problem.nbsubs_fityesno);
    if problem.nbsubs_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.nbs = uppars;


%Finally resolutions
uppars = [];
%Now the qshifts
for i = 1:length(problem.resolution_fityesno);
    if problem.resolution_fityesno(i) == 1;
        uppars(length(uppars)+1) = problem.fitpars(unpacked_counter);
        unpacked_counter = unpacked_counter + 1;
    else
        uppars(length(uppars)+1) = problem.otherpars(packed_counter);
        packed_counter = packed_counter + 1;
    end
end

problem.resolution = uppars;


%setappdata(0,'problem',problem);


end

%--------------------------------------------------------------------------

function [layersList,sub_rough] = standard_box_new(problem);

%which contrast are we calculating
contrast = problem.which_contrast;     

%Split up the parameters into layer details 
params = problem.params;
number_of_layers = problem.numberOfLayers;
if number_of_layers == 0
    sub_rough = params(1);
    layersList = [];
else
    layers = problem.layersDetails;
    layersValues = zeros(number_of_layers,4);
    for n = 1:number_of_layers;
        thisLayer = layers{n};
        for m = 1:4;
            thisItemString = thisLayer{m};
            if isempty(findstr(thisItemString,'NaN')) && ~isempty(thisItemString);
                    layersValues(n,m) = params(str2double(thisItemString));
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

    thisContrast = problem.contrastLayers(contrast);
    a = str2num(thisContrast{:});
    if ~isempty(a)
        for n = 1:length(a);
            thisRow = a(n);
            layersList(n,:) = layersValues(thisRow,:);
        end
    else
        sub_rough = params(1);
        layersList = [];
    end
end

sub_rough = params(1);

end
