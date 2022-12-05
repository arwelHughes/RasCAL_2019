function parConfInts = prctileConfInts(chain)

CIFn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

parInts_95 = CIFn(chain,95);
parInts_65 = CIFn(chain,65);
parInts_25 = CIFn(chain,25);
parInts_mean = mean(chain);

% Note the transpose for all these to make them columns....
parConfInts.par95 = parInts_95';
parConfInts.par65 = parInts_65';
parConfInts.par25 = parInts_25';
parConfInts.mean = parInts_mean';

end