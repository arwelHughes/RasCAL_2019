function rSelectCMAES(src,ev)

problem = getappdata(0,'problem');
problem.algorithm = 'cmaes';

label = getappdata(0,'algBox');
label.setText('cmaes');

setappdata(0,'problem',problem);