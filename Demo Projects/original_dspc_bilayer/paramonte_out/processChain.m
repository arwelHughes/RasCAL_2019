function [unscChain,fitNames] = processChain(problem)

% Split problem into structs..
controls = controlsDef();
[problemDef,problemDef_cells,problemDef_limits,priors,controls] = RatParseClassToStructs_new(problem,controls);

% Load the chain..
 chain = readtable('test_process_1_chain.txt');
 chain = chain(:,8:end);

% Covert table to array
ch = chain{:,:};

% Define cutoff...
chainTrim = 8000;
ch = ch(chainTrim:end,:);

% Pack the problem
[problemDef,fitNames] = packparams(problemDef,problemDef_cells,problemDef_limits,controls.checks);

% Unscale the problem
limits = problemDef.fitconstr;

for i = 1:size(ch,2)
    thisPar = ch(:,i);
    thisLimits = limits(i,:);
    thisUnscPar = (thisPar.*(thisLimits(:,2)-thisLimits(:,1)))+thisLimits(:,1);
                  (thisPar.*(thisLimits(:,2)-thisLimits(:,1)))+thisLimits(:,1);
    unscChain(:,i) = thisUnscPar;
end

end




