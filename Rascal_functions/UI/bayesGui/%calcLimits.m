%--------------------------------------------------------------------------


function vals = calcLimits(chain,bestPars,predInt)

numPars = length(bestPars);
vals = zeros(numPars,2);

for par = 1:numPars;
    postvals = chain(:,par);

    % histogram the data to get the distribution
    [n, bins] = hist(postvals, length(postvals));
    maxn = mean(find(n==max(n)));
    
    % get the cumulative probability distribution as normalise it
    cs = cumsum(n)/length(postvals);

    % the probability covered by Nsigma 
    probarea = predInt;

    % get unique values of the cdf 
    [csu, iu, ju] = unique(cs);

    % get lower bound on the interval
    lowrange = interp1(csu, bins(iu), 0.5-(probarea/2));

    % get upper bound on the interval
    highrange = interp1(csu, bins(iu), 0.5+(probarea/2));
%     means(par) = mean(postvals);
%     low_ranges(par) = lowrange;
%     hi_ranges(par) = highrange;
    vals(par,:) = [lowrange,highrange];
end

end

%--------------------------------------------------------------------------