function fval = hpso_fun(x,problem,itercount);
% transform variables, then call original function

%Unpck the params..
for i = 1:size(x,1);
    problem.fitpars = x(i,:);
    problem = unpackparams(problem);

% and call fun
%problem = feval(params.fun,problem,params.args{:});
    update = 1;
    setappdata(0,'problem',problem);
    reflectivity_calculation();
    problem = getappdata(0,'problem');
    if  rem(itercount,update) == 0
        rJavaUpdatePlots();
        if problem.update_params == 1;
           update_params();
        end
    end
    fval(i) = problem.calculations.sum_chi;
end
