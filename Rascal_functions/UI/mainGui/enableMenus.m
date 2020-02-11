function enableMenus()

fr = getappdata(0,'mainApplicationFrame');
menuBar = javaObjectEDT(fr.getJMenuBar());

for i = 0:3
    menuBar.getMenu(i).setEnabled(true);
    drawnow limitrate
end