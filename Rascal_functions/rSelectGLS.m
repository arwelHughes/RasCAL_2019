function rSelectGLS(src,ev)

problem = getappdata(0,'problem');
problem.algorithm = 'MCS';

label = getappdata(0,'algBox');
label.setText('Global Line Search');

setappdata(0,'problem',problem);