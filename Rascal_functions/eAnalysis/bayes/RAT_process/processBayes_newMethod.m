function [problemDef,outProblem,result,bayesResults] = processBayes_newMethod(bayesOutputs,problemDef)

%problem = {problemDef ; controls ; problemDef_limits ; problemDef_cells};
% problemDef = allProblem{1};
% controlsStruct = allProblem{2};
% problemDef_limits = allProblem{3};
% problemDef_cells = allProblem{4};

% Need to impose that we calculate the SLD..
% controlsStruct.calcSld = 1;

%... and use the Bayes bestpars
problemDef.fitpars = bayesOutputs.bestPars;
problemDef = unpackparams(problemDef,controlsStruct);
parConfInts = prctileConfInts(bayesOutputs.chain);   %iterShortest(output.chain,length(fitNames),[],0.95);

% % 2. Find maximum values of posteriors. Store the max and mean posterior 
% %    values, and calculate the best fit and SLD's from these.
% [bestPars_max,posteriors] = findPosteriorsMax(output.chain);
% bestPars_mean = output.results.mean;

% % Calulate Max best fit curves
% controls.calcSld = 1;
% problemDef.fitpars = bestPars_max;
% problemDef = unpackparams(problemDef,controls);
% [outProblem,result] = reflectivity_calculation_wrapper(problemDef,problemDef_cells,problemDef_limits,controls);
% bestFitMax_Ref = result(1);
% bestFitMax_Sld = result(5);
% bestFitMax_chi = outProblem.calculations.sum_chi;

% Calculate 'mean' best fit curves
% problemDef.fitpars = parConfInts.mean;
% problemDef = unpackparams(problemDef,controlsStruct);
[outProblem,result] = reflectivity_calculation_wrapper(problemDef,problemDef_cells,problemDef_limits,controlsStruct);
p = parseResultToStruct(outProblem,result);
bestFitMean.Ref = p.reflectivity;
bestFitMean.Sld = p.sldProfiles;
bestFitMean.chi = p.calculationResults.sum_chi;
bestFitMean.data = p.shifted_data;

% 2. Reflectivity and SLD shading

% predIntRef = mcmcpred_compile(output.results,output.chain,[],output.data,problem,500);
% predIntRef = predIntRef.predlims;
% 
% predIntSld_calcs = mcmcpred_compile_sld(output.results,output.chain,bestFitMean_Sld,[],output.data,problem,500);
% predIntSld = predIntSld_calcs.predlims;
% predIntSld_xdata = predIntSld_calcs.data;

allPredInts = refPrctileConfInts(bayesOutputs,problemDef,problemDef_cells,problemDef_limits,controlsStruct,result,parConfInts);


% ---------------------------------

bayesResults.bayesRes = bayesOutputs.results;
bayesResults.chain = bayesOutputs.chain;
bayesResults.s2chain = bayesOutputs.s2chain;
bayesResults.sschain = bayesOutputs.sschain;
bayesResults.bestPars_Mean = bayesOutputs.results.mean;
%bayesResults.bestPars_Max = bestPars_max;
%bayesResults.bayesData = bayesOutputs.data;
% bayesResults.bestFitsMax = {bestFitMax_Ref, bestFitMax_Sld, bestFitMax_chi};
bayesResults.bestFitsMean = bestFitMean;
bayesResults.predlims = allPredInts;
bayesResults.parConfInts = parConfInts;


end