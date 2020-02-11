function blockPlot(x,y)

xpos = -0.5;
for i = 1:length(x);
    thisLayer = [x(i) y(i)];
    plot([xpos xpos],[0 thisLayer(2)],'k:');
    plot([xpos xpos+thisLayer(1)],[thisLayer(2) thisLayer(2)],'k:');
    plot([xpos+thisLayer(1) xpos+thisLayer(1)],[thisLayer(2) 0],'k-');
    xpos = xpos + thisLayer(1);
end
    
    
end