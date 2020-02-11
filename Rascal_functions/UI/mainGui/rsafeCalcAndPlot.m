function rsafeCalcAndPlot()

% persistent calculating

% if (calculating == 1)
%     return
% end
% calculating = 1;
reflectivity_calculation();
rJavaUpdatePlots();
%drawnow;
% calculating = 0;

