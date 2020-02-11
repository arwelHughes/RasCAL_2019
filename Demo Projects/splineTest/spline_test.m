function output = spline_test(params,bulk_in,bulk_out,contrast)
%SPLINE_TEST  RASCAL Custom XY Profile File.
%
%
% This file accepts 3 vectors containing the values for
% Params, bulk in and bulk out
% The m-file should cacluate an x/y SLD profile based on the
% input parameters. The output should be the calculated profile
% in the form...
%        output = [x(1) y(1)
%                  x{2} y(2)
%                  ....
%                  x(n) y(n)];
%      



st_val = bulk_in(contrast);
end_val = bulk_out(contrast);
range = params(1);

n_points = length(params)-1;

xx = 0:range;
step = range/(n_points+1);
x = [0:step:range]';
y_column = params(2:end);
y_column = y_column(:);
y = [st_val ; y_column ; end_val];
yy = spline(x,y,xx);

output = [xx(:) yy(:)];




