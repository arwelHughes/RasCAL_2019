function unlockMainGuiFrame

frame = getappdata(0,'mainGuiFrame');
awtinvoke(frame,'setUnlocked');
frame.repaint;

