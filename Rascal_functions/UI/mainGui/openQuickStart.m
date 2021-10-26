function openQuickStart(src,ev)

rascalPath = getappdata(0,'rascalPath');
dir = fullfile(rascalPath,'Doc');

comp = computer;
if ~strcmp(comp,'GLNXA64')
    open(fullfile(dir,'RasCAL Quick Start Guide.pdf'));
else
    !gnome-open 'RasCAL Quick Start Guide.pdf'
end