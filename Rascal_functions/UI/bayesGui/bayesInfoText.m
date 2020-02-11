function bayesInfoText(text)

textArea = getappdata(0,'bayesTextField');

if ~isempty(textArea)
    textArea.append(sprintf([text '\n']));
    textArea.setCaretPosition(textArea.getDocument().getLength());
end


end