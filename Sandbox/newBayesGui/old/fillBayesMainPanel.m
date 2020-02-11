function BayesFrame = fillBayesMainPanel(BayesFrame)


mainPanel = BayesFrame.getMainPanelContainer();

bayesTypeComboBox = mainPanel.getBayesTypeComboBox();
set(bayesTypeComboBox,'SelectedItem','Parameter Estimation');

% BayesSettingsPanel = mainPanel.getBayesSettingsPanel();
% displayedPanel = awtcreate('mcmcStatOptionsPanel');
% displayedPanel.setSize(BayesSettingsPanel.getSize());
% BayesSettingsPanel.add(displayedPanel);

bayesSettingsPanel = mainPanel.getBayesSettingsPanel();
bayesLayout = bayesSettingsPanel.getLayout();




setappdata(0,'mainBayesPanel',mainPanel);

end