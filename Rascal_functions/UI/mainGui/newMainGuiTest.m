function newMainGuiTest();

import javax.swing.*;
import java.awt.*;

javaaddpath('C:\Gwaith2007\newRascal\Rascal2.3\Rascal_functions\UI\RascalClasses\');
javaaddpath('C:\Gwaith2007\newRascal\Rascal2.3\javaSources\mainGuiDetailsFrame\build\classes\');
javaaddpath('C:\Gwaith2007\newRascal\Rascal2.3\javaSources\mainGuiDetailsFrame\build\classes\swing-layout-1.0.jar');

a = load('dspc bilayer new type.mat');
problem = a.problem;

setappdata(0,'problem',problem);
setappdata(0,'paramsEditguiTableEditDetails',[]);

internalFrame = mainParamsGuiFrame();
mainPane = internalFrame.getJTabbedPane1();

%Add the relevant panels......
paramsPanel = mainGuiParamsPanelSetup();
layersPanel = mainLayersPanelSetup();
experimentParams = mainExpParamsSetup();

mainPane.addTab('Parameters',paramsPanel);
mainPane.addTab('Layers',layersPanel);
mainPane.addTab('Experimental Params',experimentParams);

allManiGuiContrastPanels = {[]};
for i = 1:problem.numberOfContrasts
    thisContrastPanel = mainGuiContrastPanelSetup(problem,i);
    allMainGuiContrastPanels{i} = thisContrastPanel;
    mainPane.addTab(sprintf('Contrast %d',i),thisContrastPanel);
end
    
%Show it....
desktop = JDesktopPane();
desktop.setSize(1000,8000);
desktop.setVisible(true);
desktop.add(internalFrame);
internalFrame.setVisible(true);

myFrame = JFrame();
myFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
myFrame.setSize(1000,8000);
myFrame.setResizable(false);
myFrame.getContentPane().add(desktop);
myFrame.setVisible(true);