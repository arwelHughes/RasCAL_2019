function expParamsPanel = mainExpParamsSetup()

problem = getappdata(0,'problem');

expParamsPanel = javaObjectEDT(mainGuiExpDetails());
internalPanel = javaObjectEDT(expParamsPanel.getMainGuiExpDetailsPanel1());

%backs
backsScrollPane = javaObjectEDT(internalPanel.getBackScrPane());
backsTable = mainGuiBacksTableSetup(problem);
backsScrollPane.setViewportView(backsTable);

%scalefacs
scalesScrollPane = javaObjectEDT(internalPanel.getScalefacScrPane());
scalesTable = mainGuiScalesTableSetup(problem);
scalesScrollPane.setViewportView(scalesTable);

%shifts
shiftsScrollPane = javaObjectEDT(internalPanel.getShiftScrPane());
shiftsTable = mainGuiShiftsTableSetup(problem);
shiftsScrollPane.setViewportView(shiftsTable);

%Nbas
nbasScrollPane = javaObjectEDT(internalPanel.getNbInScrPane());
nbasTable = mainGuiNbInTableSetup(problem);
nbasScrollPane.setViewportView(nbasTable);

%Nbs's
nbssScrollPane = javaObjectEDT(internalPanel.getNbOutScrPane());
nbssTable = mainGuiNbOutTableSetup(problem);
nbssScrollPane.setViewportView(nbssTable);

%Resols...
resolScrollPane = javaObjectEDT(internalPanel.getResolutionScrollPane());
resolTable = mainResolutionTableSetup(problem);
resolScrollPane.setViewportView(resolTable);

%_________________________________________________________________________

