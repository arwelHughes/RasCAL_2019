function problem = unscalePars(problem) 

limits = problem.fitconstr;
scaled = problem.fitpars;

for i = 1:length(scaled)
    unscaled(i) = (scaled(i).*(limits(i,2)-limits(i,1)))+limits(i,1);
end

problem.fitpars = unscaled;