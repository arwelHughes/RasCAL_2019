function f = convstep(x,xw,xcen,s,h)
% Produces a step function convoluted with an error function
% Convstep [x,xw,xcen,s,h]
%       x = vector of x values
%      xw = Width of step function
%    xcen = Centre point of step function
%       s = Roughness parameter
%       h = Height of step function.


r = xcen + (xw/2);
l = xcen - (xw/2);

a = (x-l)./((2^0.5)*s);
b = (x-r)./((2^0.5)*s);

f = (h/2)*(erf(a)-erf(b));


