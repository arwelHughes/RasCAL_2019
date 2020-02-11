desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
hContainer = desktop.addGroup('myGroup');

h1 = figure('Name','Test1','Visible','off','MenuBar','none','ToolBar','none');
h2 = figure('Name','Test2','Visible','off','MenuBar','none','ToolBar','none');
h3 = figure('Name','Test1','Visible','off','MenuBar','none','ToolBar','none');
h4 = figure('Name','Test2','Visible','off','MenuBar','none','ToolBar','none');

allFigs = [h1, h2, h3, h4];
dock(h1, 'myGroup');
dock(h2, 'myGroup');
dock(h3, 'myGroup');
dock(h4, 'myGroup');


desktop.showGroup('myGroup',true)

set(h1,'Visible','on')
set(h2,'Visible','on')
set(h3,'Visible','on')
set(h4,'Visible','on')
