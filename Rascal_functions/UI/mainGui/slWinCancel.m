function slWinCancel(src,ev)

slidersWindow = getappdata(0,'slidersWindow');
slidersWindow.dispose;

OldProblem = getappdata(0,'slidersOldProblem');
setappdata(0,'problem',OldProblem);

update_params();
rsafeCalcAndPlot();

rmappdata(0,'slidersOldProblem');
rmappdata(0,'slidersWindow');
mainGuiWindow = getappdata(0,'mainGuiFrame');
mainGuiWindow.setVisible(true);