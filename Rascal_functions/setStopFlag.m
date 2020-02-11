function setStopFlag(val)

controlsPanel = getappdata(0,'controlsPanel');
controlsPanel.setStopFlag(val);
setappdata(0,'controlsPanel',controlsPanel);
