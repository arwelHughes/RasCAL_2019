function clearDesktop()

%gets rid of the plotting and details windows,
%whilst leaving the infopane and fitting controls.


iframePlots = getappdata(0,'iframePlots');
size = iframePlots.getSize();
location = iframePlots.getLocation();
plotsPlace = {size , location};
setappdata(0,'plotsPlace',plotsPlace);
iframePlots.dispose;
rmappdata(0,'iframePlots');

mainGuiFrame = getappdata(0,'mainGuiFrame');
size = mainGuiFrame.getSize();
location = mainGuiFrame.getLocation();
mainGuiPlace = {size , location};
setappdata(0,'mainGuiPlace',mainGuiPlace);
mainGuiFrame.dispose;
rmappdata(0,'mainGuiFrame');

drawnow;



