function openQuickStart(src,ev)

rascalPath = getappdata(0,'rascalPath');
dir = fullfile(rascalPath,'Rascal_functions/docs');
open(fullfile(dir,'RasCAL Quick Start Guide.pdf'));