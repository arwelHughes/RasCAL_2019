function addContrastCallback(src,ev)


mainFrame = getappdata(0,'mainFrame');
mainTabbedPane = getappdata(0,'mainPane');
allPanels = getappdata(0,'allPanels');
allContrastPanels = getappdata(0,'allContrastPanels');
desktop = getappdata(0,'desktop');
allOpenGenieWindows = getappdata(0,'allOpenGenieWindows');

problem = getappdata(0,'problem');

thisContrast  = length(allPanels.contrasts) + 1;
problem.numberOfContrasts = thisContrast;

problem.dataPath{thisContrast} = 'C:\';
problem.contrastNames{thisContrast} = 'New Contrast';
problem.contrastTypes{thisContrast} = 'Simulation';
problem.contrastFiles{thisContrast} = '';
problem.contrastBacks(thisContrast) = 1;
problem.contrastScales(thisContrast) = 1;
problem.contrastShifts(thisContrast) = 1;
problem.contrastNbas(thisContrast) = 1;
problem.contrastNbss(thisContrast) = 1;
problem.contrastResolutions(thisContrast) = 1;
problem.contrastsNumberOfLayers(thisContrast) = 0;
problem.contrastLayers{thisContrast} = '';

defaultOgDetails.type = 'air liquid';
defaultOgDetails.numberOfAngles = 1;
defaultOgDetails.instrument = 'Surf';
defaultOgDetails.runs = {'71235','0.5'};
defaultOgDetails.transmission = '78590';
problem.ogDetails{thisContrast} = defaultOgDetails;

setappdata(0,'problem',problem);

panel = existingContrastPanelSetup(thisContrast);
allPanels.contrasts{thisContrast} = panel;

generalPanel = allPanels.generalPanel;
numberOfContrastsBox = generalPanel.getNumberOfContrastsTextField();
numberOfContrastsBox.setText(num2str(thisContrast));

mainTabbedPane.addTab(['Contrast ' num2str(thisContrast)],panel);

thisOgWin = setupNewOpenGenieWindow(problem,thisContrast);

desktop.setLayer(thisOgWin,4);
desktop.add(thisOgWin);
thisOgWin.setVisible(false);
thisOgWin.setLocation(mainFrame.getLocation);
thisOgWin.setSize(600,400);

allOpenGenieWindows{thisContrast} = thisOgWin;


setappdata(0,'allPanels',allPanels);
setappdata(0,'allOpenGenieWindows',allOpenGenieWindows);





