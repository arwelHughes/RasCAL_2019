
rascalPath = '/home/arwel/Desktop/RasCAL/';

mdiPath = fullfile(rascalPath,'javaSources','newMDI','dist','newMDI.jar');
utilClassesPath = fullfile(rascalPath,'Rascal_functions','UI','RascalClasses','');
chartsPath = (fullfile(rascalPath,'Sandbox','newPlotClasses','RasCALCharts_2019','build','classes',''));
chartLibsPath = (fullfile(rascalPath,'Sandbox','newPlotClasses','RasCALCharts_2019','dist','lib'));
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