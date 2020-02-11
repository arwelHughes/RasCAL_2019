function h = makePatch(x,y,minCurve,maxCurve,col)


yp = [minCurve',fliplr(maxCurve')];
xp = [x',fliplr(x')];

patchSaturation=0.35;
faceAlpha=patchSaturation;
patchColor=col;
set(gcf,'renderer','openGL')

patch(xp,yp,1,'facecolor',patchColor,'edgecolor',col,'facealpha',faceAlpha);

 h = plot(x,y,'k-');
% set(h,'Color',col);



end

