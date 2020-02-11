function [res,chain,bestVals_max,s2chain] = runFit_MCMCstat(loopNum, nsimu, priors)

%   Runs an MCMC analysis of a fit to a
%   D2O calibration using the MCMC stat.
%   Then, it optionally does a direct calculation of the
%   Posterior distributions on a grid
%   before numerically marginalising.
%   Plots the posteriors together for
%   comparison.

problem = getappdata(0,'problem');
fitpars = problem.fitpars;
fitNames = problem.fitNames;
limits = problem.fitconstr;
limits(1,1) = 0;

data = problem.data;

%data = problem;%.data;
   
% Make the params cell array
% From the mcmcstat docs
% it should look like this....
%
% PARAMS  theta structure
%   {  {'par1',initial, min, max, pri_mu, pri_sig, targetflag, localflag}
%      {'par2',initial, min, max, pri_mu, pri_sig, targetflag, localflag}
%      ... }

params = {};
for i = 1:length(fitNames)
    thisParam{1} = fitNames{i};
    thisParam{2} = fitpars(i);
    thisParam{3} = limits(i,1);
    thisParam{4} = limits(i,2);
    thisParam{5} = 0;
    thisParam{6} = Inf;
    params{i,1} = thisParam;
end

priors = {
    {4 -5e-7 2e-8} 
    {5 10 0.5}
    };


% Now go through and add any priors.....
for i = 1:length(priors)
    thisPrior = priors{i};
    priorNum = thisPrior{1};
    priorMu = thisPrior{2};
    priorSig = thisPrior{3};
    params{priorNum}{5} = priorMu;
    params{priorNum}{6} = priorSig;
end




options.method = 'dram';
options.nsimu = nsimu;%50000;
options.verbosity = 2;
options.adaptint = 500;
%options.burnin = burnin;

model.ssfun = @MCMC_Intrafun;

res = [];
for i = 1:loopNum
    [res,chain,s2chain,sschain] = mcmcrun(model, data, params, options, res);
end

% Plot the posteriors and posterior fits
figure(4); clf; hold on
numPars = length(fitNames);
rows = ceil(numPars/4);
cols = 4;
for i = 1:numPars
    subplot(rows,cols,i);
    %     [n,x] = hist(chain(:,i),30);
    %     n = n./ max(n);
    %     bar(x,n);
    [N,edges] = histcounts(chain(:,i), 'Normalization','pdf');
    edges2 = edges(2:end) - (edges(2)-edges(1))/2;
    N2 = smoothdata(N, 'sgolay');
    plot(edges2, N2, 'r-', 'LineWidth', 2);
    hold on
    bar(edges2,N);
    title(fitNames{i});
    maxPos = find(N2 == max(N2));
    if length(maxPos) > 1; maxPos = mean(maxPos); end
    bestVals_max(i) = edges2(maxPos);  % Now maximum position on posterior fit, rather than mean.
end

% This can be used to hard calculate the 
% posteriors. This can only be done for small numbers of parameters
% check = 0;
% if check
%     ng = 20;
%     roughness = linspace(1,7,ng);
%     background = linspace(5e-8,7e-6,ng);
%     scalefac = linspace(0.07,0.1,ng);
%     
%     problem = getappdata(0,'problem');
%     % data.problem = problem;
%     
%     for i = 1:ng
%         for j = 1:ng
%             for k = 1:ng
%                 pars = [roughness(i), background(j), scalefac(k)];
%                 
%                 %Method 1 --------------------------
%                 problem.fitpars = pars;
%                 problem = unpackparams(problem);
%                 val = fitfun(problem,pars);
%                 
%                 
%                 %
%                 %val = MCMC_Intrafun(pars,problem);
%                 val = val / -2;
%                 grid(i,j,k) = exp(val);
%             end
%         end
%     end
%     
%     fullgrid = grid;
%     
%     mask = [1 0 0];
%     for i = 1:3
%         if mask(i) == 0
%             grid = trapz(grid,i);
%         end
%     end
%     grid = squeeze(grid);
%     grid = grid / max(grid);
%     figure(4)
%     subplot(2,2,1); hold on;
%     plot(roughness,grid);
%     
%     
%     grid = fullgrid;
%     mask = [0 1 0];
%     for i = 1:3
%         if mask(i) == 0
%             grid = trapz(grid,i);
%         end
%     end
%     grid = squeeze(grid);
%     grid = grid / max(grid);
%     figure(4);
%     subplot(2,2,2); hold on;
%     plot(background,grid);
%     
%     grid = fullgrid;
%     mask = [0 0 1];
%     for i = 1:3
%         if mask(i) == 0
%             grid = trapz(grid,i);
%         end
%     end
%     grid = squeeze(grid);
%     grid = grid / max(grid);
%     figure(4);
%     subplot(2,2,3); hold on;
%     plot(scalefac,grid);
%     
% end

end

%-------------------------------------------------------
function ss = MCMC_Intrafun(pars,data)

problem = getappdata(0,'problem');

%First calculate chisquared
problem.fitpars = pars;
problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation();
problem = getappdata(0,'problem');
ss = problem.calculations.sum_chi;

end

%---------------------------------------------------------