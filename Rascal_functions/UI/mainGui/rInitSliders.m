function rInitSliders(src,ev);

import javax.swing.*;
import java.awt.*;

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

UndoRedoSetup(problem);

problem = updateChecksStatus(problem);
out = checkBounds(problem);
if strcmp(out{1},'fail')
    return
end

setappdata(0,'slidersOldProblem',problem);

sliderWindow = slidersWindow();
slidersScrollPane = sliderWindow.getJSliderScrollPane();
slidersOKButton = sliderWindow.getJSliderOkButton();
slidersCancelButton = sliderWindow.getJSliderCancelButton();

sliderWindow.setMaximizable(false);
sliderWindow.setClosable(false);

hOkButton = handle(slidersOKButton,'CallbackProperties');
set(hOkButton,'ActionPerformedCallback',@slWinClose);
set(slidersCancelButton,'ActionPerformedCallback',@slWinCancel);

paramsChecks = paramsTableGetChecked();
backsChecks = backsTableGetChecked();
scalesChecks = scalesTableGetChecked();
shiftsChecks = shiftsTableGetChecked();
airsChecks = nbairsTableGetChecked();
subsChecks = nbsubsTableGetChecked();
resolChecks = resolutionTableGetChecked();

numberOfSliders = length(find(paramsChecks)) + ...
     length(find(backsChecks)) + ...
     length(find(scalesChecks)) + ...
     length(find(shiftsChecks)) + ...
     length(find(airsChecks)) + ...
     length(find(subsChecks)) + ...
     length(find(resolChecks));

types = [];
for i = 1:length(find(paramsChecks));
    types = [types 'p'];
end
for i = 1:length(find(backsChecks))
    types = [types 'b'];
end
for i = 1:length(find(scalesChecks))
    types = [types 's'];
end
for i = 1:length(find(shiftsChecks))
    types = [types 'h'];
end
for i = 1:length(find(airsChecks))
    types = [types 'a'];
end
for i = 1:length(find(subsChecks))
    types = [types 'u'];
end
for i = 1:length(find(resolChecks))
    types = [types 'r'];
end
 
%Debug
setappdata(0,'types',types);

paramsNames = problem.paramnames(find(paramsChecks));
allbacksNames = problem.backsNames;
backsNames = allbacksNames(find(backsChecks));
allscalesNames = problem.scalesNames;
scalesNames = allscalesNames(find(scalesChecks));
allshiftsNames = problem.shiftsNames;
shiftsNames = allshiftsNames(find(shiftsChecks));
allairsNames = problem.nbaNames;
airsNames = allairsNames(find(airsChecks));
allsubsNames = problem.nbsNames; 
subsNames = allsubsNames(find(subsChecks));
allresolNames = problem.resolNames;
resolNames = allresolNames(find(resolChecks));
allNames = [paramsNames backsNames scalesNames shiftsNames airsNames subsNames resolNames];

paramsConstr = problem.constr(find(paramsChecks),:);
backsConstr = problem.backs_constr(find(backsChecks),:);
scalesConstr = problem.scale_constr(find(scalesChecks),:);
shiftsConstr = problem.shifts_constr(find(shiftsChecks),:);
airsConstr = problem.nbairs_constr(find(airsChecks),:);
subsConstr = problem.nbsubs_constr(find(subsChecks),:);
resolConstr = problem.resolution_constr(find(resolChecks),:);
allConstr = [paramsConstr ; backsConstr ; scalesConstr ; shiftsConstr ; airsConstr ; subsConstr ; resolConstr];

paramsVals = problem.params(find(paramsChecks));
backsVals = problem.backs(find(backsChecks));
scalesVals = problem.scalefac(find(scalesChecks));
shiftsVals = problem.shifts_horisontal(find(shiftsChecks));
airsVals = problem.nba(find(airsChecks));
subsVals = problem.nbs(find(subsChecks));
resolVals = problem.resolution(find(resolChecks));
allVals = [paramsVals backsVals scalesVals shiftsVals airsVals subsVals resolVals];

allSliders = {};
slPanel = JPanel();
numberOfRows = ceil(numberOfSliders/3);
layout = GridLayout(numberOfRows,3);
slPanel.setLayout(layout);
thisRow = 1;
thisCol = 1;

for n = 1:numberOfSliders;
    allSliders{n} = makeSlider(allNames{n},allConstr(n,1),allConstr(n,2),allVals(n),n,types(n));
    slPanel.add(allSliders{n});
    thisCol = thisCol + 1;
end

slidersScrollPane.setViewportView(slPanel);

desktop.add(sliderWindow);
mainGuiWindow = getappdata(0,'mainGuiFrame');
mainGuiWindow.setVisible(false);
whereMainGui = getappdata(0,'mainGuiPlace');
sliderWindow.setLocation(mainGuiWindow.getLocation);
sliderWindow.setSize(mainGuiWindow.getSize);
sliderWindow.setVisible(true);


setappdata(0,'slidersWindow',sliderWindow);


%--------------------------------------------------------------------------

function s = makeSlider(title,min,max,val,tag,type);
import javax.swing.*;
import java.awt.*;
import java.util.*;

myTable = Hashtable();

step = (max-min)/10;
thisVal = min;
for i = 0:10:100;
    if (thisVal < 0.001 | thisVal > 1000)
        thisLabel = sprintf('%4.3g',thisVal);
    else
        thisLabel = sprintf('%6.3g',thisVal);
    end
    myTable.put(uint32(i),JLabel(thisLabel));
    thisVal = thisVal + step;
end


scaledVal = ((val-min)/(max-min))*100;
s = JSlider(JSlider.VERTICAL,0,100,scaledVal);
s.setBorder(BorderFactory.createTitledBorder(title));
s.setMajorTickSpacing(10);
s.setLabelTable(myTable);
s.setPaintTicks(true);
s.setPaintLabels(true);
s.setToolTipText(num2str(val));
hs = handle(s, 'CallbackProperties');
set(hs,'StateChangedCallback',@sliderCallback);
% set(s,'Interruptible','off');
% set(s,'BusyAction','cancel');
sliderPars.tag = tag;
sliderPars.min = min;
sliderPars.max = max;
sliderPars.name = title;
sliderPars.type = type;
setappdata(s,'UserData',sliderPars);

%--------------------------------------------------------------------------

function sliderCallback(src,ev);

problem = getappdata(0,'problem');

%Hack to ignore any queued calls after slider finishes moving...
moving = get(src,'ValueIsAdjusting');
if (strcmp(moving,'off') == 1)
    return
end

which = get(ev,'Source');
details = get(which);



thisSlider = getappdata(which, 'UserData');
what = thisSlider.name;
type = thisSlider.type;
max = thisSlider.max;
min = thisSlider.min;    
value = which.getValue;
trueValue = ((value/100)*(max-min))+min;
%disp(what)   %debug
switch type
    case 'p'
        numberPosition = find(strcmp(what,problem.paramnames));
        problem.params(numberPosition) = trueValue;
    case 'b'
        numberPosition = find(strcmp(what,problem.backsNames));
        problem.backs(numberPosition) = trueValue;
    case 's'
        numberPosition = find(strcmp(what,problem.scalesNames));
        problem.scalefac(numberPosition) = trueValue;
    case 'h'
        numberPosition = find(strcmp(what,problem.shiftsNames));
        problem.shifts_horisontal(numberPosition) = trueValue;
    case 'a'
        numberPosition = find(strcmp(what,problem.nbaNames));
        problem.nba(numberPosition) = trueValue;
    case 'u'
        numberPosition = find(strcmp(what,problem.nbsNames));
        problem.nbs(numberPosition) = trueValue;
    case 'r'
        numberPosition = find(strcmp(what,problem.resolNames));
        problem.resolution(numberPosition) = trueValue;
end

setappdata(0,'problem',problem);
rsafeCalcAndPlot();
            













