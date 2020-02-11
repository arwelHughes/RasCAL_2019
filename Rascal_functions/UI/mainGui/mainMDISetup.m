function mainMDISetup()

import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JSeparator;
import javax.swing.JMenuBar;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import java.awt.BorderLayout;

problem = getappdata(0,'problem');

%-------------------------------------------------------------------------
%  Make the main MDI.
%-------------------------------------------------------------------------
frame = javaObjectEDT('javax.swing.JFrame', 'RasCAL');
frame.setSize(700,700);
desktop = javaObjectEDT('MDIDesktopPane');
desktop.setBackground(javax.swing.plaf.ColorUIResource(0.5,0.5,0.65));
frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
drawnow;

%------------------------------------------------------------------------
%   Set the menu's
%------------------------------------------------------------------------
menuBar = javaObjectEDT(JMenuBar());

%File menu
fileMenu = javaObjectEDT(JMenu('File'));
newMenuItem = javaObjectEDT(JMenuItem('New'));
loadMenuItem = javaObjectEDT(JMenuItem('Load'));
saveMenuItem = javaObjectEDT(JMenuItem('Save'));

saveAsNewFileMenuItem = javaObjectEDT(JMenuItem('Save As New File'));
saveAsNewProjectMenuItem = javaObjectEDT(JMenuItem('Save As New Project'));
exportFits = javaObjectEDT(JMenuItem('Export Fits'));
%set(exportFits,'Enabled','false');
separator = javaObjectEDT(JSeparator());
separator2 = javaObjectEDT(JSeparator());
separator3 = javaObjectEDT(JSeparator());
exitMenuItem = javaObjectEDT(JMenuItem('Exit Rascal'));
fileMenu.add(newMenuItem);
fileMenu.add(loadMenuItem);
fileMenu.add(separator);
fileMenu.add(saveMenuItem);

fileMenu.add(saveAsNewFileMenuItem);
fileMenu.add(saveAsNewProjectMenuItem);
fileMenu.add(separator2);
fileMenu.add(exportFits);
fileMenu.add(separator3);
fileMenu.add(exitMenuItem);
h = handle(loadMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rFileDialog);
h = handle(exitMenuItem,'CallbackProperties');set(h,'ActionPerformedCallback',@rascal_close);
h = handle(newMenuItem,'CallbackProperties');set(h,'ActionPerformedCallback',@newProject);
h = handle(saveMenuItem,'CallbackProperties');set(h,'ActionPerformedCallback',@saveProject);
h = handle(saveAsNewProjectMenuItem,'CallbackProperties');set(h,'ActionPerformedCallback',@rSaveProjectDialog);
h = handle(saveAsNewFileMenuItem,'CallbackProperties');set(h,'ActionPerformedCallback',@rSaveFileDialog);
h = handle(exportFits,'CallbackProperties');set(h,'ActionPerformedCallback',@rExportDataDialog);

%Edit menu
editMenu = javaObjectEDT(JMenu('Edit'));
separator4 = javaObjectEDT(JSeparator());
undoMenuItem = javaObjectEDT(JMenuItem('Undo Last Fit'));
redoMenuItem = javaObjectEDT(JMenuItem('Redo Last Fit'));
editMenuItem = javaObjectEDT(JMenuItem('Edit Project'));
editMenu.add(editMenuItem);
editMenu.add(separator4);
editMenu.add(undoMenuItem);
editMenu.add(redoMenuItem);

h = handle(undoMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@undoLastFit);
h = handle(redoMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@redoLastFit);
h = handle(editMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@openEditWindow);

%set(undoMenuItem,'Enabled','off');
%set(redoMenuItem,'Enabled','off');
undoRedoMenuItems.undoMenuItem = undoMenuItem;
undoRedoMenuItems.redoMenuItem = redoMenuItem;
setappdata(0,'undoRedoMenuItems',undoRedoMenuItems);

%Options menu
toolsMenu = javaObjectEDT(JMenu('Tools'));
algSubMenu = javaObjectEDT(JMenu('Select Fitting Algorithm'));
errorsMenu = javaObjectEDT(JMenuItem('Bootstrap Analysis'));
bayesMenu = javaObjectEDT(JMenuItem('Bayesian Analysis'));
preferencesMenuItem = javaObjectEDT(JMenuItem('Preferences'));
slidersMenuItem = javaObjectEDT(JMenuItem('Show Sliders'));
toolsSeparator1 = javaObjectEDT(JSeparator());
toolsSeparator2 = javaObjectEDT(JSeparator());
toolsSeparator3 = javaObjectEDT(JSeparator());
toolsMenu.add(slidersMenuItem);
toolsMenu.add(toolsSeparator1);
toolsMenu.add(errorsMenu);
toolsMenu.add(bayesMenu);
toolsMenu.add(toolsSeparator2);
toolsMenu.add(algSubMenu);
toolsMenu.add(toolsSeparator3);
toolsMenu.add(preferencesMenuItem);


simplexMenuItem = javaObjectEDT(JMenuItem('Nelder-Mead Simplex'));
cmaesMenuItem = javaObjectEDT(JMenuItem('Covariance Adapted Evolution Strategy'));
deMenuItem = javaObjectEDT(JMenuItem('Differential Evolution'));
glsMenuItem = javaObjectEDT(JMenuItem('Multilevel Coordinate Search'));
algSubMenu.add(simplexMenuItem);
algSubMenu.add(cmaesMenuItem);
algSubMenu.add(deMenuItem);
algSubMenu.add(glsMenuItem);

h = handle(slidersMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rInitSliders);
h = handle(simplexMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rSelectSimplex);
h = handle(cmaesMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rSelectCMAES);
h = handle(deMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rSelectDE);
h = handle(glsMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@rSelectGLS);
h = handle(errorsMenu,'CallbackProperties'); set(h,'ActionPerformedCallback',@initErrorAnalysis);
h = handle(bayesMenu,'CallbackProperties'); set(h,'ActionPerformedCallback',@openMainBayesGUI);
h = handle(preferencesMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@showFittingOptionsDialog);

%Windows Menu
windowsMenu = javaObjectEDT(JMenu('Windows'));
defaultMenuItem = javaObjectEDT(JMenuItem('Default'));
tileMenuItem = javaObjectEDT(JMenuItem('Tile'));
saveWinMenuItem = javaObjectEDT(JMenuItem('Save Current Window Positions'));
%h = handle(saveWinMenuItem,'CallbackProperties'); set(saveWinMenuItem,'ActionPerformedCallback',@cascadeWindows);
h = handle(tileMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@tileWindows);
h = handle(defaultMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@defaultPosWindows);
h = handle(saveWinMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@savePosWindows);
windowsMenu.add(defaultMenuItem);
windowsMenu.add(tileMenuItem);
windowsMenu.add(saveWinMenuItem);

%Help Menu
helpMenu = javaObjectEDT(JMenu('Help'));
quickStartMenuItem = javaObjectEDT(JMenuItem('Quick Start Guide'));
helpMenu.add(quickStartMenuItem);
h = handle(quickStartMenuItem,'CallbackProperties'); set(h,'ActionPerformedCallback',@openQuickStart);

menuBar.add(fileMenu);
menuBar.add(editMenu);
menuBar.add(toolsMenu);
menuBar.add(windowsMenu);
menuBar.add(helpMenu);
frame.setJMenuBar(menuBar);

scrollpane = javaObjectEDT(JScrollPane());
v = javaObjectEDT(scrollpane.getViewport());
v.add(desktop);

cp = javaObjectEDT(frame.getContentPane());
layout = BorderLayout();
cp.setLayout(layout);
cp.add(scrollpane,BorderLayout.CENTER);
frame.setExtendedState(JFrame.MAXIMIZED_BOTH);

% Populate the main frame with the relevant windows
desktop = makeMainWindows(desktop,problem);
%tileWindows();
pause(0.3);
frame.show;
drawnow;
setappdata(0,'desktop',desktop);
setappdata(0,'mainApplicationFrame',frame)



