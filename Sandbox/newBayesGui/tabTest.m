fig = figure('Visible',false);

tg = uitabgroup('Parent',fig);


mainTab = uitab(tg,'Title','Main Tab');
plotsTab = uitab(tg,'Title','Plots Tab');

mainPanel = javaObjectEDT(MainBayesPanel);
javacomponent(mainPanel,java.awt.BorderLayout.NORTH,mainTab);

set(fig,'visible',true);


