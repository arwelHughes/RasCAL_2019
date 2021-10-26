function desktop = makeMainWindows(desktop,problem);

import javax.swing.*;
import java.awt.*;

%Make the main gui and main Plotting Window...
desktop = SetupPlotsAndMainGuiWindows(desktop,problem);

%...and main Control Window.
hourglassBusy = getappdata(0,'hourglassBusy');
stopIcon = getappdata(0,'stopIcon');
readyIcon = getappdata(0,'readyIcon');
%iframeMainControl = awtcreate('iframeMainControls','Ljavax.swing.ImageIcon;Ljavax.swing.ImageIcon;Ljavax.swing.ImageIcon;',hourglassBusy,stopIcon,readyIcon);
iframeMainControl = javaObjectEDT(iframeMainControls(hourglassBusy, stopIcon, readyIcon));
panel = javaObjectEDT(iframeMainControl.getMainControlsPanel1());
runFitButton = javaObjectEDT(panel.getRunFitButton());
stopFitButton = javaObjectEDT(panel.getStopFitButton());
algBox = javaObjectEDT(panel.getAlgBox());
valChiSq = javaObjectEDT(panel.getValChiSq());
maxIterBox = javaObjectEDT(panel.getMaxIterVal());
statusBox = javaObjectEDT(panel.getStatusBox());
awtinvoke(panel,'changeIconToReady');
awtinvoke(statusBox,'setText','Ready');

h = handle(runFitButton,'CallbackProperties'); h = javaObjectEDT(h); set(h,'ActionPerformedCallback',{@fitcontrol});
stopFitButton.setEnabled(true);%set(stopFitButton,'Enabled','on');
setappdata(0,'IterBox',maxIterBox);
setappdata(0,'algBox',algBox);
setappdata(0,'controlsPanel',panel);
setappdata(0,'statusBox',statusBox);
setappdata(0,'controlsFrame',iframeMainControl);

desktop.setLayer(iframeMainControl,0);
desktop.add(iframeMainControl);
setappdata(0,'valChiSq',valChiSq);

%Also options dialogs
iframeFittingOptions = makeFittingOptionsFrame(problem);
iframeFittingOptions.setMaximizable(false);
iframeFittingOptions.setIconifiable(false);
iframeFittingOptions.setClosable(false);
iframeFittingOptions.setResizable(false);
iframeFittingOptions.setVisible(false);

desktop.setLayer(iframeFittingOptions,4);
desktop.add(iframeFittingOptions);
iframeFittingOptions.setVisible(false);

%7. ...finally, text Info Window.
iframeInfoPane = javaObjectEDT(JInternalFrame());
iframeInfoPane.setSize(400,200);
iframeInfoPane.setTitle('Rascal Info');
iframeInfoPane.setMaximizable(true);
iframeInfoPane.setIconifiable(true);
iframeInfoPane.setClosable(false);
iframeInfoPane.setResizable(true);
iframeInfoPane.setVisible(true);

textArea = javaObjectEDT(JTextArea(5, 20));
infoScrollPane = javaObjectEDT(JScrollPane(textArea)); 
textArea.setEditable(false);
textArea.setCaretPosition(textArea.getDocument().getLength());

iframeInfoPane.setContentPane(infoScrollPane);
desktop.add(iframeInfoPane);
setappdata(0,'textArea',textArea);
version = getVersion();
addInfoText(sprintf('Welcome to Rascal. Version %s',version));

setappdata(0,'iframeInfoPane',iframeInfoPane);

defaultPosWindows();
