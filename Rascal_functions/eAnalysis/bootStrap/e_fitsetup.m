function [problem,out] = e_fitsetup(problem);

if ~any(problem.dataPresent)
    addInfoText('No data present!');
    out{1} = 'fail';
    return
end

UndoRedoSetup(problem);
problem = updateChecksStatus(problem);

% clearInfoText;
% 
% lockMainGuiFrame();
% disableMenus();

miBox = getappdata(0,'IterBox');
maxiter = miBox.getText;

maxiter = str2num(maxiter);
tolerance = 1e-7;

problem.update = 100;
problem.update_params = 0;
problem.maxiter = maxiter;
%problem.tolerance = tolerance;

%Check the bounds on all the selected
out = checkBounds(problem);
if strcmp(out{1},'fail')
%     unlockMainGuiFrame();
%     enableMenus();
    return
end

%And assign the fitting parameters according to checks
problem = packparams(problem);

