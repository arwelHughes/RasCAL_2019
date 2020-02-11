function rSelectSimplex(src,ev)

problem = getappdata(0,'problem');
problem.algorithm = 'simplex';

label = getappdata(0,'algBox');
label.setText('simplex');

setappdata(0,'problem',problem);


