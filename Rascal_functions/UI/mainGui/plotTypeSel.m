function plotTypeSel(src,ev)

import javax.swing.*;
import java.awt.*;

problem = getappdata(0,'problem');

which = get(src,'ActionCommand');
switch which
    case 'Lin'
        problem.plotType = 0;
    case 'Semilog'
        problem.plotType = 1;
    case 'Log-log'
        problem.plotType = 2;
    otherwise
        addInfoText('Oops! Unrecognised plot type! Setting to semilog');
        problem.plotType = 1;
end

setappdata(0,'problem',problem);

fr = getappdata(0,'iframePlots');
fitChart = rJavaReflMakePlot();
sldChart = rJavaSLDMakePlot();
panel = JPanel(GridLayout());
panel.add(fitChart);
panel.add(sldChart);
fr.setContentPane(panel);
%fr.update();
% setappdata(0,'myCharts',fitChart);
% setappdata(0,'mySLDCharts',sldChart);
