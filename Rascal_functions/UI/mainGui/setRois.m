function setRois



problem = getappdata(0,'problem');



rois = [0 1 0.05 0.144 8;
        0 1 0.026 0.043 35;
        1 2 0.12 0.16 8;
        1 2 0.035 0.08 7
        1 3 0.08 0.17 20 ;
        1 3 0.025 0.054 5
        1 4 0.101 0.2 55;
        1 5 0.035 0.07 7;
        1 5 0.1023 0.175 10;
        1 6 0.02 0.07 7;

];


problem.calculations.rois = rois;


setappdata(0,'problem',problem);

%

