problem = getappdata(0,'problem');
thisSLD = problem.calculations.slds{3};

gr = (gradient(thisSLD(:,2))).^2;

grr = [thisSLD(:,1),gr(:)];

figure(1)
clf
plot(grr(:,1),grr(:,2))

oldGrr = dlmread('dppc_grad.dat');

hold on
plot(oldGrr(:,1),oldGrr(:,2),'r-')