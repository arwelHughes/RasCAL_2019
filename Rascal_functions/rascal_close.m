function rascal_close(src,ev)

desktop = getappdata(0,'desktop');
try
    savePosWindows;
    fr = desktop.getTopLevelAncestor();
    fr.dispose();
catch
end

close all
clear classes
clear
clearappdata;