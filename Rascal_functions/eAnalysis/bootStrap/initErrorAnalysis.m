function initErrorAnalysis(src,ev)

disableMenus();

problem = getappdata(0,'problem');
desktop = getappdata(0,'desktop');

if ~any(problem.dataPresent)
    addInfoText('No data present!');
    out{1} = 'fail';
    return
end

window = awtcreate('ErrorsAnalysisWindow');
desktop.add(window);
window.setVisible(true);
window = makeMonovariateTab(problem,window);
window = initBootstrapWindow(problem,window);

okButton = window.getOkButton();
set(okButton,'ActionPerformedCallback',@errorWinOkButtonPressed);

calcStatsButton = window.getCalcStatsButton();
set(calcStatsButton,'ActionPerformedCallback',@calculateFitStats);

export = window.getExportResultsButton();
set(export,'ActionPerformedCallback',@exportFitStats);

window.setSize(600,600);
setappdata(0,'errorsWindow',window);

setappdata(0,'allThebsParVals',[]);

end

%--------------------------------------------------------------------------

function errorWinOkButtonPressed(src,ev)

enableMenus();
window = getappdata(0,'errorsWindow');
window.dispose;
rJavaUpdatePlots();

end

%--------------------------------------------------------------------------

function exportFitStats(src,ev)

import javax.swing.JFileChooser;
import javax.swing.JInternalFrame;

desktop = getappdata(0,'desktop');

expFileWindow = JInternalFrame();
expFileWindow.setSize(500,400);
expFileWindow.setTitle('Export Bootstrap Results');
expFileWindow.setMaximizable(false);
expFileWindow.setIconifiable(true);
expFileWindow.setClosable(false);
expFileWindow.setResizable(false);
setappdata(0,'FileDialogContainer',expFileWindow);

chooser = JFileChooser(pwd);

filter = ExampleFileFilter('bs');
filter.setDescription('Rascal Bootstrap Results');
chooser.addChoosableFileFilter(filter);
chooser.setDialogType(JFileChooser.SAVE_DIALOG);
set(chooser,'ActionPerformedCallback',@saveFitStatsCallback);
expFileWindow.add(chooser);

desktop.setLayer(expFileWindow,3);
desktop.add(expFileWindow);
expFileWindow.setLocation(200,200);


end



function saveFitStatsCallback(src,ev)

problem = getappdata(0,'problem');


switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end


fr = getappdata(0,'FileDialogContainer');
whatHappened= get(src,'ActionPerformedCallbackData');
if strcmp(get(whatHappened, 'ActionCommand') ,'CancelSelection') == 1;
    fr.dispose();
    return
end

MPcomponents = getappdata(0,'MPComponents');

thisFile = get(src,'SelectedFile');
path = char(thisFile.getPath);


addInfoText('Saving Bootstrap Parameters and SLDs, and fit statistics..');
bsResults  = getappdata(0,'bsResults'); 
name = [char(thisFile) '_bootStrapResults.mat'];
save(name,'bsResults');


fr.dispose

end




