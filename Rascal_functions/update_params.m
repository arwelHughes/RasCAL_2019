function [] = update_params()

%Update all the tables.

updateParamsTable();
updateBacksTable();
updateScalesTable();
updateShiftsTable();
% updateNbInTable();
% updateNbOutTable();
% updateResolutionTable();

drawnow;