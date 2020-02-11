function shiftsAddButtonCallback(src,ev)

theTable = getappdata(0,'editGuiShiftsTable');
numberOfAddedShifts = getappdata(0,'numberOfAddedShifts');
shiftsNamesList = getappdata(0,'shiftsNamesList');
theModel = theTable.getModel();

newRowName = ['Qz shift ' num2str(numberOfAddedShifts)];
newRow = {newRowName , -0.001 , 0 , 0.001};
theModel.addRow(newRow);
addToAllContrastShiftsCombos(newRowName);
shiftsNamesList{end+1} = newRowName;

setappdata(0,'editGuiShiftsTable',theTable);
setappdata(0,'numberOfAddedShifts',numberOfAddedShifts+1);
setappdata(0,'shiftsNamesList',shiftsNamesList);


