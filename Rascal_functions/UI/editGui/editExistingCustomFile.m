function editExistingCustomFile(src,ev)


allPanels = getappdata(0,'allPanels');
mainPanel = allPanels.generalPanel;
nameBox = mainPanel.getCustomFileTextField();
name = char(nameBox.getText);
string = ['edit ' name];
try
    eval(string);
catch
    addInfoText('The file could not be opened');
end
