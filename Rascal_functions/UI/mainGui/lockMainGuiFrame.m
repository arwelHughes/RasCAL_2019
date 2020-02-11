function lockMainGuiFrame

frame = getappdata(0,'mainGuiFrame');
awtinvoke(frame,'setLocked');
frame.repaint;

