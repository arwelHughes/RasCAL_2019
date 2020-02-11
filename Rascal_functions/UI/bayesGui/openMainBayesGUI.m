function openMainBayesGUI(src,ev)

disableMenus();
lockMainGuiFrame();

warning('off','MATLAB:Axes:NegativeDataInLogAxis');

problem = getappdata(0,'problem');
%bayesGuiOpen = getappdata(0,'bayesGuiOpen');
% if bayesGuiOpen == true
% 	return;
% end


%Make 'output' structure from problem....
out.chain = [];
out.names = problem.fitNames;
out.limits = problem.fitconstr;
out.results = [];
out.refBounds = [];
out.sldBounds = [];
out.bestRefs = problem.calculations.reflectivity;
out.bestSlds = problem.calculations.slds;
out.data = problem.shifted_data;

setappdata(0,'output',out);
setappdata(0,'bayesGuiOpen',true);
setappdata(0,'bayesHasRun',false);

makeMainBayesGui(out);

end
