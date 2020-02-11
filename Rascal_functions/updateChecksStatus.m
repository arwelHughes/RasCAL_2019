function problem = updateChecksStatus(problem)

problem.fityesno = paramsTableGetChecked();
problem.backgrounds_fityesno = backsTableGetChecked();
problem.scalefac_fityesno = scalesTableGetChecked();
problem.shifts_fityesno = shiftsTableGetChecked();
problem.nbairs_fityesno = nbairsTableGetChecked();
problem.nbsubs_fityesno = nbsubsTableGetChecked();
problem.resolution_fityesno = resolutionTableGetChecked();
%problem.include_data = contrastsGetIncluded();

