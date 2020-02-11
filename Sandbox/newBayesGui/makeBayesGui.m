function makeBayesGui()
close all

% Use a normal Matlab figure for the GUI container
% so that this appears outside the main RasCAL GUI.
javaaddpath('/home/arwel/Desktop/RasCAL/javaSources/BayesGui/dist/BayesGui.jar');

mainBayesFig = figure;
set(mainBayesFig,'ToolBar','none','MenuBar','none');

tabGroup = uitabgroup(mainBayesFig);%,'Position',[0.05 0.05 0.3 0.8]);
mainTab = uitab(tabGroup,'Title','Main');
refSldTab = uitab(tabGroup,'Title','Fits');
paramTab = uitab(tabGroup,'Title','Parameters');
postTab = uitab(tabGroup,'Title','Posteriors');
corrTab = uitab(tabGroup,'Title','Correlations');
DiagnostTab = uitab(tabGroup,'Title','Diagnostics');

mainPanel = javaObjectEDT(MainBayesPanel);
javacomponent(mainPanel,java.awt.BorderLayout.NORTH,mainTab);

disp('Debug');


end


