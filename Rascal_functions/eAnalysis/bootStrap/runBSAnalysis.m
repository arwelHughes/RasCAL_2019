function runBSAnalysis(src,ev);

bsPanel = getappdata(0,'bsPanel');
fitopts = getappdata(0,'fittingOptions');
dataSet = getappdata(0,'bsHistCollection');
paramsCombo = getappdata(0,'paramsCombo');

set(src,'Enabled',0);

numberOfLoopsBox = bsPanel.getBsNRunsBox();
numberOfLoops = str2num(numberOfLoopsBox.getText());

progressBar = bsPanel.getBsProgressBar();

algBox = bsPanel.getbootStrapAlgComboBox();
whichAlg = algBox.getSelectedIndex();
if whichAlg == 0;
    rSelectSimplex;
else
    rSelectDE;
end

problem = getappdata(0,'problem');
setappdata(0,'originalProblem',problem);

%theData = problem.data;
bestPars = problem.fitpars;
thisData = problem.data;
thisData = trimDataToLimits(thisData,problem);
originalData = thisData;
originalProblem = problem;

selected = (paramsCombo.getSelectedIndex())+1;
paramsCombo.setEnabled(false);
allThebsParVals = [];
bsPanel.setInterruptFlag(0);

useRandomBox = bsPanel.getUseRandomBox();
randomPars = useRandomBox.isSelected();

for i = 1:numberOfLoops;
    
    problem = originalProblem;
    data = makeBsData(originalData);
    problem.data = data;
    if randomPars
        parVals = makeRandomPars(problem.fitconstr);
        problem.fitpars = parVals;    
    end
    setappdata(0,'problem',problem);
    e_fitcontrol;
    problem = getappdata(0,'problem');
    
    problem = unpackparams(problem);
    problem.data = originalData;
    setappdata(0,'problem',problem);
    reflectivity_calculation;
    problem = getappdata(0,'problem');
    
    jkSLDS{i} = problem.calculations.slds;
    jkRefs{i} = problem.calculations.reflectivity;
    jkChis(i) = problem.calculations.sum_chi;
    addSLDToBsPlot(problem.calculations.slds);
    howFar = (i/numberOfLoops)*100;
    awtinvoke(progressBar,'setValue',howFar);
    fitVals(i,:) = problem.fitpars';
    updateBsTable(fitVals,i,bestPars);
    
    
    allThebsParVals(i,:) = problem.fitpars';
   
    try
    dataSet.addObservation(problem.fitpars(selected));
    catch
        addInfoText('debug!');
    end
    
    interrupt = bsPanel.getInterruptFlag();
    if interrupt == 1
        break;
    end
end

paramsCombo.setEnabled(true);
setappdata(0,'problem',originalProblem);

bsResults.refs = jkRefs;
bsResults.SLDS = jkSLDS;
bsResults.pars = allThebsParVals;
bsResults.names = problem.fitNames;
bsResults.chis = jkChis;
bsResults.data = originalProblem.shifted_data;

setappdata(0,'bsResults',bsResults);
set(src,'Enabled',1);

%--------------------------------------------------------------------------

function addSLDToBsPlot(data)

coll = getappdata(0,'bsSLDCollection');
sldGraph = getappdata(0,'bsSLDGraphClass');

for n = 1:length(data)
    thisData = data{n};
    newSeries = sldGraph.mkXYSeries('');
    for i = 1:length(thisData(:,1))
        newSeries.add(thisData(i,1),thisData(i,2));
    end
    coll.addSeries(newSeries);
end

%--------------------------------------------------------------------------

function pars = makeRandomPars(ranges);

numberOfPars = size(ranges,1);

for i = 1:numberOfPars
    lb = ranges(i,1);
    ub = ranges(i,2);
    pars(i) = (rand*(ub-lb))+lb;
end

%--------------------------------------------------------------------------
    

function updateBsTable(parVals,nFits,bestPars);

for i = 1:size(parVals,2);
    sum = 0;
    for n = 1:nFits
       val = (parVals(n,i)-bestPars(i))^2;
       sum = sum + val;
    end
    Err(i) = 2*(sqrt((1/(nFits-1))*sum));
end

table = getappdata(0,'bsErrorTable');
tableModel = table.getModel();

for n = 1:size(parVals,2);
    tableModel.setValueAt(Err(n),n-1,2);
end



%--------------------------------------------------------------------------

function allData = makeBsData(origData)

for n = 1:length(origData)
    thisData = origData{n};
    NumDataPoints = size(thisData,1);
    data = [];
    for i = 1:NumDataPoints
        num = floor(rand*NumDataPoints);
        if num <1
            num = 1;
        elseif num > NumDataPoints
            num = NumDataPoints;
        end
        newRow = thisData(num,:);
        data(i,:) = newRow;
    end
    data = sortrows(data,1);
    allData{n} = data;
end

%--------------------------------------------------------------------------

function Data = trimDataToLimits(Data,problem);


number_of_contrasts = problem.numberOfContrasts;

for i = 1:number_of_contrasts;
    
    this_data = Data{i};
    xdata = this_data(:,1);
    
    lolimit = find(xdata < problem.fitlowrange(i));
    if isempty(lolimit)
        limits(1) = 1;
    else
        limits(1) = lolimit(end);
    end

    hilimit = find(xdata > problem.fithirange(i));
    if isempty(hilimit)
        limits(2) = length(this_data(:,1));
    else
        limits(2) = hilimit(1);
    end
    
    Data{i} = this_data(limits(1):limits(2),:);
end


    

