clear all

prev = load('interimResults');
prev = prev.interim;

results = prev{1};
chain = prev{2};

parind = results.parind;
local = results.local;
theta = results.theta;
nsimu = size(chain,1);
nbatch = results.nbatch;

lims = [0.005 0.025 0.05 0.25 0.5 0.75 0.9 0.975 0.995];

sstype = 0;

nsample = size(chain,1);
isample = size(chain,1);

problem = getappdata(0,'problem');
datai = problem.shifted_data{1};

% for iisample = 1:nsample
%     theta(parind) = chain(isample(iisample),:)';
%     problem.fitpars = theta;
%     setappdata(0,'problem',problem);
%     reflectivity_calculation();
%     problem = getappdata(0,'problem');
%     
%     y = problem.calculations.reflectivity{1};
%     osave(iisample,:,:) = y + randn(size(y)*diag(sqrt(s2chain(isample(iisample),:)));
%     
%     
%     
%     
% end

