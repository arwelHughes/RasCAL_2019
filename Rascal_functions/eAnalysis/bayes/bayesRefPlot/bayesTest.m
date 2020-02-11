function bayesTest

% Bayes Plot Window Development
clear all;
addpath('/home/arwel/Desktop/RasCAL/Rascal_functions');
close all;

% Load in the necessary data
bayesOut = load('bayesDebugOutput.mat');
bayesOut = bayesOut.debugOut;
problem = bayesOut.problem;
output = bayesOut.output;
setappdata(0,'problem',problem);
intervals = bayesOut.intervals;

% Make a figure
h = figure(1);
set(h,'WindowStyle','docked');
hRefFigure = refFig;
set(hRefFigure,'WindowStyle','docked');
set(gcf,'Position',[1034 434 867 702]);

% Set the callbacks for the prediction interval
children = get(hRefFigure,'children');
intervalCombo = findobj(children,'Tag','intervalCombo'); 
figUserData.intervals = intervals;
figUserData.hRefFigure = hRefFigure;
figUserData.problem = problem;
set(intervalCombo,'Callback',@intervalChangedCallback,'UserData',figUserData);


makeRefAndSldWindow(output,hRefFigure);

% Make the Bayes Plot
predInt = 95;
makeRefSldIntervalPlots(intervals,hRefFigure,problem,predInt);

end

%-------------------------------------------------------------

function intervalChangedCallback(source,event,a)

disp('box changed');

allOptions = source.String;
chosenOption = allOptions{source.Value};
intervals = source.UserData.intervals;
hRefFigure = source.UserData.hRefFigure;
problem = source.UserData.problem;

switch chosenOption
    case '95%'
        predInt = 95;
    case '65%'
        predInt = 65;
    case '25%'
        predInt = 25;
end
            
makeRefSldIntervalPlots(intervals,hRefFigure,problem,predInt);

end




