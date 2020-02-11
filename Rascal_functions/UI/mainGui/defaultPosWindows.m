
function defaultPosWindows(src,ev)

try
 load 'sizes';
 load 'pos';
catch
    return
end

iframeMain = getappdata(0,'mainGuiFrame');
iframePlots = getappdata(0,'iframePlots');
iframeInfo = getappdata(0,'iframeInfoPane');
iframeControls = getappdata(0,'controlsFrame');
 
iframeMain.setSize(sizes(1,1),sizes(1,2));
iframeMain.setLocation(pos(1,1),pos(1,2));

iframePlots.setSize(sizes(2,1),sizes(2,2));
iframePlots.setLocation(pos(2,1),pos(2,2));

iframeInfo.setSize(sizes(3,1),sizes(3,2));
iframeInfo.setLocation(pos(3,1),pos(3,2));

%Legacy - controls position not always available...
try
    iframeControls.setLocation(pos(4,1),pos(4,2));
catch
end
