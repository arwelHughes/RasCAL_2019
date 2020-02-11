%load back in
a = load('test1.mat');
out = a.output;

%data...
dat = out.data{1};
figure(10); clf; hold on
errorbar(dat(:,1),dat(:,2),dat(:,3),'b.');
set(gca,'YScale','log');

%ref...
ref = out.bestRefs{1};
plot(ref(:,1),ref(:,2));

%bounds
bounds = out.refBounds;
minBound = bounds{1};
maxBound = bounds{2};

plot(dat(:,1),minBound{1});
plot(dat(:,1),maxBound{1});

%put everything together..
all = [dat(:,1) dat(:,2) dat(:,3) ref minBound{:} maxBound{:}];

%[xdata ydata error fit_X fit_y minBnd_y maxBnd_y]