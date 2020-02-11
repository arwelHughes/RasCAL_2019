function tileWindows(src,ev)

desktop = getappdata(0,'desktop');
plotWin = getappdata(0,'iframePlots');
mainWin = getappdata(0,'mainGuiFrame');
infoPane = getappdata(0,'iframeInfoPane');
controlsFrame = getappdata(0,'controlsFrame');

mainWin = javaObjectEDT(mainWin);
plotWin = javaObjectEDT(plotWin);
infoPane = javaObjectEDT(infoPane);
controlsFrame = javaObjectEDT(controlsFrame);
desktop = javaObjectEDT(desktop);

dpos = desktop.getVisibleRect;

deskWidth = dpos.width;
deskHeight = dpos.height;


winWidths = deskWidth / 2;
winHeights = deskHeight * 0.7;

winDims = java.awt.Dimension;
winDims.height = winHeights;
winDims.width = winWidths;

%plotWin.setSize(winDims);
%mainWin.setSize(winDims);
javaMethodEDT('setSize',plotWin,winDims);
javaMethodEDT('setSize',mainWin,winDims);

winDims.height = deskHeight * 0.3;
infoPane.setSize(winDims);


plotWin.setLocation(dpos.x,dpos.y);
mainWin.setLocation(dpos.x+winWidths,dpos.y);
infoPane.setLocation(dpos.x,dpos.y + winHeights);
controlsFrame.setLocation((dpos.x+winWidths+20),(dpos.y+winHeights+20)); 
