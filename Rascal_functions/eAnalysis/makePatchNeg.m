function h = makePatchNeg(x,y,minCurve,maxCurve,col)


%if any lb regions are negative, set them to same
%as previous point
% sumOver = 1;
% while any(find(minCurve<0))
%     negs = find(minCurve<0);
%     for n = 1:length(negs);
%         if (negs(n) < (length(minCurve)+sumOver))
%                 minCurve(negs(n)) = (minCurve(negs(n)-sumOver) + minCurve(negs(n)+sumOver))/2;
%         elseif (negs(n) == length(minCurve))
%             minCurve(negs(n)) = minCurve(negs(n)-sumOver);
%         end
%     end
%     sumOver = sumOver + 1;
% end

yp = [minCurve',fliplr(maxCurve')];
xp = [x',fliplr(x')];

patchSaturation = 0.85;
patchColor = col+(1-col)*(1-patchSaturation);
set(gcf,'renderer','opengl')

h1 = patch(xp,yp,1,'facecolor',patchColor,'edgecolor',patchColor,'facealpha',0.3);
%set(h1,'facealpha',0.75);
 h = plot(x,y,'k-');
 set(h,'LineWidth',1.5)
% set(h,'Color',col);

set(gca,'Box','on');


end

