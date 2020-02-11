%function makeNewBayesGui()
close all force;
%Make the main window to hold
%the tab group
tg = uitabgroup; %set(tg,'Visible','off');
mainFig = get(tg,'Parent');
set(mainFig,'NumberTitle','off','MenuBar','none','Position',[366 431 1069 503]);


%Create all the tabs for the relevant windows
%Main, Param values, Ref and SLD, posteriors, Diagnostics
tab_main = uitab(tg,'Title','Main');
tab_Params = uitab(tg,'Title','Param Values');
tab_ref = uitab(tg,'Title','Ref and SLD');
tab_post = uitab(tg,'Title','Posteriors');
tab_Diagnost = uitab(tg,'Title','Diagnostics');

%Populate the tabs with the relevant items.
%Do this by making (invisible) figures for
%each, then putting these into the tabs

%(1) 'Main' panel.
fig_tab_main = figure('Visible','on');
% frame_tab_main = get(gcf,'JavaFrame');
% frame_tab_main_jWindow = frame_tab_main.getFigurePanelContainer.getTopLevelAncestor;
% frame_tab_main_contentPane = frame_tab_main_jWindow.getContentPane;
panel = MainBayesPanel();
a = javacomponent(panel)

% frame_tab_main_contentPane.add(panel);
% panel.setVisible(true);

% mjf = get(handle(hFig), 'JavaFrame');
% jWindow = mjf.fHG2Client.getWindow;  % or: mjf.getAxisComponent.getTopLevelAncestor
%  
% % Get the content pane's handle
% mjc = jWindow.getContentPane;


%set(tg,'Visible','on');







%end