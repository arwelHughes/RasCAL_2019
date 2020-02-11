function rSelectMCS(src,ev)

problem = getappdata(0,'problem');
problem.algorithm = 'mcs';

label = getappdata(0,'algBox');
label.setText('mcs');

setappdata(0,'problem',problem);