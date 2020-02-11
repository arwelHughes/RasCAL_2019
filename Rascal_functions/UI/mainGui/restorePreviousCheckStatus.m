function restorePreviousCheckStatus

problem = getappdata(0,'problem');
paramsTable = getappdata(0,'mainGuiParamsTable');
pTableModel = paramsTable.getModel;

backsTable = getappdata(0,'mainGuiBacksTable');
bTableModel = backsTable.getModel;

scalesTable = getappdata(0,'mainGuiScalesTable');
sTableModel = scalesTable.getModel;

shiftsTable = getappdata(0,'mainGuiShiftsTable');
shiftTableModel = shiftsTable.getModel;

nbairTable = getappdata(0,'mainGuiNbasTable');
nbairTableModel = nbairTable.getModel;

nbsubTable = getappdata(0,'mainGuiNbssTable');
nbsubTableModel = nbsubTable.getModel;

resolTable = getappdata(0,'mainGuiResolutionTable');
resolTableModel = resolTable.getModel;


checkStatus = getappdata(0,'checkStatus');

parChecksStatus = checkStatus.params;
for i = 1:length(problem.paramnames);
    thisPar = problem.paramnames(i);
    for n = 1:length(parChecksStatus);
        thisComparison = parChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(pTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end

backsChecksStatus = checkStatus.backs;
for i = 1:length(problem.backsNames);
    thisPar = problem.backsNames(i);
    for n = 1:length(backsChecksStatus);
        thisComparison = backsChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(bTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end

scalesChecksStatus = checkStatus.scales;
for i = 1:length(problem.scalesNames);
    thisPar = problem.scalesNames(i);
    for n = 1:length(scalesChecksStatus);
        thisComparison = scalesChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(sTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end

shiftsChecksStatus = checkStatus.shifts;
for i = 1:length(problem.shiftsNames);
    thisPar = problem.shiftsNames(i);
    for n = 1:length(shiftsChecksStatus);
        thisComparison = shiftsChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(shiftTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end


nbairChecksStatus = checkStatus.nbairs;
for i = 1:length(problem.nbaNames);
    thisPar = problem.nbaNames(i);
    for n = 1:length(nbairChecksStatus);
        thisComparison = nbairChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(nbairTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end

nbsubChecksStatus = checkStatus.nbsubs;
for i = 1:length(problem.nbsNames);
    thisPar = problem.nbsNames(i);
    for n = 1:length(nbsubChecksStatus);
        thisComparison = nbsubChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(nbsubTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end

resolChecksStatus = checkStatus.resol;
for i = 1:length(problem.resolNames);
    thisPar = problem.resolNames(i);
    for n = 1:length(resolChecksStatus);
        thisComparison = resolChecksStatus{n};
        if strcmp(thisPar,thisComparison(1));
            awtinvoke(resolTableModel,'setValueAt',java.lang.Boolean(thisComparison{2}),i-1,0);
        end
    end
end



