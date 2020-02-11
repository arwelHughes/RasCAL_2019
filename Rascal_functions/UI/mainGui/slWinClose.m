function slWinClose(src,ev);

update_params();
slidersWindow = getappdata(0,'slidersWindow');
slidersWindow.dispose;
rmappdata(0,'slidersWindow');
rmappdata(0,'slidersOldProblem');
mainGuiWindow = getappdata(0,'mainGuiFrame');
mainGuiWindow.setVisible(true);