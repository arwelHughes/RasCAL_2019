function unlockMainControlsFrame()

frame = getappdata(0,'controlsFrame');
awtinvoke(frame,'setUnlocked');
frame.repaint;


