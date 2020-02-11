function bayesExport(name,out);

save([name,'MCMCresults'],'out');
handles = out.handles;
mkdir(pwd,name);
cd(name);

RefsHandle = handles.Refs;
export_fig('Refs.png',4,'-transparent','-nocrop');

SLDsHandle = handles.SLDs;
export_fig('Slds.png',5,'-transparent','-nocrop');

tableHandle = handles.table;
export_fig('param_values.png',3,'-transparent','-nocrop');

histsHandle = handles.hists;
export_fig('hsits.png',2,'-transparent','-nocrop');

chainHandle = handles.chain;
export_fig('diagnsotics.png',1,'-transparent','-nocrop');

save('allFigHandles.mat','handles');

cd .. 

end



