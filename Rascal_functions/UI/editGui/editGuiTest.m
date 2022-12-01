function editGuiTest(problem);


if isempty(find(strcmp(fields(problem),'numberOfAddedParams')))
    problem.numberOfAddedParams = 1;
end

setappdata(0,'problem',problem);
setappdata(0,'paramsEditguiTableEditDetails',[]);

sliders = getappdata(0,'slidersWindow');
if ~isempty(sliders)
    slWinCancel;
end

disableMenus();
saveCurrentChecksStatus;

internalFrame = mainEditGuiFrame();
mainGuiFrame = getappdata(0,'mainGuiFrame');
internalFrame.setDefaultCloseOperation(javax.swing.JFrame.DISPOSE_ON_CLOSE);

mainOKButton = internalFrame.getMainOKButton();
h_mainOKButton = handle(mainOKButton, 'CallbackProperties');
set(h_mainOKButton,'ActionPerformedCallback',@mainOKCallback);


mainCancelButton = internalFrame.getMainCancelButton();
h_mainCancelButton = handle(mainCancelButton, 'CallbackProperties');
set(h_mainCancelButton,'ActionPerformedCallback',@mainCancelCallback);

mainPane = internalFrame.getPanel();
generalPanel = mainPanelSetup();
paramsPanel = paramsPanelSetup();
layersPanel = layersPanelSetup();
experimentParams = expParamsSetup();

%Add the relevant panels......
mainPane.addTab('General',generalPanel);
mainPane.addTab('Parameters',paramsPanel);
mainPane.addTab('Layers',layersPanel);
mainPane.addTab('Experimental Params',experimentParams);
switch problem.module.type
    case 'Standard Layers'
        mainPane.setEnabledAt(2,true);
    otherwise
        mainPane.setEnabledAt(2,false);
end

makecontrastEditPanelTablesCombos(problem);

for i = 1:problem.numberOfContrasts
    thisContrast = existingContrastPanelSetup(i);
    allContrastPanels{i} = thisContrast;
    name = ['Contrast ' num2str(i)];
    mainPane.addTab(name,thisContrast);
end

allPanels.mainPane = mainPane;
allPanels.generalPanel = generalPanel;
allPanels.paramsPanel = paramsPanel;
allPanels.layersPanel = layersPanel;
allPanels.experimentParams = experimentParams;
allPanels.contrasts = allContrastPanels;

%allOpenGenieWindows = makeOpenGenieWindows(problem);

%Show it....
desktop = getappdata(0,'desktop');

internalPreferredDimension = mainPane.getPreferredSize();
preferredWidth = internalPreferredDimension.getWidth();
preferredHeight = internalPreferredDimension.getHeight();

frameMinimumDim = java.awt.Dimension();
frameMinimumDim.setSize(preferredWidth+50,preferredHeight+50);

internalFrame.setMinimumSize(frameMinimumDim);

desktop.add(internalFrame);
internalFrame.setVisible(true);
internalFrame.setLocation(100,100);

% for i = 1:problem.numberOfContrasts;
%     thisOgWin = allOpenGenieWindows{i};
%     desktop.setLayer(thisOgWin,4);
%     desktop.add(thisOgWin);
%     thisOgWin.setVisible(false);
%     thisOgWin.setLocation(internalFrame.getLocation);
%     thisOgWin.setSize(600,400);
% end

%setappdata(0,'desktop',desktop);
setappdata(0,'mainPane',mainPane);
setappdata(0,'mainFrame',internalFrame);
setappdata(0,'allPanels',allPanels);
setappdata(0,'internalFrame',internalFrame);
%setappdata(0,'allOpenGenieWindows',allOpenGenieWindows);
lockMainGuiFrame();
lockMainControlsFrame();

end

%_________________________________________________________________________

function mainOKCallback(src,ev)

fr = getappdata(0,'internalFrame');


[out,problem] = makeProblemFromGui();
if strcmp(out{1},'ok') == 1
    try
        reSetProblem(problem);
    catch
        addInfoText(sprintf(['Failed because ' lasterr]));
        beep
        return
    end
    cleanUpEditGuiMem;
    fr.dispose;
    defaultPosWindows();
    unlockMainGuiFrame();
    unlockMainControlsFrame();
    enableMenus();

else
    f = getappdata(0,'iframeInfoPane');
    f.setSelected(true);
    addInfoText(sprintf(['Failed because ' out{2}]));
    beep;
end


restorePreviousCheckStatus();
java.lang.System.gc();


end

%_________________________________________________________________________

function mainCancelCallback(src,ev)

fr = getappdata(0,'internalFrame');

problem = getappdata(0,'originalProblem');
setappdata(0,'problem',problem);

cleanUpEditGuiMem;
fr.dispose;
defaultPosWindows();

unlockMainGuiFrame();
unlockMainControlsFrame();
enableMenus();
java.lang.System.gc();

end

%_________________________________________________________________________

function cleanUpEditGuiMem();

try
    rmappdata(0,'paramsEditguiTableEditDetails'); 
catch
end
try
    rmappdata(0,'MPComponents');
catch
end
try
    rmappdata(0,'editGuiParamsTable');
catch
end
try
    rmappdata(0,'editGuiParamsTableModel');
    catch
end
try
    rmappdata(0,'paramsNamesList');
    catch
end
try
    rmappdata(0,'layersTableItems');
    catch
end
try
    rmappdata(0,'layersNamesList');
    catch
end
try
    rmappdata(0,'editGuiBacksTable');
    catch
end
try
    rmappdata(0,'numberOfAddedBacks');
catch
end
try
    rmappdata(0,'backsNamesList');
catch
end
try
    rmappdata(0,'editGuiScalesTable');
catch
end
try
    rmappdata(0,'numberOfAddedScales');
catch
end
try
    rmappdata(0,'scalesNamesList');
catch
end
try
    rmappdata(0,'editGuiShiftsTable');
catch
end
try
    rmappdata(0,'numberOfAddedShifts');
catch
end
try
    rmappdata(0,'shiftsNamesList');
catch
end
try
    rmappdata(0,'editGuiNbaTable');
catch
end
try
    rmappdata(0,'numberOfAddedNbas');
catch
end
try
    rmappdata(0,'nbasNamesList');
catch
end
try
    rmappdata(0,'editGuiNbsTable');
catch
end
try
    rmappdata(0,'nbsNamesList');
catch
end
try
    rmappdata(0,'numberOfAddedNbs');
catch
end
try
    rmappdata(0,'contrastEditPanelTablesCombos');
catch
end
try
    rmappdata(0,'allContrastTables');
catch
end
try
    rmappdata(0,'allContrastPanels');
catch
end
try
    rmappdata(0,'mainPane');
catch
end
try
    rmappdata(0,'mainFrame');
catch
end
try
    rmappdata(0,'allPanels');
catch
end
try rmappdata(0,'originalProblem');
catch
end

allOgWindows = getappdata(0,'allOpenGenieWindows');
for i = 1:length(allOgWindows)
    thisFrame = allOgWindows{i};
    thisFrame.dispose;
end

java.lang.System.gc();

end
