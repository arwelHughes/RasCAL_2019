function ret = makeMainWindow(output,fHandle)


%Get relevant object handles...
panelHandle = findobj(fHandle,'Title','Progress');
tableHandle = findobj(fHandle,'Tag','tablePanel');


%Make the progress bar in the panel..
hBar = waitbar2a(0.0,panelHandle);


%Populate the table....
values = output.results.mean;
names = output.names;
limits = output.limits;
prior = output.results.prior;

numberOfParams = length(names);

for i = 1:numberOfParams
    d{i,1} = names{i};
    d{i,2} = values(i);
    d{i,3} = limits(i,1);
    d{i,4} = limits(i,2);
    d{i,5} = 'Gaussian';
    d{i,6} = prior(i,1);
    d{i,7} = prior(i,2);
end


%backs
tableScrollPane = internalPanel.getBackScrPane();
backsTable = mainGuiBacksTableSetup(problem);
backsScrollPane.setViewportView(backsTable);



% hTab = uitable(tableHandle,'Data',d,'ColumnFormat',columnformat,'Units','normalized');
% jScroll = findjobj(hTab);
% jTable = jScroll.getViewport.getView;
% jTable.setAutoResizeMode(jTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);

ret = 1;

