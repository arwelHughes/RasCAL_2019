function [myWindow, refChartPanel, sldChartPanel] = makePlottingWindow(problem)

myWindow = javaObjectEDT(PlottingWindow());
myCharts = javaObjectEDT(mlabMkChart_new);
myUtils = varTest();
errorbarCheck = javaObjectEDT(myWindow.getShowErrorBarsCheckBox());


setappdata(0,'myUtils',myUtils);
setappdata(0,'myCharts',myCharts);

if ~problem.eb
    refChartPanel = mkReflectivityChartPanel();
    errorbarCheck.setSelected(0);
else
    refChartPanel = mkReflectivityErrorbarChartPanel();
    errorbarCheck.setSelected(1);
end

sldChartPanel = mkSLDChartPanel();

%refPanel = javaObjectEDT(myWindow.getJPanel1());
refPanel = javaObjectEDT(myWindow.getReflectivityPanel());
refPanel.setLayout(java.awt.BorderLayout);
panelSize = refPanel.getSize();
refPanel.add(refChartPanel, java.awt.BorderLayout.CENTER);
refChartPanel.setSize(panelSize);

%sldPanel = javaObjectEDT(myWindow.getJPanel2());
sldPanel = javaObjectEDT(myWindow.getSldPanel);
sldPanel.setLayout(java.awt.BorderLayout());
panelSize = sldPanel.getSize();
sldPanel.add(sldChartPanel, java.awt.BorderLayout.CENTER);
sldChartPanel.setSize(panelSize);

slider = awtinvoke(myWindow,'getJSlider1');
awtinvoke(slider,'setValue',100);
handleSlider = handle(slider,'callbackproperties');
handleSlider = javaObjectEDT(handleSlider);
set(handleSlider,'StateChangedCallback',@sliderMove);

plotTypeCombo = awtinvoke(myWindow,'getPlotTypeJComboBox');
awtinvoke(plotTypeCombo,'setSelectedIndex',1);

dataTypeCombo = awtinvoke(myWindow,'getDataTypeJComboBox');
awtinvoke(dataTypeCombo,'setSelectedIndex',0);

%yMinTextField = awtinvoke(myWindow,'getYMinTextField');

%h = handle(yMinTextField,'CallbackProperties');set(h,'ActionPerformedCallback',@yMinSetCallback);

h = handle(plotTypeCombo,'CallbackProperties');set(h,'ActionPerformedCallback',@plotTypeChangedCallback);
h = handle(dataTypeCombo,'CallbackProperties');set(h,'ActionPerformedCallback',@dataTypeChangedCallback);
h = handle(errorbarCheck,'CallbackProperties');set(h,'ActionPerformedCallback',@errorBarsCheckChangedCallback);

%drawnow;

end
 
%__________________________________________________________________________

function sliderMove(src,ev)

%Hack to ignore any queued calls after slider finishes moving...
moving = get(src,'ValueIsAdjusting');
if moving == 1
    %drawnow limitrate;
    return
end

which = get(ev,'Source');
v = which.getValue;
problem = getappdata(0,'problem');

problem.dataShiftValue = -(v-100);

setappdata(0,'problem',problem);
updateTheGraphs;
desktop = getappdata(0,'desktop');
%desktop.repaint();
%drawnow limitrate;
awtinvoke(desktop,'repaint()');


end 
%________________________________________________________________________


function plotTypeChangedCallback(src,ev)

myCharts = getappdata(0,'myCharts');

whatSelected = get(src,'SelectedItem');
switch whatSelected
    case 'Linear'
        awtinvoke(myCharts,'setTheRefXAxisToLinear');
    case 'Logarithmic'
        awtinvoke(myCharts,'setTheRefXAxisToLog');
end


end
% ________________________________________________________________________

function dataTypeChangedCallback(src,ev);

myCharts = getappdata(0,'myCharts');

whatSelected = get(src,'SelectedItem');
switch whatSelected
    case 'Ref'
        turnOffQ4;
    case 'Ref * Q^4'
        turnOnQ4;
    case 'Fresnel'
        %turnOnFresnel;
        addInfoText('Not enabled yet');
        src.setSelectedIndex(0);
end

end
 %_________________________________________________________________________
        
% 
%  function yMinSetCallback(src,ev)
%  
%  javaStrvalue = src.getText();
%  mlabCharvalue = javaStrvalue.toCharArray';
%  value = str2num(mlabCharvalue);
%  
%  if ~isempty(value)
%      myCharts = getappdata(0,'myCharts');
%      myCharts.setTheLogRefYAxisMin(value);
%  end
%  
%  disp('debug');
%  
%  
%  end
    
        









