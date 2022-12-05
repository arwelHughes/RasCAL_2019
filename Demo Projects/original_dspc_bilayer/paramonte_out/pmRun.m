


pmPars.scalefactor = 1e-2;
pmPars.name = 'ParamonteRun_2';
pmPars.chainSize = 50000;
pmPars.chainTrim = 10000;

problem = load('problem'); problem = problem.problem;

problem.setUsePriors(true);
problem.setParamPrior('SAM head thick','gaussian',11,3);
problem.setParamPrior('SAM head hydration','gaussian',30,3);
problem.setParamPrior('Bilayer head thick','gaussian',11,3);
problem.setParamPrior('Bilayer heads hydr','gaussian',30,3);

[problem,results] = RAT_runParamonte(problem,controls,pmPars);