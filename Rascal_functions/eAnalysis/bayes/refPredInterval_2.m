function [refShadedIntervals, sldShadedIntervals, outMessage, boxEndValue] = refPredInterval(chain, bestFit, bestSld, intervals,msgBox,valRange)

debugPlot = false;
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

% value range for progress box
minVal = valRange(1);
maxVal = valRange(2);
msgBoxTest('update','',minVal);

range = maxVal - minVal;
increment = 1/((numberOfContrasts * nSamples)/range);
currentVal = minVal;

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
        % setappdata(0,'problem',problem);
        problem = reflectivity_calculation(problem);
        % problem = getappdata(0,'problem');
        
        % Get the calculated curves
        thisCalcRef = problem.calculations.reflectivity{n};
        thisInterpCalc = interp1(thisCalcRef(:,1),thisCalcRef(:,2),xData);
        allCalcsRef(:,i) = thisInterpCalc(:);
        
        thisCalcSld = problem.calculations.slds{n};
        thisInterpCalcSld = interp1(thisCalcSld(:,1),thisCalcSld(:,2),xDataSld);
        allCalcsSld(:,i) = thisInterpCalcSld(:);
        
        msgBoxTest('update','',currentVal);
        currentVal = currentVal + increment;
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
        figure(50);
        
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
    end
    
    % store the results
    refShadedIntervals{n} = [xData(:) bestFit{n}(:,2) minBound(:,2) maxBound(:,2)];
    sldShadedIntervals{n} = [xDataSld(:) bestSld{n}(:,2) minBoundSld(:,2) maxBoundSld(:,2)];
    
end

% Re-set problem back to it's original state
setappdata(0,'problem',originalProblem);
boxEndValue = currentVal;

end