function picsExport(name);

handles = load('allFigHandles.mat');
handles = handles.handles;
mkdir(pwd,name);

cd(name);

RefsHandle = handles.Refs;
set(RefsHandle, 'Position', get(0,'Screensize'));
n = [name '_mcmcReport.pdf'];
export_fig(n,RefsHandle,'-transparent','-nocrop');
export_fig('Refs.png',RefsHandle,'-transparent','-nocrop');

SLDsHandle = handles.SLDs;
set(SLDsHandle, 'Position', get(0,'Screensize'));
n = [name '_mcmcReport.pdf'];
export_fig(n,SLDsHandle,'-append','-nocrop');
export_fig('Slds.png',SLDsHandle,'-transparent','-nocrop');

histsHandles = handles.hists;
histNames = {}
for i = 1:length(histsHandles);
    thisName = sprintf('hists%d.png',histsHandles(i));
    set(histsHandles(i), 'Position', get(0,'Screensize'));
    export_fig(thisName,histsHandles(i),'-transparent','-nocrop');
    export_fig(n,histsHandles(i),'-append','-nocrop');
    histNames{i} = thisName;
end

%set(handles.table, 'Position', get(0,'Screensize'));
export_fig('param_values.png',handles.table,'-transparent','-nocrop');
export_fig(n,handles.table,'-append');

% corrHandles = handles.Correlations;
% corrNames = {}
% for i = 1:length(corrHandles);
%     thisName = sprintf('correlations%d.png',i);
%     set(corrHandles(i), 'Position', get(0,'Screensize'));
%     export_fig(thisName,corrHandles(i),'-transparent','-nocrop');
%     export_fig(n,corrHandles(i),'-append','-nocrop');
%     corrNames{i} = thisName;
% end

save('allFigHandles.mat','handles');

cd .. 

%publish(makeOutput)

end


%--------------------------------------------------------

function makeOutput

handles = load('allFigHandles.mat');
handles = handles.handles;



%%Fits and SLD's
%
%<<fitsSLDs.png>>

%%Parameters


end


