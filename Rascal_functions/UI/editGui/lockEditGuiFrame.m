function lockEditGuiFrame()

frame = getappdata(0,'internalFrame');
awtinvoke(frame,'setLocked');
frame.repaint;


