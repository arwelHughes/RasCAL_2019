close all
h = tableFig();
handles = guihandles(h);
panel = handles.uipanel2;
% 
headers = {'Param', 'Best', 'Mean', '95% CI', '65% CI', '25% CI'};  

data = {1,2,3,'1,2','3,4','5,6' ; ...
    1,2,3,4,5,6};
mtable = createTable (panel, headers, data, false); 

set(h,'resize','on');
