function savePosWindows(src,ev)

iframeMain = getappdata(0,'mainGuiFrame');
iframePlots = getappdata(0,'iframePlots');
iframeInfo = getappdata(0,'iframeInfoPane');
iframeControls = getappdata(0,'controlsFrame');


mainSize = [iframeMain.getSize().getWidth iframeMain.getSize().getHeight];
plotsSize = [iframePlots.getSize().getWidth iframePlots.getSize().getHeight];
infoSize = [iframeInfo.getSize().getWidth iframeInfo.getSize().getHeight];

sizes = [mainSize;
plotsSize;
infoSize];

mainLoc = [iframeMain.getLocation().getX iframeMain.getLocation().getY];
plotsLoc = [iframePlots.getLocation().getX iframePlots.getLocation().getY];
infoLoc = [iframeInfo.getLocation().getX iframeInfo.getLocation().getY];
controlsLoc = [iframeControls.getLocation().getX iframeControls.getLocation().getY];

pos = [mainLoc;
plotsLoc;
infoLoc
controlsLoc];

problem = getappdata(0,'problem');
path = problem.path;
cd(path);
save 'sizes' sizes
save 'pos' pos

addInfoText('Setting current window positions to default for this project');

