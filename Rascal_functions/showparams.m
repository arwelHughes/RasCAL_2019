function problem = displayparams(problem);

%Display the parameters in a pretty way.

for i = 1:length(problem.params);
    fprintf([problem.paramnames{i} ' : %e   (%e %e) \n'],problem.params(i),problem.constr(i,1),problem.constr(i,2));
end

