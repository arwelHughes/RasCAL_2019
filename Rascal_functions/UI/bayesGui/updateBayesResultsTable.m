function updateBayesResultsTable(bestRef,intervals,bayesFigHandle)


disp('');

values95 = intervals.intervals_95;
values65 = intervals.intervals_65;
values25 = intervals.intervals_25;

bayesResultsTable = getappdata(0,'mainBayesResultsTable');
bayesTableModel = bayesResultsTable.getModel();

rows = length(bestRef);

for r = 1:rows
    bayesTableModel.setValueAt(bestRef(r),r-1,1)
    
    this95 = sprintf('[%1.3d, %1.3d]',values95(r,1), values95(r,2));
    bayesTableModel.setValueAt(this95,r-1,2);
    
    this65 = sprintf('[%1.3d, %1.3d]',values65(r,1), values65(r,2));
    bayesTableModel.setValueAt(this65,r-1,3);
    
    this25 = sprintf('[%1.3d, %1.3d]',values25(r,1), values25(r,2));
    bayesTableModel.setValueAt(this25,r-1,4);

end











end