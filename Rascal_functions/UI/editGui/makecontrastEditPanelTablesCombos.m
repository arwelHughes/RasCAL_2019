function makecontrastEditPanelTablesCombos(problem)

import javax.swing.JComboBox;

bulkInComboBox = JComboBox();
bulkOutComboBox = JComboBox();
layersComboBox = JComboBox();

layers = problem.layersDetails;
numberOfLayers = problem.numberOfLayers;

for i = 1:numberOfLayers
    layersComboBox.addItem(java.lang.String(layers{i}(5)));
end


nba = problem.nbaNames;
for i = 1:length(nba)
    bulkInComboBox.addItem(java.lang.String(nba{i}));
end

nbs = problem.nbsNames;
for i = 1:length(nbs)
    bulkOutComboBox.addItem(java.lang.String(nbs{i}));
end

contrastEditPanelTablesCombos.bulkIn = bulkInComboBox;
contrastEditPanelTablesCombos.bulkOut = bulkOutComboBox;
contrastEditPanelTablesCombos.layers = layersComboBox;


setappdata(0,'contrastEditPanelTablesCombos',contrastEditPanelTablesCombos);

end
%__________________________________________________________________________

