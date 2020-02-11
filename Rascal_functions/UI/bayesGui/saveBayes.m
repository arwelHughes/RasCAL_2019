function saveBayes(src,ev)

run = getappdata(0,'bayesHasRun');
if ~run
    bayesInfoText('Nothing to save!')
    return;
end

output = getappdata(0,'bayesOutput');
h = getappdata(0,'bayesHandles');

fname = inputdlg('Save name?');
fname = fname{:};

try
%     bayesInfoText('Saving Excel Workbook....')
%     bayesXlExport(fname);
    
    bayesInfoText('Saving Matlab binary...')
    save(char(fname),char('output'));
    
%     bayesInfoText('Saving Ref and SLD...');
%     export_fig(h.hRefs,[char(fname) '.png'],'-transparent','-nocrop');
%     
%     hhistFig =figure(100); clf; set(gcf,'Position',[401 14 1211 950]);
%     chain = output.chain;
%     results  = output.results;
%     mcmcplot(chain,[],results,'hist',30);
%     export_fig(100,[char(fname) '_posteriors.png'],'-transparent','-nocrop');
    
catch
    bayesInfoText(lasterr)
    return
end


bayesInfoText('OK...');
