function setRois



problem = getappdata(0,'problem');



rois = [1 2 0.03 0.055 5

];


problem.calculations.rois = rois;


setappdata(0,'problem',problem);

%

