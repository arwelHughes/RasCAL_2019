function output = Bayes2(loop,nsimu,burnin,priors,bayesHandles)

rmpath('mcmcstat');

problem = getappdata(0,'problem');
oldProblem = problem;
problem = packparams(problem);
setappdata(0,'problem',problem);

type = problem.module.type;
if strcmp(type,'Custom Layers')
    calcFun = @fastParatt;
elseif strcmp(type,'Standard Layers')
    calcFun = @fastParatt_StanLay;
elseif strcmp(type,'Custom XY Profile')
    calcFun = @fastParratt_CustomProf;
end
  
%calcFun = @reflectivity_calculation;

problem.calcFun = calcFun;
model.ssfun = @fitfun;

%Distribute the data into sub structures
ExpData = problem.data;
nContrasts = length(ExpData);
model.N = 0;
for i = 1:nContrasts
     thisData = ExpData{i};
     len = size(thisData,1);
     model.N = model.N + len;
end

data.problem = problem;

fit_params = problem.fitpars';
names = problem.fitNames';
lims = problem.fitconstr;

params = {};
for i = 1:length(names);
    thisGroup = {names{i}, fit_params(i), lims(i,1), lims(i,2)};
    params{i} = thisGroup;
end

%Now set the priors...
if ~isempty(priors);
    for i = 1:length(priors);
        thisPrior = priors{i,:};
        thisName = thisPrior{1};
        where = find(ismember(names,thisName));
        if isempty(where);
            disp(fprintf('Warning: No match for prior %s found. Ignoring'));
        else
            params{where} = thisPrior;
        end
    end
end       


results = [];
for i = 1:loop
    [results,chain,s2chain,sschain]=mcmcrun(model,data,params,struct('nsimu',nsimu,'updatesigma',1,'burnintime',burnin,'method','dram','verbosity',2),results);
end
 
bestPars = results.mean;

%Diagnostics plot
diagnosticsPlot(chain,results,bayesHandles.hDiag)

%Histogram Plot
ret = makeHistsWindow(names,chain,length(names),bayesHandles.hHists);

%Parameters plot
parsPlot(chain,results,names,bayesHandles.hVals);

% %Correlations plot
% corrPlot(chain,results,names,bayesHandles.hCorr); 

%SLD and Reflectivity plots....
[refBounds,sldBounds,bestRefs,bestSlds,bestChi] = shading(chain,results,problem,bestPars,0.4,bayesHandles.hRefs);


% handles.SLDs = hsldFig;
% handles.Refs = hrefFig;
% handles.hists = hhistFig;
% handles.table = hparsFig;
% handles.chain = hChainFig;

output.chain = chain;
output.names = names;
output.limits = lims;
output.results = results;
output.handles = bayesHandles;
output.refBounds = refBounds;
output.sldBounds = sldBounds;
output.bestRefs = bestRefs;
output.bestSlds = bestSlds;
output.bestChi = bestChi;
output.data = problem.shifted_data;

setappdata(0,'calcsRun',1);

end

%-------------------------------------------------------

function val = fitfun(pars,data)

problem = data.problem;
problem.fitpars = pars;
problem = unpackparams(problem);
problem = backsorts(problem);
calcFun = problem.calcFun; %Function handle for the correct calc type
problem = calcFun(problem);
val = problem.calculations.sum_chi;

end

%---------------------------------------------------

function problem = fastParatt(problem)

%problem = getappdata(0,'problem');


%Start by applying all the shifys to the data.....
problem = shiftdata(problem);

%Now do the parrat calc with custom model....
number_of_contrasts = problem.numberOfContrasts;

    extens = findstr(problem.module.name,'.m');
    if ~isempty(extens)
        name = problem.module.name(1:extens-1);
    else
        name = problem.module.name;
    end

callfun = str2func(name);

allchis = [];
for i = 1:number_of_contrasts
    tempProblem = problem;
    tempProblem.which_contrast = i;
    nbsub = tempProblem.nbsubs(i);
    nbair = tempProblem.nbairs(i);
    %eval(['[output,s_sub] = ' name '(tempProblem.params,tempProblem.nbairs,tempProblem.nbsubs,i);']);
    
    [output,s_sub] = callfun(tempProblem.params,tempProblem.nbairs,tempProblem.nbsubs,i);
    layers = output;
    n = size(output);
    if n(2) == 5
        for j = 1:n(1)
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
    
    
    this_data = tempProblem.shifted_data{i};
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
    resol = tempProblem.resolutions(i);
    resolType = tempProblem.resolType;
    nbsub = tempProblem.nbsubs(i);
    nbair = tempProblem.nbairs(i);
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,1,resolType,resol);
    xCell = cell(1,1); xCell{1} = xdata';
    sldsCell = cell(1,1); sldsCell{1} = slds;
    
    Ref = callParatt_mex(xCell,sldsCell,nbair,nbsub,1,resol,s_sub);
    Ref = Ref{:} + problem.backgrounds(i);
    reflectivity{i} = [xdata(:) Ref(:)];
    
    P = length(tempProblem.params);
    all_chis(i) = chi_squared(Ref,ydata,P,eb);
end

problem.calculations.sum_chi = sum(all_chis);
problem.calculations.reflectivity = reflectivity;

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
        slds = [0 problem.nbairs(i) 0];
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
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,1,resolType,resol);
    xCell = cell(1,1); xCell{1} = xdata';
    sldsCell = cell(1,1); sldsCell{1} = slds;
    Ref = callParatt_mex(xCell,sldsCell,nbair,nbsub,1,resol,s_sub);
    Ref = Ref{:} + problem.backgrounds(i);
    problem.calculations.reflectivity{i} = [xdata(:) Ref(:)];
    
    P = length(problem.params);
    problem.calculations.all_chis(i) = chi_squared(Ref,ydata,P,eb);
end

problem.calculations.sum_chi = sum(problem.calculations.all_chis);

end

%-------------------------------------------------------------------------
function problem = fastParratt_CustomProf(problem)

number_of_contrasts = problem.numberOfContrasts;
for loop = 1:number_of_contrasts
    problem.which_contrast = loop;
    params = problem.params;
    bulk_in = problem.nbairs;
    bulk_out= problem.nbsubs;
    name = problem.module.name;
    point = findstr(name,'.');
    if ~isempty(point)
        name = name(1:point-1);
    end
    a = ['[output] = ' name '(params,bulk_in,bulk_out,loop);'];
    eval(a);

    if (size(output,2) ~= 2)
        addInfoText('For this type of problem, module output needs to be SLD profile as two columns of z-values(in Å) and SLD');
        return
    end
    problem.calculations.slds{loop} = output;
    %Calculate all the necessary params...
    %First change the reflectivity curve into boxes...
    output = curve_to_boxes(output);

  
     nbsub = problem.nbsubs(loop);
     nbair = problem.nbairs(loop);
%     
% 
    this_data = problem.shifted_data{loop};
    xdata = this_data(:,1);
    ydata = this_data(:,2);
    eb = this_data(:,3);
    %and the reflectivity...
    thicks = output(:,1);
    slds = output(:,2);
    points = length(xdata);
    layers = length(slds);
    roughs = zeros(layers,1);
    slds = [thicks(:) slds(:) roughs(:)];
    resol = problem.resolution;
    resolType = problem.resolType;
    %abeles(xdata,SLDs,nbair,nbsub,ssub,nrepeats,sinter,resol)
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,s_sub,repeats,
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,0,1,2,resol);
    Ref = callParatt_mex(xdata,slds,nbair,nbsub,1,resol,s_sub);
    
    %Ref = abeles_new_2(xdata,slds,nbair,nbsub,1,1,resolType,resol);
    simXLo = problem.simLimits{loop}(1);
    simXHi = problem.simLimits{loop}(2);
    
    middleSection = xdata;
    
    if simXLo < xdata(1);
        step = xdata(2)-xdata(1);
        firstSection = [simXLo:step:(xdata(1)-step)];
    else
        firstSection = [];
    end
    
    if simXHi > xdata(end);
        step = xdata(end)-xdata(end-1);
        lastSection = [xdata(end)+step:step:simXHi];
    else
        lastSection = [];
    end
    
    simXdata = [firstSection(:) ; middleSection(:) ; lastSection(:)];
    
    s_sub = 0;
    %simRef = abeles_new_2(simXdata(:),slds,nbair,nbsub,0,1,resolType,resol);
    simRef = callParatt_mex(simXdata(:),slds,nbair,nbsub,0,1,resolType,resol);
    switch problem.q4
        case 'yes'
            %simFres = abeles_new_2(simXdata(:),[0 0 0],nbair,nbsub,0,1,resolType,resol);
            simFres = callParatt_mex(simXdata(:),[0 0 0],nbair,nbsub,0,1,resolType,resol);
        otherwise
            simFres = ones(length(simXdata),1);
    end
    problem.calculations.reflectivity{loop} = [xdata Ref];
    problem.calculations.Simulation{loop} = [simXdata(:) simRef(:)];
    problem.calculations.simFresnel{loop} = [simXdata(:) simFres];
    %problem.calculations.slds{i} = SLD;
    
    P = length(problem.fitpars);
    problem.calculations.all_chis(loop) = chi_squared(Ref,ydata,P,eb);
end

problem.calculations.sum_chi = sum(problem.calculations.all_chis);
    






end

%-------------------------------------------------------------------------

function [layersList,sub_rough] = standard_box_new(problem)

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




function [refBounds,sldBounds,bestRef,bestSLD,bestChi] = shading(chain,results,problem,bestPars,factor,hRefs)

res = [];
refMat = [];
sldMat = [];
sldPoints = [];
chi = [];
dispFreq = 200;
oldProblem = problem;
numberOfFits = size(chain,1);
confInt = 0.95;

loopNum = factor*numberOfFits;



%Pre-allocation
allData = problem.shifted_data;
allCurves = problem.calculations.slds;
for j = 1:length(allCurves)
    thesePoints(j) = length(allCurves{j});
end
sldPoints = max(thesePoints);

for i = 1:length(allData);
    thisData = allData{i};
    thisMem = zeros(loopNum,length(thisData));
    thisMem2 = zeros(loopNum,sldPoints);
    refMat{i} = thisMem;
    sldMat{i} = thisMem2;
end

h = getappdata(0,'bayesHandles');
figure(h.hMain);



try
%sldPoints = 0;
for i = 1:loopNum
    if factor < 1
        try
            thisID = round(rand*numberOfFits);
            thesePars = chain(thisID,:);
        catch
            thesePars = chain(i,:);
        end
    else
        thesePars = chain(i,:);
    end
    
    problem.fitpars = thesePars;
    problem = unpackparams(problem);
    setappdata(0,'problem',problem);
    reflectivity_calculation;
    problem = getappdata(0,'problem');
    SLD{i} = problem.calculations.slds;
    REF{i} = problem.calculations.Simulation;
    chi(i) = problem.calculations.sum_chi;
%     if sldPoints == 0;
%        allCurves = SLD{:};
%        for j = 1:length(allCurves)
%            thesePoints(j) = length(allCurves{j});
%        end
%        sldPoints = max(thesePoints);
%     end
    
    for n = 1:size(problem.calculations.Simulation,2)
        if i == 1;
            l(n) = length(problem.shifted_data{n}(:,1));
        end
        thisRef = problem.calculations.Simulation{n}(:,:);
        thisDataX = problem.shifted_data{n}(:,1);
        
        minX = thisDataX(1);
        maxX = thisDataX(end);

        minSim = find(thisRef(:,1)==minX);
        maxSim = find(thisRef(:,1)==maxX);

        thisRef = thisRef(minSim:maxSim,2)';
        
        
        
        if (length(thisRef) < l(n))
            addPoints = l(n) - length(thisRef);
            addVector = ones(1,addPoints)*thisRef(end);
            thisRef = [thisRef addVector];
        end
        refMat{n}(i,:) =  thisRef;
        
        thisSLD = problem.calculations.slds{n}(:,2)';
        if (length(thisSLD) < sldPoints)
            addPoints = sldPoints - length(thisSLD);
            addVector = ones(1,addPoints)*thisSLD(end);
            thisSLD = [thisSLD addVector];
        elseif (length(thisSLD) > sldPoints)
                thisSLD = thisSLD(1:sldPoints);
        end
             
        
        sldMat{n}(i,:) = thisSLD(1:sldPoints);
    end
    if (rem(i,dispFreq) == 20);
        pc = (i/loopNum)*100;
        bayesInfoText(sprintf('Processing chain: %5.1f percent complete ',pc));
        drawnow
    end
end
catch
    disp('Debug');
end
res.refMat = refMat;
res.sldMat = sldMat;
res.chi = chi;
loopNum = numberOfFits;


cInterval = round(confInt * (loopNum * factor));

try
for n = 1:size(problem.calculations.Simulation,2)
    refAndChi = [chi' refMat{n}];
    sldAndChi = [chi' sldMat{n}];
    refAndChi = sort(refAndChi,1,'ascend');
    sldAndChi = sort(sldAndChi,1,'ascend');
    trRef = refAndChi(1:cInterval,2:end);
    trSLD = sldAndChi(1:cInterval,2:end);
    trimRefMat{n} = trRef;
    trimSldMat{n} = trSLD;
    drawnow
end
catch 
    disp('debug');
end


problem.fitpars = bestPars;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');
bestSLD = problem.calculations.slds;
bestRef = problem.calculations.Simulation;
bestChi = problem.calculations.sum_chi;

%First the Reflectivities.....
%work out min and maximum points for each curve
for n = 1:size(problem.calculations.Simulation,2);
    thisRef = trimRefMat{n};
    npoints = size(thisRef,2);
    minVal = zeros(npoints,1);maxVal = zeros(npoints,1);
    for m = 1:npoints;
      thisCol = thisRef(:,m);
      minVal(m) = min(thisCol);
      maxVal(m) = max(thisCol);
    end
    minRefPoints{n} = minVal;
    maxRefPoints{n} = maxVal;
end
        
res.minLine = minRefPoints{1};
res.maxLine = maxRefPoints{1};

allCurves = trimRefMat{1};

figure(hRefs);
subplot(1,2,1); cla; 
set(gca,'YScale','log');
set(gca,'XScale','log');
axis([0.001 0.3 1e-7 5]);
hold on
numberOfContrasts = size(problem.calculations.Simulation,2);

for n = 1:numberOfContrasts;
    thisRef = bestRef{n};
    thisData = problem.shifted_data{n};
    thisRefMin = find(thisData(1,1)==thisRef(:,1));
    thisRefMax = find(thisData(end,1)==thisRef(:,1));
    thisRef = thisRef(thisRefMin:thisRefMax,:);
    thisMin = minRefPoints{n};
    thisMax = maxRefPoints{n};
    if (n-1) > 0
        if n == 2
            mult = 1000;
        else
            mult = 10^(2*n);
        end
        thisMin = thisMin ./ mult;
        thisMax = thisMax ./ mult;
        thisRef(:,2) = thisRef(:,2) ./mult;
    end
    cc = [0.6 0.6 0.6];
    points = length(thisRef(:,1));
    makePatch(thisRef(:,1),thisRef(:,2),thisMin(1:points),thisMax(1:points), cc);
end

problem = shiftdata(problem);
data = problem.shifted_data;
ran = zeros(numberOfContrasts,4);
for i = 1:numberOfContrasts
    thisData = data{i};
    if (i-1) > 0
        if i == 2
            mult = 1000;
        else
            mult = 10^(2*i);
        end
        thisData(:,2) = thisData(:,2) ./ mult;
        thisData(:,3) = thisData(:,3) ./ mult;
    end
    h = errorbar(thisData(:,1),thisData(:,2),thisData(:,3),'k.');
    ran(i,:) = [min(thisData(:,1)) max(thisData(:,1)) min(thisData(:,2)) max(thisData(:,2))];
    set(h,'Markersize',7);
end
set(gca,'FontSize',20);
hh = xlabel('Qz(Å^-^1)');
set(hh,'FontSize',20);
hh = ylabel('Reflectivity');
set(hh,'FontSize',20);
%Set axes to the min and max values plus 10%
minXValue = min(ran(:,1));
maxXValue = max(ran(:,2));
minYValue = min(ran(:,3));
maxYValue = max(ran(:,4));
xRangeBorder = (maxXValue - minXValue)/5;
yRangeBorder = (maxYValue - minYValue)/5;
if (minXValue-xRangeBorder) > 0;
    xLim = (minXValue-xRangeBorder);
else
    xLim = -inf;
end

if (minYValue-yRangeBorder) > 0;
    yLim = (minYValue-yRangeBorder);
else
    yLim = -inf;
end

axis([xLim (maxXValue+xRangeBorder) yLim (maxYValue+yRangeBorder)]);

%Now need to make the SLD plots...
%work out min and maximum points for each curve
for n = 1:size(problem.calculations.Simulation,2);
    thisSld = trimSldMat{n};
    npoints = size(thisSld,2);
    minVal = zeros(npoints,1);maxVal = zeros(npoints,1);
    for m = 1:npoints;
      thisCol = thisSld(:,m);
      minVal(m) = min(thisCol);
      maxVal(m) = max(thisCol);
    end
    minSldPoints{n} = minVal;
    maxSldPoints{n} = maxVal;
end
% 

% res.minRefPoints = minRefPoints;
% res.maxRefPoints = maxRefPoints;
% res.minSldPoints = minSldPoints;
% res.maxSldPoints = maxSldPoints;
% res.bestRef = bestRef;
% res.bestSLD = bestSLD;
% save('calcResults','res')

figure(hRefs); subplot(1,2,2); cla; hold on
for n = 1:numberOfContrasts;
    thisSld = bestSLD{n};
    thisMin = minSldPoints{n};
    thisMax = maxSldPoints{n};
    thisy = thisSld(:,2);
    thisx = thisSld(:,1);
    if length(thisy) > length(thisMin)
        thisy = thisy(1:length(thisMin));
        thisx = thisx(1:length(thisMin));
    elseif length(thisy) < length(thisMin)
        thisMin = thisMin(1:length(thisy));
        thisMax = thisMax(1:length(thisy));
    end
    makePatchNeg(thisx,thisy,thisMin,thisMax,[0.6 0.6 0.6]);
end


set(gca,'FontSize',20);
hh = xlabel('Distance(Å)');
set(hh,'FontSize',20);
hh = ylabel('SLD (Å^-^2)');
set(hh,'FontSize',20);

refBounds = {minRefPoints; maxRefPoints};
sldBounds = {minSldPoints; maxSldPoints};

setappdata(0,'problem',oldProblem);

end

%--------------------------------------------------------------------------

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

function diagnosticsPlot(chain,results,diagHandle)
figure(diagHandle)
mcmcplot(chain,[],results,'chainpanel');


end

%--------------------------------------------------------------------------

function histPlot(chain,results)
mcmcplot(chain,[],results,'hist',30);


end

%--------------------------------------------------------------------------

function parsPlot(chain,results,names,hparsFig)

vals = calcLimits(chain,results,names);
figure(hparsFig); clf
%set(hparsFig,'Position',[50 50   908   593]);
t = uitable('Parent',hparsFig);%,'Position', [25 25 860 550]);
set(t,'Position',[20 20 700 300])
set(t,'Data',vals');
set(t,'ColumnWidth',{820})
set(t,'FontSize',10)

end

%--------------------------------------------------------------------------

function corrPlot(chain,results,names,hCorrFig)
% figure(hCorrFig);
% % mcmcplot(chain,[],results,'pairs');
% chain = output.chain;
% names = output.names;
% limits = output.limits;
numberOfParams = length(names);

%h = figure(hCorrFig); clf; hold on    
% p1 = chain(:,11);
% p2 = chain(:,12);
% n1 = names{10};
% n2 = names{11};
% make2Dplot(p1,p2,n1,n2);




%Work out how many plots we have..
% a = ones(numberOfParams-1);b = triu(a);nPlots = length(find(b));
% %Use 9 figures per page....
% lastFig = 1;
% hCorr = [];
% try
% numberOfFigures = floor(nPlots/9);    

counter = 1; %lastFig = lastFig + 1;
% for n = 1:numberOfParams-1;
%     for m = (n+1):numberOfParams;
%         h = scrollSubPlot(6,6,counter); box on;
%         p1 = chain(:,m);
%         p2 = chain(:,n);
%         n1 = names{m};
%         n2 = names{n};
%         make2Dplot(p1,p2,n1,n2);
%         drawnow
%         counter = counter + 1;
% %         if counter == 10;
% %             h = figure(lastFig+1); clf; hold on;
% %             hCorr = [hCorr h];
% %             counter = 1;
% %             lastFig = lastFig + 1;
% %         end
%     end
% end
% catch



end

%--------------------------------------------------------------------------

function make2Dplot(mcmcP1,mcmcP2,name1,name2);


%mcmcP1 = chain(:,vars(1));
%mcmcP2 = chain(:,vars(2));
%grey = [0.7 0.7 0.7];
%h = plot(mcmcP2,mcmcP1,'.','Color',grey);


D = [mcmcP1(:) mcmcP2(:)];

[H,valsD1,valsD2] = hist3(D,15);

%Normalise the histogram to probability
dx = valsD1(2)-valsD1(1);
H = H./((sum(sum(H))/dx));
H = H./(max(max(H)));

[c,h] = contourf(valsD1,valsD2,H,[0.1 0.35 0.75],'k-');

map = [0 0.3 0.4; 0 0.3 0.7; 0 0.3 0.9];


colormap(map);
set(h,'LineWidth',1.5);

h1 = xlabel(name1);
h2 = ylabel(name2);

% l1 = limits(vars(2),:);
% l2 = limits(vars(1),:);


% set(gca,'YLim',l2);
% set(gca,'XLim',l1);

set(gca,'FontSize',6);
set(h1,'FontSize',6);
set(h2,'FontSize',6);
drawnow


end
