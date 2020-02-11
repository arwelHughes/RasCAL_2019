function problem = scalePars(problem)


limits = problem.fitconstr;
vals = problem.fitpars;

scaled = (vals(:) - limits(:,1))./(limits(:,2)-limits(:,1));

problem.fitpars = scaled;
problem.unscaledPars = vals;

