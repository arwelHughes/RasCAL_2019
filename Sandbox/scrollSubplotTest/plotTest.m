close all

figure(1); clf; hold on;

chain = load('debugChain.mat');
chain = chain.chain;

numberOfParams = size(chain,2);

for i = 1:numberOfParams
    scrollSubPlot(6,6,i);
    hist(chain(:,i),40);
end




