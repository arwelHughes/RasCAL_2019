function shadingtTest

addpath('/home/arwel/Desktop/RasCAL_release/Rascal_functions');

% Attempt to make new error shading codes
% based on central confidence interval.
clear all

%bayesResult = load('D2O_bayesOutput');
bayesResult = load('dspc_BayesOut.mat');
output = bayesResult.output;

p = load('dspc_problem');
problem = p.problem;
setappdata(0,'problem',problem)

chain = output.chain;
bestPars = output.bestPars;

% Calculate the best fit
problem.fitpars = bestPars;
problem = unpackparams(problem);
problem = reflectivity_calculation(problem);

bestFit = problem.calculations.reflectivity;
bestSld = problem.calculations.slds;

intervals = iterShortest_original(chain,size(chain,2),[],0.25); % Centred 95%


[refShadedIntervals, sldShadedIntervals, outMessage] = refPredInterval(chain, bestFit, bestSld, intervals);






% % get the first parameter
% figure(1); clf;
% posterior = chain(:,2);
% 
% % Plot the histogram
% [x,n] = hist(posterior,40);
% bar(n,x,1);
% hold on
% 
% % Add the best parameter from the MCMC
% yRange = get(gca,'YLim');
% xRange = get(gca,'XLim');
% thisPar = bestPars(1);
% 
% plot([thisPar thisPar],[yRange(1) yRange(2)],'r-','LineWidth',2);
% 
% % Try to find the iterative shortest 95% confidence
% % interval
% %intervals = shortestCentralInteval(posterior,thisPar,xRange);
% vals = iterShortest_original(chain,size(chain,2),[],0.95); % Centred 95%
% 
% % Make a new matrix for 'chain', drawing between the limits
% % for each parameter in vals
% nSample  = 500;
% %newChain = zeros(nSample,length(vals));
% for i = 1:size(vals,1)
%     thisRange = vals(i,:);
%     thisSample = (thisRange(2)-thisRange(1)).*rand(nSample,1) + thisRange(1);
%     newChain(:,i) = thisSample(:);
% end

% disp('debug');
% 
% thisSample = newChain(1,:);
% problem.fitpars = thisSample;
% problem = unpackparams(problem);
% problem = reflectivity_calculation(problem);
% 
%     minBound = min(allCalcsRef,[],2);
%     maxBound = max(allCalcsRef,[],2);

% Loop over all the samples in mewChain
% and calculate the reflectivity and SLD of
% each one.

end





function [refShadedIntervals, sldShadedIntervals, outMessage] = refPredInterval(chain, bestFit, bestSld, intervals, predInt)

debugPlot = true;
if debugPlot; figure(50); clf; hold on; end

outMessage = 'ok';

% Load in problem
problem = getappdata(0,'problem');
originalProblem = problem;
data = problem.shifted_data;

% Find out how many params and contrasts there are
numberOfParams = size(chain,2);
numberOfContrasts = problem.numberOfContrasts;

% We aim to make a dummy set of datasets drawn from within 
% the interval ranges.
nSamples = 500;
for i = 1:numberOfParams
   thisParInt = intervals(i,:); 
   thisSamp = (thisParInt(2)-thisParInt(1)).*rand(nSamples,1)+thisParInt(1);
   chainSample(:,i) = thisSamp;
end


% Loop over the number of contrasts
for n = 1:numberOfContrasts
    
    % Calulate the reflectivity for a randomly selected subset of the rows
    % that are in range. Use the xdata values from bestFit and interpolate
    % ydata from  all other ranges on to this.
    %
    % Get the xdata for the current contrast.
    xData = bestFit{n}(:,1);
    xDataSld = bestSld{n}(:,1);
    
    % Pre-allocation for memory management
    allCalcsRef = ones(length(xData),size(chainSample,1));
    allCalcsSld = ones(length(xDataSld),size(chainSample,1));
    
    % Loop over all rows in chainsample and
    % calculate the reflectivity and SLD
    for i = 1:size(chainSample,1)
        try
            thisRow = chainSample(i,:);
        catch
            disp('problem here!');
        end
        
        problem.fitpars = thisRow;
        problem = unpackparams(problem);
        setappdata(0,'problem',problem);
        reflectivity_calculation();
        problem = getappdata(0,'problem');
        
        % Get the calculated curves
        thisCalcRef = problem.calculations.reflectivity{n};
        thisInterpCalc = interp1(thisCalcRef(:,1),thisCalcRef(:,2),xData);
        allCalcsRef(:,i) = thisInterpCalc(:);
        
        thisCalcSld = problem.calculations.slds{n};
        thisInterpCalcSld = interp1(thisCalcSld(:,1),thisCalcSld(:,2),xDataSld);
        allCalcsSld(:,i) = thisInterpCalcSld(:);
        
    end
    
    % Find the minimum and maximum values in each row
    % of our calculated reflectivities.
    minBound = min(allCalcsRef,[],2);
    maxBound = max(allCalcsRef,[],2);
    
    minBound = [xData(:) minBound];
    maxBound = [xData(:) maxBound];
    
    %.. also do the same for SLD..
    minBoundSld = min(allCalcsSld,[],2);
    maxBoundSld = max(allCalcsSld,[],2);
    
    minBoundSld = [xDataSld(:) minBoundSld];
    maxBoundSld = [xDataSld(:) maxBoundSld];
    
    % Plot this if asked.
    if debugPlot
        figure(50); subplot(1,2,1); hold on
        c = colormap;
        
        if n>1
            mult = 10.^((n/100)*150);
        else
            mult=1;
        end
        
        thisData = data{n};
        if ~isempty(data)
            x = thisData(:,1);
            y = thisData(:,2) ./ mult;
            e = thisData(:,3) ./ mult;
            errorbar(x,y,e,'k.');
        end
    
        plot(minBound(:,1),minBound(:,2)./mult,'r-');
        plot(maxBound(:,1),maxBound(:,2)./mult,'r-');
        plot(bestFit{n}(:,1),bestFit{n}(:,2)./mult,'k-');
        set(gca,'YScale','log','XScale','log');
        
        subplot(1,2,2); hold on
        plot(minBoundSld(:,1),minBoundSld(:,2),'Color',c((n*5),:));
        plot(maxBoundSld(:,1),maxBoundSld(:,2),'Color',c((n*5),:));
        plot(bestSld{n}(:,1),bestSld{n}(:,2),'k-');
        
        
    end
    
    % store the results
    refShadedIntervals{n} = [xData(:) bestFit{n}(:,2) minBound(:,2) maxBound(:,2)];
    sldShadedIntervals{n} = [xDataSld(:) bestSld{n}(:,2) minBoundSld(:,2) maxBoundSld(:,2)];
    
    
    
    
    
    
    
end

% Re-set problem back to it's original state
setappdata(0,'problem',originalProblem);


end



