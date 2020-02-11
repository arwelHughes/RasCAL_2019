function addLayersButtonCallback(src,ev)

problem = getappdata(0,'problem');
layersNamesList = getappdata(0,'layersNamesList');

try
    numberOfAddedLayers = problem.numberOfAddedLayers;
catch
    problem.numberOfAddedLayers = length(layersNamesList) + 1;
    numberOfAddedLayers = problem.numberOfAddedLayers;
end
    
items = getappdata(0,'layersTableItems');
table = items.table;
cBox = items.cBox;
name = ['New Layer ' num2str(numberOfAddedLayers)];
model = table.getModel();
rowData = { name , '' , '' , '', '' , 'bulk out'};
model.addRow(rowData);
problem.numberOfAddedLayers = numberOfAddedLayers + 1;
contrastLayersTableBoxAddItem(name);
layersNamesList{end+1} = name;

setappdata(0,'problem',problem);
setappdata(0,'layersNamesList',layersNamesList);

end

%__________________________________________________________________________
