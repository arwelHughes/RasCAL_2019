function paramIntervals = confIntervals(chain, bestPars, predInt)

numberOfParams = size(chain,2);
type = 'iter';

% Work out the numerical shotest prediction intervals.
switch type
    case 'CDF'
        % (1) Use the CDF
        paramIntervals = calcLimits(chain,numberOfParams,bestPars,predInt);
    case 'iter'
        % (2) Use an iterative shortest interval
        paramIntervals = iterShortest(chain,numberOfParams,bestPars,predInt);
end


end
