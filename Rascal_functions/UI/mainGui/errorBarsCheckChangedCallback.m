function errorBarsCheckChangedCallback(src,ev)

mlabMkCharts = getappdata(0,'myCharts');
rChart = awtinvoke(mlabMkCharts,'getRefChart');
chBox = get(ev,'Source');
problem = getappdata(0,'problem');
iFramePlots = getappdata(0,'iframePlots');

type = chBox.isSelected;
switch type
    case 1
        problem.eb = 1;
        newChart = mkReflectivityErrorbarChartPanel();
        mlabMkCharts.setRefChart(newChart);
        refPanel = iFramePlots.getReflectivityPanel();
        %refPanel = iFramePlots.getJPanel1;
        panelSize = refPanel.getSize();
        
        oldPlot = refPanel.getComponent(0);
        refPanel.remove(oldPlot);
        
        refPanel.add(newChart);
        newChart.setSize(panelSize);
        refPanel.validate();
    case 0
        problem.eb = 0;
        newChart = mkReflectivityChartPanel();
        mlabMkCharts.setRefChart(newChart);
        refPanel = iFramePlots.getReflectivityPanel();
        %refPanel = iFramePlots.getJPanel1;
        panelSize = refPanel.getSize();
        
        oldPlot = refPanel.getComponent(0);
        refPanel.remove(oldPlot);
        
        refPanel.add(newChart);
        newChart.setSize(panelSize);
        refPanel.validate();
end

setappdata(0,'myCharts',mlabMkCharts);
setappdata(0,'problem',problem);

