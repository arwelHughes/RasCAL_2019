clear; 
clear java
import javax.swing.*

javaaddpath(fullfile(pwd,'dist','RasCALCharts_2019.jar'));
%javaaddpath('/home/arwel/Desktop/RasCAL/Sandbox/newPlotClasses');

problem = load('defaultProject.mat');
problem = problem.problem;
setappdata(0,'problem',problem);

bayes = load('d2oRun_bayes_nosigma.mat');
bayesResults = bayes.output;
close all force

myCharts = awtcreate('mlabMkChart_new');
setappdata(0,'myCharts',myCharts);
myFrame = JFrame();
myFrame.setSize(600,300);
myFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
panel = myFrame.getContentPane();

refChartPanel = mkReflectivityShadedChartPanel(bayesResults);
panel.add(refChartPanel);
myFrame.setVisible(true);