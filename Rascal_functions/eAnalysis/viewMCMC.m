function viewMCMC(fname,vars);

a = load(fname);

results = a.output;

chain = results.chain;
names = results.names;
params = results.params;


figure(11); clf; hold on
mcmcP1 = chain(:,vars(1));
mcmcP2 = chain(:,vars(2));
grey = [0.7 0.7 0.7];
h = plot(mcmcP2,mcmcP1,'.','Color',grey);


D = [mcmcP1(:) mcmcP2(:)];

[H,valsD1,valsD2] = hist3(D,15);

%Normalise the histogram to probability
dx = valsD1(2)-valsD1(1);
H = H./((sum(sum(H))/dx));
H = H./(max(max(H)));

[c,h] = contour(valsD1,valsD2,H,[0.1 0.35 0.75],'k-');
set(h,'LineWidth',2)

h1 = xlabel(names{vars(2)});
h2 = ylabel(names{vars(1)});

l1 = results.limits(vars(2),:);
l2 = results.limits(vars(1),:);


set(gca,'YLim',l2);
set(gca,'XLim',l1);

set(gca,'FontSize',20);
set(h1,'FontSize',20);
set(h2,'FontSize',20);


figure(12); clf; hold on
[n,x] = hist(mcmcP1,30);
bar(x,n,'w');%colormap(cool)
hh = xlabel(names{vars(1)})
set(gca,'FontSize',20);
set(hh,'FontSize',20);

figure(13); clf; hold on
[n,x] = hist(mcmcP2,30,'w');
bar(x,n,'w');%colormap(cool)
hh = xlabel(names{vars(2)})
set(gca,'FontSize',20);
set(hh,'FontSize',20);





disp('debug');

