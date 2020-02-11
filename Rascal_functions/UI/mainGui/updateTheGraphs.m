function updateTheGraphs()



problem = getappdata(0,'problem');
if problem.eb
    updateReflectivityErrorbarChart();
else
    updateReflectivityChart();
end
updateSLDChart();
%updateResidChart();
%updateSLDCompare(problem);