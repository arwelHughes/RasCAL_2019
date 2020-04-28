function [bestPars_max,posteriors] = makePosteriorPlots(output,params)


bayesHandles = getappdata(0,'bayesHandles');
figure(bayesHandles.hHists); clf; hold on

% msgBoxTest('waitbar','Plotting posteriors - please wait',[]);
% figure(bayesHandles.hHists);

problem = getappdata(0,'problem');

chain = output.chain;
numPars = size(chain,2);

rows = ceil(numPars/4);
cols = 3;
posteriors = cell(1,numPars);

for i = 1:numPars
    figure(bayesHandles.hHists);
    scrollSubPlot(3,4,i);

    [N,edges] = histcounts(chain(:,i), 'Normalization','pdf');
    edges2 = edges(2:end) - (edges(2)-edges(1))/2;
    N2 = smoothdata(N, 'sgolay');
    
    plot(edges2, N2, 'r-', 'LineWidth', 2);
    hold on
    
    bar(edges2,N,'w');
    thisName = params{i}{1};
    title(thisName);
    drawnow limitrate
    
    maxPos = find(N2 == max(N2));
    if length(maxPos) > 1; maxPos = mean(maxPos); end
    bestPars_max(i) = edges2(maxPos);  % Now maximum position on posterior fit, rather than mean.
    
    % Store the histograms and posteriors for eventual output
    thisPosterior.bins = edges2;
    thisPosterior.bincounts = N;
    posteriors{i} = thisPosterior;

    drawnow;
end

drawnow
%msgBoxTest('close',[],[]);

end 