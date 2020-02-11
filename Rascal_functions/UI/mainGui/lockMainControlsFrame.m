function lockMainControlsFrame()

frame = getappdata(0,'controlsFrame');
awtinvoke(frame,'setLocked');
frame.repaint;


