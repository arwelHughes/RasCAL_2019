function checkResampleCallback(src,ev)

disp('debug');

problem = getappdata(0,'problem');
visible = getappdata(0,'resampleCheckVisible');
panel = getappdata(0,'resampleOptionsPanel');
resamFig = getappdata(0,'resampleCheckFigure');

if ~visible || isempty(visible) %|| ~isnumeric(resamFig)
    resamFig = figure('Name','Resampling Check','DockControls','off',...
         'MenuBar','none','NumberTitle','off','ToolBar','figure',...
         'CloseRequestFcn',@resampFigClosereq);
    clf;
    hold on;
    setappdata(0,'resampleCheckVisible',true);
    setappdata(0,'resampleCheckFigure',resamFig);
else
    figure(resamFig);
    clf;
    hold on;
end

values.Nlayers = str2double(panel.getResNLayersTextfield().getText);
values.angle = str2double(panel.getResAngleTextField().getText);

makeCheckResamplePlot(resamFig,problem,values);
% slds = problem.calculations.slds;
% 
% numberOfContrasts = problem.numberOfContrasts;
% for i = 1:numberOfContrasts
%     thisContrast = slds{i};
%     plot(thisContrast(:,1),thisContrast(:,2),'k-');
% end


end