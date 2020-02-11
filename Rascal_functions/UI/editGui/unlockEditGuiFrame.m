function unlockEditGuiFrame()

frame = getappdata(0,'internalFrame');
awtinvoke(frame,'setUnlocked');

