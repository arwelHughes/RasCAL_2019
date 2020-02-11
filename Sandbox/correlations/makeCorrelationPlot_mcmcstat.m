function makeCorrelationPlot(res,chain,bestFit,problem,corrFigHandle)

% preparitory stuff
numberOfParameters = length(bestFit);

figure(corrFigHandle); clf;hold on

[n,p] = size(chain);
inds = 1:1:numberOfParameters;

names = problem.fitNames;

for j=2:p
  for i=1:j-1
    if p==2
      h=gca;
    else
      h=subplot(p-1,p-1,(j-2)*(p-1)+i);
    end
    % Use only parst of the chain
    thisParx = chain(:,i);
    thisPary = chain(:,j);
    selectIndex = randi(length(thisParx),100,1);
    
    plotParX = thisParx(selectIndex);
    plotParY = thisPary(selectIndex);
    
    plot(plotParX,plotParY,'.');
    if j~=p
      set(h,'xtick',[])
    end
    if i~=1
      set(h,'ytick',[])
    end
    if i==1 & nargin>2 & ~isempty(names)
      ylabel(names{j})
    end
    if i==j-1 & nargin>2 & ~isempty(names)
      if p==2
        xlabel(names{i});
      else
        title(names{i})
      end
    end
  end   
end

end