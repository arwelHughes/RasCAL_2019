function rJavaUpdatePlots();

problem = getappdata(0,'problem');
chiBox = getappdata(0,'valChiSq');

%Update the figures...
updateTheGraphs();

%Put Chi Squared value in correct box on MDI
thisChi = problem.calculations.sum_chi;
chiBox.setText(num2str(thisChi));


setappdata(0,'problem',problem);
