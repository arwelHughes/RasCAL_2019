function makeMainBayesGui(output)

chain = output.chain;
names = output.names;

addInfoText('Opening Bayes plugin.. please wait');

% if isdeployed
%     desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
%     desktop.setGroupDocked('Figures',false);
% end

desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
hContainer = desktop.addGroup('bayesGroup');
desktop.setGroupDocked('bayesGroup',false);

%set(0,'DefaultFigureWindowStyle','docked');
bayeshandles.hMain = figure('Name','Main','NumberTitle','off','CloseRequestFcn',@closeControl,...
    'ToolBar','none','MenuBar','none','Visible','off','UserData','DoNotClose');%figure(1);

bayeshandles.hVals = figure('Name','Param Values','NumberTitle','off',...
    'CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none','Visible','off','UserData','DoNotClose');%figure(2); 

bayeshandles.hRefs = refFig('Visible','off','CloseRequestFcn',@closeControl,...
    'UserData','DoNotClose','UserData','DoNotClose');%figure('Name','Ref and SLD','NumberTitle','off',,'ToolBar','none','MenuBar','none');%figure(3); 

bayeshandles.hHists = figure('Name','Posteriors','NumberTitle','off',...
    'CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none','Visible','off','UserData','DoNotClose');%figure(4); 

%bayeshandles.hCorr = figure('Name','Correlations','NumberTitle','off',...
%    'CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none','Visible','off','UserData','DoNotClose');%figure(5); 

bayeshandles.hDiag = figure('Name','Diagnostics','NumberTitle','off',...
    'CloseRequestFcn',@closeControl,'ToolBar','none','MenuBar','none','Visible','off','UserData','DoNotClose');

p = 0.1;
dock(bayeshandles.hMain,'bayesGroup'); pause(p);
dock(bayeshandles.hVals,'bayesGroup'); pause(p);
dock(bayeshandles.hRefs,'bayesGroup'); pause(p);
dock(bayeshandles.hHists,'bayesGroup'); pause(p);
%dock(bayeshandles.hCorr,'bayesGroup'); pause(p);
dock(bayeshandles.hDiag,'bayesGroup'); pause(p);
set(0,'CurrentFigure',bayeshandles.hMain);

setappdata(0,'codeClose',0)
setappdata(0,'bayesHandles',bayeshandles);

bayesFig = bayeshandles.hMain;
set(bayesFig,'MenuBar','none');
set(bayesFig,'ToolBar','none');
panel = MainBayesPanel();
javacomponent(panel,'North');
button = panel.getStartButton();
h = handle(button,'CallbackProperties');
set(h,'ActionPerformedCallback',@BayesGuiRun);
pause(p);

exitButton = panel.getQuitButton();
h = handle(exitButton,'CallbackProperties');
set(h,'ActionPerformedCallback',@BayesExit);

saveButton = panel.getExportButton;
h = handle(saveButton,'CallbackProperties');
set(h,'ActionPerformedCallback',@saveBayes);

continueButton = panel.getContinueButton;
h = handle(continueButton,'CallbackProperties');
%set(h,'ActionPerformedCallback',@continueBayes);

% bayesWaitbar = panel.getBayesProgressBar();
% setappdata(0,'bayesWaitbar',bayesWaitbar);

bayesTextField = panel.getBayesTextArea();
setappdata(0,'bayesTextField',bayesTextField);

% bayesProgLabel = panel.getProgLabel();
% setappdata(0,'bayesProgLabel',bayesProgLabel);


numberOfParams = length(names);

%Histogram Window
ret = makeHistsWindow(names,chain,numberOfParams,bayeshandles.hHists);

%Ref and SLD windows.....
%hRefFigure = refFig;
makeRefAndSldWindow(output,bayeshandles.hRefs);

% Also make the results window
bayesResultsFig = figure(bayeshandles.hVals);
resultsPanel = bayesResultsPanel();
javacomponent(resultsPanel,'North');

%Populate Main Window with relevant tables etc
mainTableScrollPane = panel.getMainTableScrollPane();
table = mainGuiTableSetup(output);
mainTableScrollPane.setViewportView(table);
setappdata(0,'mainBayesPanel',panel);

% .... also do the same with the main results panel
resultsTableScrollPane = resultsPanel.getMainResultsTableScrollPane();
table = mainBayesResultsTableSetup(output);
resultsTableScrollPane.setViewportView(table);
setappdata(0,'mainBayesResultsPanel',resultsPanel);

%figure(bayeshandles.hMain);
%set(bayeshandles.hMain,'Position',[616 440 967 72]);

% desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
% desktop.setGroupDocked('Figures',false);

desktop.setGroupDocked('bayesGroup',false);
desktop.showGroup('bayesGroup',true);
set(bayeshandles.hMain,'Visible','on');
set(bayeshandles.hVals,'Visible','on');
set(bayeshandles.hRefs,'Visible','on');
set(bayeshandles.hHists,'Visible','on');
%set(bayeshandles.hCorr,'Visible','on');
set(bayeshandles.hDiag,'Visible','on');

figure(bayeshandles.hMain);
bayesInfoText('Welcome to RasCAL Bayes plugin');

%disableMenus();
%lockMainGuiFrame();

end

function BayesExit(src,callbackdata)

setappdata(0,'codeClose',1);
setappdata(0,'bayesGuiOpen',false');
hbayes= getappdata(0,'bayesHandles');
problem = getappdata(0,'problem');

% Update the priors structure in
% problem to keep any changes
%Now make the priors structure....
table = getappdata(0,'mainbayesBacksTable');
params = {};
rows = table.getRowCount();

priors = problem.priors;
for i = 1:length(priors)
    allPriorNames{i} = priors{i,1}{1};
end

for i = 1:rows
    name = table.getValueAt(i-1,0);
    where = find(strcmp(allPriorNames,name));
    if ~isempty(where)
        %thisRow = priors{where};
        val = table.getValueAt(i-1,1);
        min = table.getValueAt(i-1,2);
        max = table.getValueAt(i-1,3);
        mu = table.getValueAt(i-1,5);
        sig = table.getValueAt(i-1,6);
        thisNewRow = {name val min max mu sig};
        priors{where} = thisNewRow;
    end
end

problem.priors = priors;

set(hbayes.hMain,'UserData','CloseOK');
set(hbayes.hVals,'UserData','CloseOK');
set(hbayes.hRefs,'UserData','CloseOK');
set(hbayes.hHists,'UserData','CloseOK');
%set(hbayes.hCorr,'UserData','CloseOK');
set(hbayes.hDiag,'UserData','CloseOK');

close(hbayes.hMain);
close(hbayes.hVals);
close(hbayes.hRefs);
close(hbayes.hHists);
%close(hbayes.hCorr);
close(hbayes.hDiag);

enableMenus();
unlockMainGuiFrame();
setappdata(0,'problem',problem);

end

function closeControl(src,callbackdata)

%disp('Debug');
status = get(src,'UserData');
if strcmpi(status,'DoNotClose')
    return
else
    delete(gcf)
end


end