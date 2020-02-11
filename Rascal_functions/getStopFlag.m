function val = getStopFlag()

 controlsPanel = getappdata(0,'controlsPanel');
 val = awtinvoke(controlsPanel,'getStopFlag');
% setappdata(0,'controlsPanel',controlsPanel);

