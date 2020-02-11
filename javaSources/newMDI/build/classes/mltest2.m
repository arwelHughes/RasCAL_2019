function tt()

javaaddpath C:\Gwaith2007\Rascal\JavaSources\newMDI\build\classes
javaaddpath C:\Gwaith2007\Rascal\Rascal1.6\Rascal_functions\UI\RascalClasses
import javax.swing.*;
import java.awt.*;

problem = lawrence_standard_boxmod();
setappdata(0,'problem',problem);


%-------------------------------------------------------------------------
%  Make the main MDI.
%-------------------------------------------------------------------------
frame = JFrame('Rascal');
frame.setSize(300,300);
desktop = MDIDesktopPane();


setappdata(0,'desktop',desktop);
menuBar = JMenuBar();

%------------------------------------------------------------------------
%   Set the menu's
%------------------------------------------------------------------------

%File menu
fileMenu = JMenu('File');
newMenuItem = JMenuItem('New Project');
loadMenuItem = JMenuItem('Load Project');
saveMenuItem = JMenuItem('Save Project');
exitMenuItem = JMenuItem('Exit Rascal');
fileMenu.add(newMenuItem);
fileMenu.add(loadMenuItem);
fileMenu.add(saveMenuItem);
fileMenu.add(exitMenuItem);

%Edit menu
editMenu = JMenu('Edit');
editMenuItem = JMenuItem('Edit Project');
editMenu.add(editMenuItem);

%Options menu
optionsMenu = JMenu('Options');
fittingMenuItem = JMenuItem('Fitting');
displayMenuItem = JMenuItem('Display');
optionsMenu.add(fittingMenuItem);
optionsMenu.add(displayMenuItem);


%Windows Menu
windowsMenu = JMenu('Windows');
defaultMenuItem = JMenuItem('Default');
tileMenuItem = JMenuItem('Tile');
cascadeMenuItem = JMenuItem('Cascade');
set(cascadeMenuItem,'ActionPerformedCallback',@cascadeWindows);
set(tileMenuItem,'ActionPerformedCallback',@tileWindows);
windowsMenu.add(defaultMenuItem);
windowsMenu.add(tileMenuItem);
windowsMenu.add(cascadeMenuItem);

menuBar.add(fileMenu);
menuBar.add(editMenu);
menuBar.add(optionsMenu);
menuBar.add(windowsMenu);
frame.setJMenuBar(menuBar);

scrollpane = JScrollPane();
v = scrollpane.getViewport();
v.add(desktop);

cp = frame.getContentPane();
layout = BorderLayout();
cp.setLayout(layout);
cp.add(scrollpane,BorderLayout.CENTER);
frame.show;


%------------------------------------------------------------------------
%   Make the windows.
%------------------------------------------------------------------------
%1. Parameters table window.
iframeParams = JInternalFrame();
iframeParams.setSize(100,100);
iframeParams.setTitle('Parameters Details');
iframeParams.setMaximizable(true);
iframeParams.setIconifiable(true);
iframeParams.setClosable(false);
iframeParams.setResizable(true);
iframeParams.setVisible(true);

paramsTable = paramsTableSetup(problem);
%set(paramsTable,'PropertyChangeCallback',@thisBitHere);

%..and set the scrollpane
scroller = JScrollPane(paramsTable);
scroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
scroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);

iframeParams.add(scroller,BorderLayout.CENTER);
desktop.add(iframeParams);


%2.  Layers details window.
iframeLayers = JInternalFrame();
iframeLayers.setSize(100,100);
iframeLayers.setTitle('Layers Details');
iframeLayers.setMaximizable(true);
iframeLayers.setIconifiable(true);
iframeLayers.setClosable(false);
iframeLayers.setResizable(true);
iframeLayers.setVisible(true);

lTable = LayersTableSetup(problem);

scroller = JScrollPane(lTable);
scroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
scroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);

iframeLayers.add(scroller);
desktop.add(iframeLayers);


%3.   Data table Window.
iframeData = JInternalFrame();
iframeData.setSize(100,100);
iframeData.setTitle('Data Details');
iframeData.setMaximizable(true);
iframeData.setIconifiable(true);
iframeData.setClosable(false);
iframeData.setResizable(true);
iframeData.setVisible(true);

dTable = DataTableSetup(problem);

scroller = JScrollPane(dTable);
scroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
scroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);

iframeData.add(scroller);
desktop.add(iframeData);
desktop.setBackground(javax.swing.plaf.ColorUIResource(0.5,0.5,0.65));





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function table = paramsTableSetup(problem)

import javax.swing.*;


table = JTable;
headings = {'fit?','Parameter','min','value','max','StdErr'};
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;

%Get all the relevant values out of problem.
checks = problem.fityesno;
names = problem.paramnames;
min = problem.constr(:,1);
val = problem.params;
max = problem.constr(:,2);
stderr = problem.fiterrs;
rows = length(problem.params);

%Put all the values into an array
for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals{r,2} = names{r};
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals{r,6} = stderr(r);
end

%Apply the TableModel to the JTable
tableModel = ParamsTable(headings,Vals,rows);
table.setModel(tableModel);

set(table,'AutoResizeMode',0)
set(tableModel, 'TableChangedCallback', @paramsTableChangedCallback);
setappdata(0,'paramsTableModel',tableModel);
setappdata(0,'paramsTable',table);

%Apply the custom cell renderer
J = SetRender();
table = J.SetRenderer(table);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function lTable = LayersTableSetup(problem)


import javax.swing.*;

layersDetails = problem.layersDetails;
numberOfLayers = size(layersDetails,1);
Vals = [];

for i = 1:numberOfLayers;
    thisLayer = layersDetails{i};
    numLabel = sprintf('Layer %d',i);
    Vals{i,1} = numLabel;
    Vals{i,2} = thisLayer{2};
    thisLayer = regexp(thisLayer{1,1},'[0-9]+[\.[0-9]+]*','match');
    thicksIndex = str2num(thisLayer{1});
    Vals{i,3} = problem.paramnames{thicksIndex};
    sldsIndex = str2num(thisLayer{2});
    Vals{i,4} = problem.paramnames{sldsIndex};
    roughsIndex = str2num(thisLayer{3});
    Vals{i,5} = problem.paramnames{roughsIndex};
end


headings = {'Layer','Layer Name','Thick','Sld','Rough'};
lTable = JTable(Vals,headings);
set(lTable,'AutoResizeMode',0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function table = DataTableSetup(problem)

import javax.swing.*;

table = JTable;
checks = problem.include_data;
names = problem.datafiles;
min = problem.fitlowrange;
max = problem.fithirange;
layers = problem.contrastLayers;
rows = length(checks);

 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;

for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals{r,2} = names(r,:);
    Vals{r,3} = min(r);
    Vals{r,4} = max(r);
    Vals{r,5} = layers{r};
end

headings = {'Include?','Datafile','min','max','Layers'};

tableModel = DataTable(headings,Vals,rows);
table.setModel(tableModel);
set(table,'AutoResizeMode',0);
table.setRowSelectionAllowed(false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cascadeWindows(src,ev);


desktop = getappdata(0,'desktop');
desktop.cascadeFrames;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tileWindows(src,ev);

desktop = getappdata(0,'desktop');
desktop.tileFrames;

