vals = load('testChain.mat');
chain = vals.chain;
close all

testDist = chain(:,1);

% % ***** statistics toolbox method ****
% % To use 'fitdist' we have to normalise
% % the histogram to between [0 1]
% maxValue = max(testDist);
% testDist = testDist ./ maxValue;
% 
% % Fit a kernel distribution to the data
% h = fitdist(testDist,'Beta');

data = randn(1,1000); %// example data

[N,edges] = histcounts(testDist, 'Normalization','pdf');
edges2 = edges(2:end) - (edges(2)-edges(1))/2;

figure(1)
N2 = smoothdata(N, 'sgolay');
plot(edges2, N2, 'r-', 'LineWidth', 2);
hold on

bar(edges2,N);


