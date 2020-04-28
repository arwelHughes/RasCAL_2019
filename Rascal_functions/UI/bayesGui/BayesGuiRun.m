function output = BayesGuiRun(src,ev)

bayesHandles = getappdata(0,'bayesHandles');

problem = getappdata(0,'problem');
oldProblem = problem;
problem = packparams(problem);
setappdata(0,'problem',problem);
setappdata(0,'oldProblem',oldProblem);

panel = getappdata(0,'mainBayesPanel');

nsimu = str2num(panel.getMcmcPointsBox().getText);
burnin = str2num(panel.getBurninTextBox().getText);
loop = str2num(panel.getRepeatRunsTextBox().getText);

%Now make the priors structure....
table = getappdata(0,'mainbayesBacksTable');
params = {};
rows = table.getRowCount();

% priors = problem.priors;
% for i = 1:length(priors)
%     allPriorNames{i} = priors{i,1}{1};
% end


for i = 1:rows
    name = table.getValueAt(i-1,0);
%     where = find(strcmp(allPriorNames,thisName))
%     if ~isempty(where)
%         thisRow = priors{where};
%     
%     %name = 
    val = table.getValueAt(i-1,1);
    min = table.getValueAt(i-1,2);
    max = table.getValueAt(i-1,3);
    mu = table.getValueAt(i-1,5);
    sig = table.getValueAt(i-1,6);
    thisRow = {name val min max mu sig};
    params{length(params)+1} = thisRow;
end

params = params(:);

% Run the analysis
output = runBayes(loop,nsimu,burnin,params);

% Make the posterior plots
[bestVals_max,posteriors] = makePosteriorPlots(output,params);
%bestVals_max = output.results.mean;

    
% Calculate the prediction intervals
[best, intervals] = calcMCMCstatRefErrors(output.results,output.chain,bestVals_max);
%[intervals,paramIntervals,best] = calcMCMCStatErrors_mcmcPred(output,problem);

% Make the reflectivity and SLD plots
msgBoxTest('waitbar','Plotting Reflectivities - please wait',[]);
makeRefSldIntervalPlots(intervals,bayesHandles.hRefs,problem,best,65)
msgBoxTest('close',[],[])
 
% Set the callbacks for the prediction interval
children = get(bayesHandles.hRefs,'children');
intervalCombo = findobj(children,'Tag','intervalCombo'); 
set(intervalCombo,'Value',2);
figUserData.intervals = intervals;
figUserData.hRefFigure = bayesHandles.hRefs;
figUserData.problem = problem;
figUserData.best = best;
set(intervalCombo,'Callback',@intervalChangedCallback,'UserData',figUserData);

% Make the params table
paramIntervals.intervals_95 = intervals.values_95;
paramIntervals.intervals_65 = intervals.values_65;
paramIntervals.intervals_25 = intervals.values_25;
updateBayesResultsTable(bestVals_max,paramIntervals,bayesHandles.hVals);

% Make the correlations plot
%makeCorrelationPlot(output.results,output.chain,bestVals_max,problem,bayesHandles.hCorr);
npars = length(problem.fitpars);
%chain = output.chain;
%msgBoxTest('waitbar','Plotting Correlations - please wait',[]);
pause(0.5)
%figure(bayesHandles.hCorr);
%makeCorrelationPlot_new(bayesHandles.hCorr,output.chain,npars,[],0,0)
%msgBoxTest('close',[],[]);

% Make the diagnsotics plot
%makeDiagnosticsPlot(output.res,output.chain,bestVals_max,problem,bayesHandles.hCorr);
%msgBoxTest('waitbar','Plotting Diagnostics - please wait',[]);
figure(bayesHandles.hDiag); clf
results = output.results;
mcmcplot(output.chain,[],results,'chainpanel');
%msgBoxTest('close',[],[]);

problem = oldProblem;
setappdata(0,'problem',problem);

% Now make the output structure
bayesOutput.posteriors = posteriors;
bayesOutput.bestFits = best;
bayesOutput.intervals = intervals;
bayesOutput.data = problem.shifted_data;
bayesOutput.MCMCoutput = output;

setappdata(0,'bayesOutput',bayesOutput);
setappdata(0,'bayesHasRun',true);


end


function intervalChangedCallback(source,event,a)

disp('box changed');

allOptions = source.String;
chosenOption = allOptions{source.Value};
intervals = source.UserData.intervals;
hRefFigure = source.UserData.hRefFigure;
problem = source.UserData.problem;
best = source.UserData.best;

switch chosenOption
    case '95%'
        predInt = 95;
    case '65%'
        predInt = 65;
    case '25%'
        predInt = 25;
end
            
makeRefSldIntervalPlots(intervals,hRefFigure,problem,best,predInt);

end