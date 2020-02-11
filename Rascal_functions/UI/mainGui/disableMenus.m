function disableMenus()

fr = getappdata(0,'mainApplicationFrame');
menuBar = fr.getJMenuBar();

for i = 0:3
    menuBar.getMenu(i).setEnabled(false);
end

