function f = Asymconvstep(x,xw,xcen,s1,s2,h);
% Produces a step function convoluted with differnt error functions
% on each side.
% Convstep (x,xw,xcen,s1,s2,h)
%       x = vector of x values
%      xw = Width of step function
%    xcen = Centre point of step function
%       s1 = Roughness parameter of left side
%       s2 = Roughness parameter of right side
%       h = Height of step function.




r = xcen + (xw/2);
l = xcen - (xw/2);

a = (x-l)./((2^0.5)*s1);
b = (x-r)./((2^0.5)*s2);

%f = (h/2)*(Faddeeva_erf(a)-Faddeeva_erf(b));
f = (h/2)*(erf(a)-erf(b));


