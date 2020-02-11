function [ref, intervals] = calcMCMCstatRefErrors(res,chain,bestFitMax)

%  Calculates fits and confidence intervals
%  of the results of runing MCMC stat
problem = getappdata(0,'problem');
problem.calcSLD = 1;
setappdata(0,'problem',problem);

boxHandle = msgBoxTest('waitbar','Calculating prediction intervals....',[]);
currentValue = 0;

% 1. Best Fit
%
% In the case of mcmcstat, the best fits are
% given in res.mean. But we also have the option
% of using the max posterior position.
% Need to calculate the fits and SLD's 
% associated with this best-fit.
type = 'max';

switch type
    case 'max'
        bestFitPars = bestFitMax;
    otherwise
        bestFitPars = res.mean;
end
%originalFitpars = problem.fitpars;
problem.fitpars = bestFitPars;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');
ref.bestFits = problem.calculations.reflectivity();
ref.bestSlds = problem.calculations.slds;
%problem.fitpars = originalFitpars;

% Work out the confidence intervals of
% each of the distributions 
predInt = 0.95; %95% confidence intervals
intervals_95 = confIntervals(chain,bestFitPars,predInt);


predInt = 0.65; %65% confidence intervals
intervals_65 = confIntervals(chain,bestFitPars,predInt);


predInt = 0.25; %25% confidence intervals
intervals_25 = confIntervals(chain,bestFitPars,predInt);


% Now calculate the shaded prediction intervals
% This is wasteful as it ends up calculating many 
% Curves three times. Will be replaced.
disp('Calculating 95% predicion intervals..'); 
msgBoxTest('message','Calculating 95% prediction Intervals...');
valRange = [0.0 0.33];
[refErr_95, sldErr_95, outMessage_95, boxEndValue] = refPredInterval_2(chain,ref.bestFits,ref.bestSlds,intervals_95,boxHandle,valRange);
%msgBoxTest('update','',0.33);

disp('Calculating 65% predicion intervals..');
valRange = [0.33 0.66];
msgBoxTest('message','Calculating 95% prediction Intervals...');
[refErr_65, sldErr_65, outMessage_65, boxEndValue] = refPredInterval_2(chain,ref.bestFits,ref.bestSlds,intervals_65,boxHandle,valRange);
%msgBoxTest('update','',0.66);

disp('Calculating 25% predicion intervals..');
msgBoxTest('message','Calculating 95% prediction Intervals...');
valRange = [0.66 1.0];
[refErr_25, sldErr_25, outMessage_25,boxEndValue] = refPredInterval_2(chain,ref.bestFits,ref.bestSlds,intervals_25,boxHandle,valRange);
%msgBoxTest('update','',1);

% Put all results in one struct for output
intervals.refShading_95 = refErr_95;
intervals.values_95 = intervals_95;
intervals.sldShading_95 = sldErr_95;
intervals.message_95 = outMessage_95;

intervals.refShading_65 = refErr_65;
intervals.values_65 = intervals_65;
intervals.sldShading_65 = sldErr_65;
intervals.message_65 = outMessage_65;

intervals.refShading_25 = refErr_25;
intervals.values_25 = intervals_25;
intervals.sldShading_25 = sldErr_25;
intervals.message_25 = outMessage_25;

disp('debug');
msgBoxTest('close',[],[]);



