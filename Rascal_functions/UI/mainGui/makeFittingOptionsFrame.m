function fittingOptionsFrame = makeFittingOptionsFrame(problem);

fittingOptionsFrame = awtcreate('fittingOptionsFrame');
fittingOptionsFrame = javaObjectEDT(fittingOptionsFrame());
fitopts = getappdata(0,'fittingOptions');

%q4CheckBox = javaObjectEDT(fittingOptionsFrame.getFitQ4Checkbox());
%errChi = javaObjectEDT(fittingOptionsFrame.getFitErrorChiCheckBox());
mainOkButton = javaObjectEDT(fittingOptionsFrame.getFitOptionsOkButton());
mainCancelButton = javaObjectEDT(fittingOptionsFrame.getFitOptionsCancelButton());
algTabbedPane = javaObjectEDT(fittingOptionsFrame.getAlgOptionsTabbedPane());

%resolTypeComboBox = javaObjectEDT(fittingOptionsFrame.getResolTypeComboBox());
%localOGPath = javaObjectEDT(fittingOptionsFrame.getlocalOGPathBox());
%localOGPathBrowse = javaObjectEDT(fittingOptionsFrame.getbrowseLocalOGPath());

thisSimplexOptionsPanel = javaObjectEDT(simplexOptionsPanel());
thisCmaesOptionsPanel = javaObjectEDT(cmaesOptionsPanel());
thisDEOptionsPanel = javaObjectEDT(DEOptionsPanel());
thisResampOptionsPanel = javaObjectEDT(resamplingOptionsPanel);

algTabbedPane.addTab('Simplex',thisSimplexOptionsPanel);
algTabbedPane.addTab('Genetic',thisCmaesOptionsPanel);
algTabbedPane.addTab('DE',thisDEOptionsPanel);
algTabbedPane.addTab('Resample',thisResampOptionsPanel);

% if strcmp(problem.q4,'yes')
%     q4CheckBox.setSelected(true);
% else
%     q4CheckBox.setSelected(false);
% end

% if problem.useReducedChiSquared == 1
%     errChi.setSelected(true);
% else
%     errChi.setSelected(false);
% end

smplxTargetChiBox = javaObjectEDT(thisSimplexOptionsPanel.getSmplxTargetChiBox());
smplxTargetChiBox.setText(num2str(fitopts.simplex.TargetChi));

smplxMaxFunEvalsBox = javaObjectEDT(thisSimplexOptionsPanel.getSmplxMaxFunEvalsBox());
smplxMaxFunEvalsBox.setText(num2str(fitopts.simplex.MaxFunEvals));

SmplxStopParamTol = javaObjectEDT(thisSimplexOptionsPanel.getSmplxStopParamTol());
SmplxStopParamTol.setText(num2str(fitopts.simplex.stopTolParam));

SmplxFunTolBox = javaObjectEDT(thisSimplexOptionsPanel.getSmplxFunTolBox());
SmplxFunTolBox.setText(num2str(fitopts.simplex.stopFunTol));

resAngleTextBox = javaObjectEDT(thisResampOptionsPanel.getResAngleTextField());
resAngleTextBox.setText(num2str(problem.resampleAngle));

resNPointsTextBox = javaObjectEDT(thisResampOptionsPanel.getResNLayersTextfield());
resNPointsTextBox.setText(num2str(problem.resampleNLayers));

resampleCheckButton = javaObjectEDT(thisResampOptionsPanel.getResCheckButton());
h = handle(resampleCheckButton,'CallbackProperties');set(h,'ActionPerformedCallback',@checkResampleCallback);


h = handle(mainOkButton,'CallbackProperties');set(h,'ActionPerformedCallback',@fOptionsOkCallback);
h = handle(mainCancelButton,'CallbackProperties');set(h,'ActionPerformedCallback',@fOptionsCancelCallback);
%h = handle(localOGPathBrowse,'CallbackProperties');set(h,'ActionPerformedCallback',@browseLocalOgDataPathCallback);

setappdata(0,'resampleCheckVisible',false);
setappdata(0,'fittingOptionsFrame',fittingOptionsFrame);
setappdata(0,'simplexOptionsPanel',thisSimplexOptionsPanel);
setappdata(0,'cmaesOptionsPanel',thisCmaesOptionsPanel);
setappdata(0,'DEOptionsPanel',thisDEOptionsPanel);
setappdata(0,'resampleOptionsPanel',thisResampOptionsPanel);

end
%__________________________________________________________________________

function fOptionsCancelCallback(src,ev)

fWindow = getappdata(0,'fittingOptionsFrame');
fWindow.setVisible(false);
unlockMainControlsFrame();
unlockMainGuiFrame();

visible = getappdata(0,'resampleCheckVisible');
if visible
    resPlot = getappdata(0,'resampleCheckFigure');
    try
        close(resPlot);
    catch
    end
end
setappdata(0,'resampleCheckVisible',false);

end
%__________________________________________________________________________

function fOptionsOkCallback(src,ev)


fWindow = getappdata(0,'fittingOptionsFrame');
simplexOptionsPanel = getappdata(0,'simplexOptionsPanel');
cmaesOptionsPanel = getappdata(0,'cmaesOptionsPanel');
DEOptionsPanel = getappdata(0,'DEOptionsPanel');
resOptionsPanel = getappdata(0,'resampleOptionsPanel');
fitopts = getappdata(0,'fittingOptions');

%q4CheckBox = fWindow.getFitQ4Checkbox();

fWindow.setVisible(false);
unlockMainControlsFrame();
unlockMainGuiFrame();

% useQ4 = q4CheckBox.isSelected();
% switch useQ4
%     case 1
%         turnOnQ4();
%     case 0
%         turnOffQ4();
% end

problem = getappdata(0,'problem');

% resolType = fWindow.getResolTypeComboBox;
% whichSelected = resolType.getSelectedIndex;
% 
% if whichSelected == 0
%     problem.resolType = 0;
% elseif whichSelected == 1
%     problem.resolType = 1;
% else
%     problem.resolType = 2;
% end

% errChi = fWindow.getFitErrorChiCheckBox();
% isErrSelected = errChi.isSelected();
% 
% switch isErrSelected
%     case 1
%         problem.useReducedChiSquared = 1;
%     case 0
%         problem.useReducedChiSquared = 0;
% end
% 
% numberOfSlaves = str2num(char(fWindow.getNumberOfSlavesBox().getText));

%setappdata(0,'problem',problem);
%setappdata(0,'numberOfSlaves',numberOfSlaves);

SimptargetChi = simplexOptionsPanel.getSmplxTargetChiBox().getText;
SimpMaxFunEvals = simplexOptionsPanel.getSmplxMaxFunEvalsBox().getText;
SimpStopParamTol = simplexOptionsPanel.getSmplxStopParamTol().getText;
SimpStopFnTol = simplexOptionsPanel.getSmplxFunTolBox().getText;

fitopts.simplex.TargetChi = str2num(char(SimptargetChi));
fitopts.simplex.MaxFunEvals = str2num(char(SimpMaxFunEvals));
fitopts.simplex.stopTolParam = str2num(char(SimpStopParamTol));
fitopts.simplex.stopFunTol = str2num(char(SimpStopFnTol));

CmaesTargetChi = cmaesOptionsPanel.getTargetChiSquaredBox().getText;
CmaesMaxFunEval = cmaesOptionsPanel.getMaxFunEvalsBox().getText;
CmaesStopTolX = cmaesOptionsPanel.getStopParamTolBox().getText;
CmaesStopTolFun = cmaesOptionsPanel.getStopFunTolBox().getText;
CmaesPopSize = cmaesOptionsPanel.getPopSizeBox().getText;
CmaesMaxdp = cmaesOptionsPanel.getMaxDelPBox().getText;
CmaesMindp = cmaesOptionsPanel.getMinDelPBox().getText;
CmaesRecombW = cmaesOptionsPanel.getRecombWeightsCombo().getSelectedIndex;

fitopts.cmaes.TargetChi = str2num(char(CmaesTargetChi));
fitopts.cmaes.MaxFunEval = str2num(char(CmaesMaxFunEval));
fitopts.cmaes.StopTolX = str2num(char(CmaesStopTolX));
fitopts.cmaes.StopTolFun = str2num(char(CmaesStopTolFun));
fitopts.cmaes.PopSize= str2num(char(CmaesPopSize));
fitopts.cmaes.Maxdp = str2num(char(CmaesMaxdp));
fitopts.cmaes.Mindp = str2num(char(CmaesMindp));
fitopts.cmaes.RecombW = CmaesRecombW;

DEcrossoverProb = DEOptionsPanel.getCRprobTextField().getText;
DEvalueToReach = DEOptionsPanel.getVTRTextfield().getText;
DEpopulationSize = DEOptionsPanel.getPopSizeTextField().getText;
DEstepSize = DEOptionsPanel.getStepSizeTextField().getText;
DEStrategy = DEOptionsPanel.getStrategyComboBox().getSelectedIndex;

fitopts.DE.CrossOverProb = str2num(char(DEcrossoverProb));
fitopts.DE.ValueToReach = str2num(char(DEvalueToReach));
fitopts.DE.PopSize = str2num(char(DEpopulationSize));
fitopts.DE.StepSize = str2num(char(DEstepSize));
fitopts.DE.Strategy = DEStrategy+1;

resampleNlayers = str2double(resOptionsPanel.getResNLayersTextfield().getText);
resampleAngle = str2double(resOptionsPanel.getResAngleTextField().getText);
problem.resampleNLayers = resampleNlayers;
problem.resampleAngle = resampleAngle;
setappdata(0,'problem',problem);

setappdata(0,'fittingOptions',fitopts);

visible = getappdata(0,'resampleCheckVisible');
if visible
    resPlot = getappdata(0,'resampleCheckFigure');
    try
        close(resPlot);
    catch
    end
end

rsafeCalcAndPlot();
setappdata(0,'resampleCheckVisible',false);

end