function makeMainBayesGui(output)

setappdata(0,'codeClose',0);
setappdata(0,'calcsRun',0);
chain = output.chain;
names = output.names;

if isdeployed
    desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    desktop.setGroupDocked('Figures',false);
end

%set(0,'DefaultFigureWindowStyle','docked');
bayeshandles.hMain = figure('Name','Main','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');%figure(1);
bayeshandles.hVals = figure('Name','Param Values','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');%figure(2); 
bayeshandles.hRefs = figure('Name','Ref and SLD','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');%figure(3); 
bayeshandles.hHists = figure('Name','Posteriors','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');%figure(4); 
%bayeshandles.hCorr = figure('Name','Correlations','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');%figure(5); 
bayeshandles.hDiag = figure('Name','Diagnostics','NumberTitle','off','CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none');

p = 0.1;

jFrame = get(handle(bayeshandles.hMain), 'JavaFrame');pause(p);
jFrame.fHG2Client.setClientDockable(true);
jFrame.fHG2Client.setClientWindowStyle(true,false);

jFrame = get(handle(bayeshandles.hVals), 'JavaFrame');pause(p)
jFrame.fHG2Client.setClientDockable(true);
jFrame.fHG2Client.setClientWindowStyle(true,false)

jFrame = get(handle(bayeshandles.hRefs), 'JavaFrame');pause(p);
jFrame.fHG2Client.setClientDockable(true);
jFrame.fHG2Client.setClientWindowStyle(true,false)

jFrame = get(handle(bayeshandles.hHists), 'JavaFrame');pause(p);
jFrame.fHG2Client.setClientDockable(true);
jFrame.fHG2Client.setClientWindowStyle(true,false)

jFrame = get(handle(bayeshandles.hDiag), 'JavaFrame');pause(p);
jFrame.fHG2Client.setClientDockable(true);
jFrame.fHG2Client.setClientWindowStyle(true,false)

setappdata(0,'codeClose',0)
setappdata(0,'bayesHandles',bayeshandles);

%pause(2)


bayesFig = figure(bayeshandles.hMain);
set(bayesFig,'MenuBar','none');
set(bayesFig,'ToolBar','none');
panel = MainBayesPanel();
javacomponent(panel,'North');
button = panel.getStartButton();
h = handle(button,'CallbackProperties');
set(h,'ActionPerformedCallback',@BayesGuiRun);

exitButton = panel.getQuitButton();
h = handle(exitButton,'CallbackProperties');
set(h,'ActionPerformedCallback',@BayesExit);

saveButton = panel.getExportButton;
h = handle(saveButton,'CallbackProperties');
set(h,'ActionPerformedCallback',@saveBayes);

bayesWaitbar = panel.getBayesProgressBar();
setappdata(0,'bayesWaitbar',bayesWaitbar);

bayesTextField = panel.getBayesTextArea();
setappdata(0,'bayesTextField',bayesTextField);

bayesProgLabel = panel.getProgLabel();
setappdata(0,'bayesProgLabel',bayesProgLabel);


numberOfParams = length(names);

%Histogram Window
ret = makeHistsWindow(names,chain,numberOfParams,bayeshandles.hHists);

%Ref and SLD windows.....
ret = makeRefAndSldWindow(output,bayeshandles.hRefs);

%Populate Main Window with relevant tables etc
mainTableScrollPane = panel.getMainTableScrollPane();
table = mainGuiTableSetup(output);
mainTableScrollPane.setViewportView(table);
setappdata(0,'mainBayesPanel',panel);

figure(bayeshandles.hMain);
set(bayeshandles.hMain,'Position',[616 440 967 72]);

desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
desktop.setGroupDocked('Figures',false);

end

function BayesExit(src,callbackdata)

setappdata(0,'codeClose',1);
setappdata(0,'bayesGuiOpen',false');
hbayes= getappdata(0,'bayesHandles');

close(hbayes.hMain);
close(hbayes.hVals);
close(hbayes.hRefs);
close(hbayes.hHists);
close(hbayes.hDiag);

end






function closeControl(src,callbackdata)

disp('Debug');
request = getappdata(0,'codeClose');
if request~=1
    delete(gcf);
    return
else
    delete(gcf)
end

end