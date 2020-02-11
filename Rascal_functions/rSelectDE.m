function rSelectDE(src,ev)

problem = getappdata(0,'problem');
problem.algorithm = 'DE';

label = getappdata(0,'algBox');
label.setText('Differential Evolution');

setappdata(0,'problem',problem);
