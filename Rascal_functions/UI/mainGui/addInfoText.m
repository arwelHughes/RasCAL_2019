function addInfoText(text)

textArea = getappdata(0,'textArea');
if isequal(class(textArea),'javax.swing.JTextArea')
    textArea = javaObjectEDT(textArea);
end
if ~isempty(textArea)
    textArea.append(sprintf([text '\n']));
    textArea.setCaretPosition(textArea.getDocument().getLength());
end
drawnow limitrate;