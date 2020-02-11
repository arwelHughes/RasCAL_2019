function resetFittingOptionsFrame()

fittingOptionsFrame = getappdata(0,'fittingOptionsFrame');
simplexOptionsPanel = getappdata(0,'simplexOptionsPanel');
cmaesOptionsPanel = getappdata(0,'cmaesOptionsPanel');
fitopts = getappdata(0,'fittingOptions');
problem = getappdata(0,'problem');

%q4CheckBox = fittingOptionsFrame.getFitQ4Checkbox();
%errChi = fittingOptionsFrame.getFitErrorChiCheckBox();
mainOkButton = fittingOptionsFrame.getFitOptionsOkButton();
mainCancelButton = fittingOptionsFrame.getFitOptionsCancelButton();
algTabbedPane = fittingOptionsFrame.getAlgOptionsTabbedPane();
%resolTypeComboBox = fittingOptionsFrame.getResolTypeComboBox();

% if strcmp(problem.q4,'yes');
%     q4CheckBox.setSelected(true);
% else
%     q4CheckBox.setSelected(false);
% end

% if problem.useReducedChiSquared == 1;
%     errChi.setSelected(true);
% else
%     errChi.setSelected(false);
% end

%resolTypeComboBox.setSelectedIndex(1);

simplexOptionsPanel.getSmplxTargetChiBox().setText(num2str(fitopts.simplex.TargetChi));
simplexOptionsPanel.getSmplxMaxFunEvalsBox().setText(num2str(fitopts.simplex.MaxFunEvals));
simplexOptionsPanel.getSmplxStopParamTol().setText(num2str(fitopts.simplex.stopTolParam));
simplexOptionsPanel.getSmplxFunTolBox().setText(num2str(fitopts.simplex.stopFunTol));

cmaesOptionsPanel.getTargetChiSquaredBox().setText(num2str(fitopts.cmaes.TargetChi));
cmaesOptionsPanel.getMaxFunEvalsBox().setText(num2str(fitopts.cmaes.MaxFunEval));
cmaesOptionsPanel.getStopParamTolBox().setText(num2str(fitopts.cmaes.StopTolX));
cmaesOptionsPanel.getStopFunTolBox().setText(num2str(fitopts.cmaes.StopTolFun));
cmaesOptionsPanel.getPopSizeBox().setText(num2str(fitopts.cmaes.PopSize));
cmaesOptionsPanel.getMaxDelPBox().setText(num2str(fitopts.cmaes.Maxdp));
cmaesOptionsPanel.getMinDelPBox().setText(num2str(fitopts.cmaes.Mindp));
cmaesOptionsPanel.getRecombWeightsCombo().setSelectedIndex(fitopts.cmaes.RecombW);



