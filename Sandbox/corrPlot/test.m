clear all

% load in the bayesian analysis
out = load('results.mat');
out = out.out;
chain = out.chain;
res = out.res;
names = out.names;
bestFit = out.bestFitMax;


% preparitory stuff
numberOfParameters = length(bestFit);
numRows = numberOfParameters;
numCols = numberOfParameters;

figure(1); clf;hold on

[n,p] = size(chain);
inds = 1:1:numberOfParameters;

for j=2:p
  for i=1:j-1
    if p==2
      h=gca;
    else
      h=subplot(p-1,p-1,(j-2)*(p-1)+i);
    end
    plot(chain(:,i),chain(:,j),'.');
    if j~=p
      set(h,'xtick',[])
    end
    if i~=1
      set(h,'ytick',[])
    end
%     if i==1 & nargin>2 & ~isempty(names)
%       ylabel(names{j})
%     end
%     if i==j-1 & nargin>2 & ~isempty(names)
%       if p==2
%         %xlabel(names{i});
%       else
%         %title(names{i})
%       end
%     end
%     if nargin>1 & ~isempty(panelfun)
%       feval(panelfun,x(:,i),x(:,j),varargin{:});
%     end
  end   
end

