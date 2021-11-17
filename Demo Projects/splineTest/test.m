
x = 1:100;
xw = 10;
xcen = 50;
s1 = 1;
s2 = 1;
h = 1;

f = asymconvstep(x,xw,xcen,s1,s2,h);





f = f*4e-6;

figure(1);
plot(x,f);