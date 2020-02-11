function ret = makeHistsWindow(names,chain,numberOfParams,bayesHandles)


%Work out the subplot size;
% nWidth = 3;
% nHeight = ceil(numberOfParams/nWidth);
%figure(bayesHandles);
set(0, 'CurrentFigure', bayesHandles);

% rows = ceil(numberOfParams/3);

rows = ceil(numberOfParams/4);
cols = 4;

for i = 1:numberOfParams
    histHandles(i) = scrollSubPlot(3,3,i);
    if ~isempty(chain)
        histp(chain(:,i),30);
    end
    set(histHandles(i),'ytick',[]);
    title(sprintf('%s',names{i}))
end

ret = 'ok';

end