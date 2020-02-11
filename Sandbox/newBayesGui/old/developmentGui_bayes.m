
function developmentGui_bayes()

import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JSeparator;
import javax.swing.JMenuBar;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import java.awt.BorderLayout;

%rascalPath = 'home/arwel/Desktop/RasCAL';

% %javaaddpath (fullfile(rascalPath,'javaSources','SplashWindow1','build','classes',''));
% javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses',''));
% %javaaddpath (fullfile(rascalPath,'javaSources','mainGuiDetailsFrame','build','classes',''));
% %javaaddpath (fullfile(rascalPath,'javaSources','fitControlsPanel','build','classes',''));
% %javaaddpath (fullfile(rascalPath,'javaSources','BayesGui','build','classes',''));
% %javaaddpath (fullfile(rascalPath,'javaSources','editProjectGui','dist','editProjectGui.jar'));
% %javaaddpath (fullfile(rascalPath,'javaSources','editProjectGui','dist','Filters.jar'));
% javaaddpath('/home/arwel/Desktop/RasCAL/javaSources/newMDI/dist/newMDI.jar');
% javaaddpath (fullfile(rascalPath,'javaSources','newMatlabChartConstructs','newMatlabChartConstructs','build','classes',''));
% %javaaddpath (fullfile(rascalPath,'javaSources','JXLayer','jxlayer.jar'));
% %javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jfreechart-1.0.10.jar',''));
% %javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jcommon-1.0.13.jar'));
% %javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','swing-layout-1.0.jar'));
% %javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jfreechart-1.0.6-experimental.jar'));
% javaaddpath(fullfile(rascalPath,'Sandbox','newPlotClasses','RasCALCharts_2019','dist','RasCALCharts_2019,jar'));
% javaaddpath(fullfile(rascalPath,'Sandbox','errorAnalysisPanels','errorAnalysisPanels','dist','errorAnalysisPanels.jar'));

rascalPath = '/home/arwel/Desktop/RasCAL/';

mdiPath = fullfile(rascalPath,'javaSources','newMDI','dist','newMDI.jar');
utilClassesPath = fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','');
chartsPath = (fullfile(rascalPath,'Sandbox','newPlotClasses','RasCALCharts_2019','build','classes',''));    % Not sure why I need
chartLibsPath = (fullfile(rascalPath,'Sandbox','newPlotClasses','RasCALCharts_2019','dist','lib'));         % two imports here....
errorPanelsPath = (fullfile(rascalPath,'Sandbox','errorAnalysisPanels','errorAnalysisPanels','build','classes'));

chartLibs = {'hamcrest-core-1.3.jar'...
    'jfreechart-1.0.10.jar',...
    'swing-layout-1.0.4.jar',...  
    'jcommon-1.0.13.jar',...
    'junit-4.13-beta-3.jar'};   

for n = 1:length(chartLibs)
    libPath = fullfile(chartLibsPath,chartLibs{n});
    javaaddpath(libPath);
end

javaaddpath(mdiPath);
javaaddpath(utilClassesPath);
javaaddpath(chartsPath);
javaaddpath(errorPanelsPath);

frame = JFrame('Rascal Blank Development Gui');
frame.setSize(700,700);
desktop = MDIDesktopPane();
desktop.setBackground(javax.swing.plaf.ColorUIResource(0.5,0.5,0.65));
desktop.setPreferredSize(java.awt.Dimension(1390,888));

frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

scrollpane = JScrollPane();
v = scrollpane.getViewport();
v.add(desktop);

cp = frame.getContentPane();
layout = BorderLayout();
cp.setLayout(layout);
cp.add(scrollpane,BorderLayout.CENTER);
%frame.setExtendedState(JFrame.MAXIMIZED_BOTH);

BayesFrame = awtcreate('MainBayesFrame');
desktop.add(BayesFrame);
BayesFrame.setSize(BayesFrame.getPreferredSize)
BayesFrame.setVisible(true);
BayesFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

BayesFrame = makeBayesFrameContent(BayesFrame);

frame.setSize(desktop.getPreferredSize());
frame.show;

setappdata(0,'desktop',desktop);
setappdata(0,'mainFrame',frame);
setappdata(0,'BayesFrame',BayesFrame);




end
