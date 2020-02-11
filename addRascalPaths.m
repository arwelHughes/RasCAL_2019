
rascalPath = getappdata(0,'rascalPath');
addpath(rascalPath);

% Add the function folders
rascalPaths = {fullfile('Rascal_functions','') ;
    fullfile('Rascal_functions','UI','editGui','');
    fullfile('Rascal_functions','UI','mainGui','');    
    fullfile('Rascal_functions','UI','bayesGui','');
    
    fullfile('Rascal_functions','Optim_algs','Cmaes','');
    fullfile('Rascal_functions','Optim_algs','Simplex','');
    fullfile('Rascal_functions','Optim_algs','mcs','gls','');
    fullfile('Rascal_functions','Optim_algs','mcs','minq5','');
    fullfile('Rascal_functions','Optim_algs','mcs','jones','');
    fullfile('Rascal_functions','Optim_algs','mcs','');
    fullfile('Rascal_functions','Optim_algs','DE','');
    fullfile('Rascal_functions','Optim_algs','new DE','');
    
    fullfile('Rascal_functions','Paratt','codegen','mex','callParatt');
    
    fullfile('Rascal_functions','eAnalysis','');
    fullfile('Rascal_functions','eAnalysis','bootStrap','');
    fullfile('Rascal_functions','eAnalysis','export_fig','');
    
    fullfile('Rascal_functions','eAnalysis','bayes');
    fullfile('Rascal_functions','eAnalysis','bayes','mcmcstat');
    fullfile('Rascal_functions','eAnalysis','bayes','bayesRefPlot');
    %    '/home/arwel/Desktop/RasCAL_release/Rascal_functions/eAnalysis/bayes/bayesRefPlot'


    %fullfile('Sandbox','mcmcStatDev','bayesRefPlot');
    %fullfile('Sandbox','mcmcStatDev');
    %fullfile('Sandbox','mcmcStatDev','mcmcstat');
    %fullfile('Sandbox','newTable');
    
    };

for i = 1:length(rascalPaths)
    addpath(fullfile(rascalPath,rascalPaths{i},''));
end


% Add Java paths
javaaddpath (fullfile(rascalPath,'javaSources','SplashWindow1','dist','SplashWindow1.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','openGenieWindow','JavaLibrary37','dist','openGenieWindow.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','mainGuiDetailsFrame','dist','mainGuiDetailsFrame.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','fitControlsPanel','dist','fitControlsPanel.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','BayesGui','dist','BayesGui.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','editProjectGui','dist','editProjectGui.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','JXLayer','filters.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','newMDI','dist','newMDI.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','newMatlabChartConstructs','newMatlabChartConstructs','dist','newMatlabChartConstructs.jar'));
%javaaddpath('/home/arwel/Desktop/oldRascalFiles/Rascal/javaSources/newMatlabChartConstructs/newMatlabChartConstructs/dist/newMatlabChartConstructs.jar');
javaaddpath (fullfile(rascalPath,'javaSources','RasCALTables','dist','RasCALTables.jar'));
javaaddpath (fullfile(rascalPath,'javaSources','JXLayer','jxlayer.jar'));
javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jfreechart-1.0.10.jar',''));
javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jcommon-1.0.13.jar'));
javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','swing-layout-1.0.jar'));
javaaddpath (fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','jfreechart-1.0.6-experimental.jar'));

