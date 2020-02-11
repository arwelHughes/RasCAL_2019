function vals = calcLimits(chain,numberOfParams,bestPars,predInt)


for par = 1:numberOfParams
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
    
    % Package everything for output
    vals(par,:) = [lowrange,highrange];
end

end