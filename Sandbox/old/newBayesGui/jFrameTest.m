import javax.swing.*

frame = JFrame;
frame.setSize(400,400);

pane = JTabbedPane();

frame.getContentPane.add(pane);

panel1 = JPanel();
panel2 = JPanel();

pane.addTab('Panel 1', panel1);
pane.addTab('Panel 2', panel2);


frame.setVisible(true)

a = ones(10,1);
b = ones(10,1);

a = arrayfun(@(x)rand*x,a);
b = arrayfun(@(x)rand*x,b);

hFig = figure; 
plot(a,b);

%Get underlying Jave JFrame handle
mjf = get(handle(hFig), 'JavaFrame');
jWindow = mjf.fHG2Client.getWindow;

%Get content pane handle
mjc = jWindow.getContentPane;
mjr = jWindow.getRootPane;

% Create a new pure-Java undecorated JFrame
figTitle = jWindow.getTitle;
jFrame = javaObjectEDT(javax.swing.JFrame(figTitle));
jFrame.setUndecorated(true);

% Move the JFrame's on-screen location just on top of the original
jFrame.setLocation(mjc.getLocationOnScreen);

% Set the JFrame's size to the Matlab figure's content size
%jFrame.setSize(mjc.getSize);  % slightly incorrect by root-pane's offset
jFrame.setSize(mjc.getWidth+mjr.getX, mjc.getHeight+mjr.getY);


% Reparent (move) the contents from the Matlab JFrame to the new JFrame
jFrame.setContentPane(mjc);
 
% Make the new JFrame visible
jFrame.setVisible(true);
 
% Hide the Matlab figure by moving it off-screen
pos = get(hFig,'Position');
set(hFig, 'Position',[-1000,-1000,pos(3:4)]);
drawnow;

