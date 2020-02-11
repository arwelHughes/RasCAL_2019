%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vert3.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [x1,x2,f1,f2] = vert3(j,x0,f0,L,x1,x2,f1,f2)
% subprogram called by vertex.m

function [x1,x2,f1,f2] = vert3(j,x0,f0,L,x1,x2,f1,f2)
if j == 1
  k1 = 2;
  k2 = 3;
elseif j == L
  k1 = L - 2;
  k2 = L - 1;
else
  k1 = j - 1;
  k2 = j + 1;
end
x1 = x0(k1);
x2 = x0(k2);
f1 = f1 + f0(k1);
f2 = f2 + f0(k2);
