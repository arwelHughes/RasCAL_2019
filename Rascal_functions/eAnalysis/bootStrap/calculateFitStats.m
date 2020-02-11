function calculateFitStats(src,ev)


addInfoText('')
addInfoText('')
addInfoText('Attempting to Estimate parameter uncertainties from the gradients');
addInfoText('around the selected parameters. Please wait...');
addInfoText('')
addInfoText('')


problem = getappdata(0,'problem'); 
originalProblem = problem;
problem = updateChecksStatus(problem);
problem = packparams(problem);
problem.bestPars = problem.fitpars;
setappdata(0,'problem',problem);

fitpars = problem.fitpars;
scaledPars = fitpars./fitpars;

addInfoText('Calculating Hessian...');
[hess,b]=hessian_test(@calcThisChi,scaledPars);

addInfoText('Obtaining Eigenvalues and vectors...');
[e,d] = eig(hess);

addInfoText('Calculating Covariance Matrix...');
cov = inv(hess);

addInfoText('Calculating Correlation Matrix...');
for i = 1:length(fitpars)
    for j = 1:length(fitpars);
        cM(i,j) = cov(i,j) / sqrt(cov(i,i)*cov(j,j));
    end
end

addInfoText('Calculating standard error...');
e1 = diag(cov);
err = sqrt(e1);
err = err' .* fitpars;
problem.fiterrs = err;

setappdata(0,'problem',originalProblem);


%Populate the tables....
window = getappdata(0,'errorsWindow');
statsPanel = window.getErrorStatsPanel1();

hessianTable = makeHessianTable(hess,problem);
hessScrollPane = statsPanel.getHessScrollPane();
hessScrollPane.add(hessianTable);
hessScrollPane.setViewportView(hessianTable);

covarianceTable = makeCovarianceTable(cov,problem);
covScrollPane = statsPanel.getCovScrollPane();
covScrollPane.add(covarianceTable);
covScrollPane.setViewportView(covarianceTable);

correlationTable = makeCorrelationTable(cM,problem);
corrScrollPane = statsPanel.getCorrScrollPane();
corrScrollPane.add(correlationTable);
corrScrollPane.setViewportView(correlationTable);

errorTable = makeStdErrorTable(problem);
errorPane = statsPanel.getErrScrollPane();
errorPane.add(errorTable);
errorPane.setViewportView(errorTable);


allCalcResults.hess = hess;
allCalcResults.cov = cov;
allCalcResults.cM = cM;
allCalcResults.fiterrs = err;

setappdata(0,'allCalcResults',allCalcResults);
% eigenvalsTable = makeCorrelationTable(cM,problem);
% eigenvalsScrollPane = statsPanel.getCorrScrollPane();
% eigenvalsScrollPane.add(correlationTable);
% eigenvalsScrollPane.setViewportView(correlationTable);




end

%--------------------------------------------------------------------------

function thisVal = calcThisChi(x0);



problem = getappdata(0,'problem');
bestPars = problem.bestPars;

oldProblem = problem;
problem.fitpars = x0.*bestPars;

problem = unpackparams(problem);
setappdata(0,'problem',problem);
reflectivity_calculation;
problem = getappdata(0,'problem');
thisVal = problem.calculations.sum_chi;

setappdata(0,'problem',oldProblem);


end
%------------------------------------------------------------------------


function table = makeHessianTable(hess,problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = problem.fitNames;
H = {' '};
for i = 1:length(headings);
    H{i+1} = headings{i};
end

%Vals = hess;
rows = size(hess,1);
columns = size(hess,2);

for n = 1:rows
    Vals(n,1) = H(n+1);
    for m = 1:columns;
        Vals{n,m+1} = hess(n,m);
    end
end

model = DefaultTableModel(Vals,H);
table = JTable(model);

for i = 1:columns
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end

end

%-------------------------------------------------------------------------

function table = makeCorrelationTable(corr,problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = problem.fitNames;
H = {' '};
for i = 1:length(headings);
    H{i+1} = headings{i};
end

%Vals = hess;
rows = size(corr,1);
columns = size(corr,2);

for n = 1:rows
    Vals(n,1) = H(n+1);
    for m = 1:columns;
        Vals{n,m+1} = corr(n,m);
    end
end

model = DefaultTableModel(Vals,H);
table = JTable(model);

for i = 1:columns
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end

end


%------------------------------------------------------------------------

function table = makeCovarianceTable(cov,problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = problem.fitNames;
H = {' '};
for i = 1:length(headings);
    H{i+1} = headings{i};
end

rows = size(cov,1);
columns = size(cov,2);

for n = 1:rows
    Vals(n,1) = H(n+1);
    for m = 1:columns;
        Vals{n,m+1} = cov(n,m);
    end
end

model = DefaultTableModel(Vals,H);
table = JTable(model);

for i = 1:columns
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end

end


%--------------------------------------------------------------------------


function table = makeStdErrorTable(problem)

import javax.swing.table.DefaultTableModel;
import javax.swing.JTable;

headings = {'Parameter'  'Value'  'Std Err'};


rows = size(problem.fiterrs,2);

for n = 1:rows
    Vals{n,1} = problem.fitNames{n};
    Vals{n,2} = problem.fitpars(n);
    Vals{n,3} = problem.fiterrs(n);
end

model = DefaultTableModel(Vals,headings);
table = JTable(model);

for i = 1:2
    aColumn = table.getColumnModel().getColumn(i);
    rend = numberTableCellRenderer();
    aColumn.setCellRenderer(rend);
end

end