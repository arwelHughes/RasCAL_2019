function output = runBayes(loop,nsimu,burnin,params)

% Clear any values from previous runs if prsent
clear model data options

problem = getappdata(0,'problem');
problem.calcSLD = 0;
problem = packparams(problem);

% fitpars = problem.fitpars;
% fitNames = problem.fitNames;
% limits = problem.fitconstr;

data = problem.data;

options.method = 'dram';
options.nsimu = nsimu;%50000;
options.verbosity = 1;
options.adaptint = 500;
options.burnintime = burnin;

model.ssfun = @MCMC_Intrafun;

res = [];
for i = 1:loop
    bayesInfoText(sprintf('Running loop %d of %d',i,loop));
    [res,chain,s2chain,sschain] = mcmcrun(model, data, params, options, res);
end

output.res = res;
output.chain = chain;
output.s2chain = s2chain;
output.sschain = sschain;


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
