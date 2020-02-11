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
frame.setSize(700,700);
desktop = MDIDesktopPane();
desktop.setBackground(javax.swing.plaf.ColorUIResource(0.5,0.5,0.65));

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
ptwidth = paramsTable.getPreferredScrollableViewportSize().width;
ptheight = paramsTable.getRowCount()*paramsTable.getRowHeight();
paramsTable.setPreferredScrollableViewportSize(java.awt.Dimension(ptwidth,ptheight));
myPanel = JPanel();
myPanel.setSize(300,300);
layout = GridBagConstraints();
myPanel.setLayout(GridBagLayout());
layout.gridx = 0;
layout.gridy = 0;
paramsTableContainer = JScrollPane(paramsTable);
paramsTableContainer.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
paramsTableContainer.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
myPanel.add(paramsTableContainer,layout);

%..and set the scrollpane
scroller = JScrollPane();
scroller.getViewport.add(myPanel);
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



%4. Backgrounds and Shifts Window.
iframeBacks = JInternalFrame();
iframeBacks.setSize(100,100);
iframeBacks.setTitle('Backgrounds, scales and shifts');
iframeBacks.setMaximizable(true);
iframeBacks.setIconifiable(true);
iframeBacks.setClosable(false);
iframeBacks.setResizable(true);
iframeBacks.setVisible(true);
backsPanel = JPanel;
backsPanel.setLayout(GridBagLayout());
c = GridBagConstraints();

%(a) backgrounds table
backsTable = BacksTableSetup(problem);
btwidth = backsTable.getPreferredScrollableViewportSize().width;
btheight = backsTable.getRowCount()*backsTable.getRowHeight();
backsTable.setPreferredScrollableViewportSize(java.awt.Dimension(btwidth,btheight));
backsLabel = JLabel('Backgrounds');
thisInset = java.awt.Insets(0,0,10,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 0;
c.anchor = GridBagConstraints.WEST;
backsPanel.add(backsLabel,c);

thisInset = java.awt.Insets(0,0,30,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 1;
c.anchor = GridBagConstraints.CENTER;
backsTablePane = JScrollPane(backsTable);
backsTablePane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
backsTablePane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
backsPanel.add(backsTablePane,c);

%(b) Scale factors table
scalesTable = ScalesTableSetup(problem);
stwidth = scalesTable.getPreferredScrollableViewportSize().width;
stheight = scalesTable.getRowCount()*scalesTable.getRowHeight();
scalesTable.setPreferredScrollableViewportSize(java.awt.Dimension(stwidth,stheight));
scalesLabel = JLabel('Scale Factors');
thisInset = java.awt.Insets(0,0,10,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 2;
c.anchor = GridBagConstraints.WEST;
backsPanel.add(scalesLabel,c);

thisInset = java.awt.Insets(0,0,30,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 3;
c.anchor = GridBagConstraints.CENTER;
scalesTablePane = JScrollPane(scalesTable);
scalesTablePane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
scalesTablePane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
backsPanel.add(scalesTablePane,c);

%(c) q-shifts table
shiftsTable = ShiftsTableSetup(problem);
shtwidth = shiftsTable.getPreferredScrollableViewportSize().width;
shtheight = shiftsTable.getRowCount()*shiftsTable.getRowHeight();
shiftsTable.setPreferredScrollableViewportSize(java.awt.Dimension(shtwidth,shtheight));
shiftsLabel = JLabel('Qz Shifts');
thisInset = java.awt.Insets(0,0,10,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 4;
c.anchor = GridBagConstraints.WEST;
backsPanel.add(shiftsLabel,c);

thisInset = java.awt.Insets(0,0,30,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 5;
c.anchor = GridBagConstraints.CENTER;
shiftsTablePane = JScrollPane(shiftsTable);
shiftsTablePane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
shiftsTablePane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
backsPanel.add(shiftsTablePane,c);

%(c) NBairs table
nbairsTable = NbairsTableSetup(problem);
nbatwidth = nbairsTable.getPreferredScrollableViewportSize().width;
nbatheight = nbairsTable.getRowCount()*nbairsTable.getRowHeight();
nbairsTable.setPreferredScrollableViewportSize(java.awt.Dimension(nbatwidth,nbatheight));
nbairsLabel = JLabel('Nb airs');
thisInset = java.awt.Insets(0,0,10,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 6;
c.anchor = GridBagConstraints.WEST;
backsPanel.add(nbairsLabel,c);

thisInset = java.awt.Insets(0,0,30,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 7;
c.anchor = GridBagConstraints.CENTER;
nbairsTablePane = JScrollPane(nbairsTable);
nbairsTablePane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
nbairsTablePane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
backsPanel.add(nbairsTablePane,c);



%(d) Nbsubs table
nbsubsTable = NbsubsTableSetup(problem);
nbstwidth = nbsubsTable.getPreferredScrollableViewportSize().width;
nbstheight = nbsubsTable.getRowCount()*nbsubsTable.getRowHeight();
nbsubsTable.setPreferredScrollableViewportSize(java.awt.Dimension(nbstwidth,nbstheight));
nsubsLabel = JLabel('Nb subs');
thisInset = java.awt.Insets(0,0,10,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 8;
c.anchor = GridBagConstraints.WEST;
backsPanel.add(nsubsLabel,c);

thisInset = java.awt.Insets(0,0,30,1);
c.insets = thisInset;
c.gridx = 0;
c.gridy = 9;
c.anchor = GridBagConstraints.CENTER;
nbsubsTablePane = JScrollPane(nbsubsTable);
nbsubsTablePane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
nbsubsTablePane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
backsPanel.add(nbsubsTablePane,c);

backsPanelMainScroller = JScrollPane(backsPanel);
backsPanelMainScroller.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
backsPanelMainScroller.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED);
iframeBacks.add(backsPanelMainScroller);
desktop.add(iframeBacks);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function table = paramsTableSetup(problem)

import javax.swing.*;



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
table = JTable;
%table = myNewTable(rows,6);
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

function table = BacksTableSetup(problem)

import javax.swing.*;

table = JTable;
checks = problem.backgrounds_fityesno;
val = problem.backs;
min = problem.backs_constr(:,1);
max = problem.backs_constr(:,2);
apps_to = problem.backgrounds_appliesto;
rows = length(val);
 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;
    
for i = 1:rows;
   thisname = ['Background ' num2str(i)];
   names{i} = thisname;
end

%Put all the values into an array
for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals(r,2) = names(r);
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals(r,6) = apps_to(r);
end


headings = {'fit?','Parameter','min','value','max','Apply to?'};

tableModel = BacksTable(headings,Vals,rows);
table.setModel(tableModel);
set(table,'AutoResizeMode',0);
table.setRowSelectionAllowed(false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function table = ScalesTableSetup(problem);

import javax.swing.*;
table = JTable;
checks = problem.scalefac_fityesno;
val = problem.scalefac;
min = problem.scale_constr(:,1);
max = problem.scale_constr(:,2);
apps_to = problem.scalefac_appliesto;
rows = length(val);
 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;
    
for i = 1:rows;
   thisname = ['Scale factor ' num2str(i)];
   names{i} = thisname;
end

%Put all the values into an array
for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals(r,2) = names(r);
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals(r,6) = apps_to(r);
end


headings = {'fit?','Parameter','min','value','max','Apply to?'};

tableModel = BacksTable(headings,Vals,rows);
table.setModel(tableModel);
set(table,'AutoResizeMode',0);
table.setRowSelectionAllowed(false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function table = ShiftsTableSetup(problem);

import javax.swing.*;
table = JTable;

%Get all the relevant values out of problem.
checks = problem.shifts_fityesno;
val = problem.shifts_horisontal;
min = problem.shifts_constr(:,1);
max = problem.shifts_constr(:,2);
apps_to = problem.shifts_appliesto;
rows = length(val);
 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;
    
for i = 1:rows;
   thisname = ['Qz shifts ' num2str(i)];
   names{i} = thisname;
end

%Put all the values into an array
for r = 1:rows;
    r
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals(r,2) = names(r);
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals(r,6) = apps_to(r);
end


headings = {'fit?','Parameter','min','value','max','Apply to?'};

tableModel = BacksTable(headings,Vals,rows);
table.setModel(tableModel);
set(table,'AutoResizeMode',0);
table.setRowSelectionAllowed(false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function table = NbairsTableSetup(problem);

import javax.swing.*;
table = JTable;

%Get all the relevant values out of problem.
checks = problem.nbairs_fityesno;
val = problem.nba;
min = problem.nbairs_constr(:,1);
max = problem.nbairs_constr(:,2);
apps_to = problem.nbairs_appliesto;
rows = length(val);
 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;
    
for i = 1:rows;
   thisname = ['Nbair ' num2str(i)];
   names{i} = thisname;
end

%Put all the values into an array
for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals(r,2) = names(r);
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals(r,6) = apps_to(r);
end


headings = {'fit?','Parameter','min','value','max','Apply to?'};

tableModel = BacksTable(headings,Vals,rows);
table.setModel(tableModel);
set(table,'AutoResizeMode',0);
table.setRowSelectionAllowed(false);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function table = NbsubsTableSetup(problem);

import javax.swing.*;
table = JTable;

%Get all the relevant values out of problem.
checks = problem.nbsubs_fityesno;
val = problem.nbs;
min = problem.nbsubs_constr(:,1);
max = problem.nbsubs_constr(:,2);
apps_to = problem.nbsubs_appliesto;
rows = length(val);
 
check_on = java.lang.Boolean.TRUE;
check_off = java.lang.Boolean.FALSE;
    
for i = 1:rows;
   thisname = ['Nb subs ' num2str(i)];
   names{i} = thisname;
end

%Put all the values into an array
for r = 1:rows;
    if checks(r) == 1;
        Vals{r,1} = check_on;
    else
        Vals{r,1} = check_off;
    end
    Vals(r,2) = names(r);
    Vals{r,3} = min(r);
    Vals{r,4} = val(r);
    Vals{r,5} = max(r);
    Vals(r,6) = apps_to(r);
end


headings = {'fit?','Parameter','min','value','max','Apply to?'};

tableModel = BacksTable(headings,Vals,rows);
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

