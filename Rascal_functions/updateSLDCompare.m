function updateSLDCompare(problem);


prevSLDs = getappdata(0,'prevSLDS');
theseSLDs = problem.calculations.slds;

colours = ['r' 'g' 'm' 'b' 'g' 'r' 'g' 'm' 'b' 'g'];

figure(2);
clf
hold on
for i = 1:6;
    ps = prevSLDs{i};
    plot(ps(:,1),ps(:,2),[colours(i) ':']);
    ts = theseSLDs{i};
    plot(ts(:,1)+25,ts(:,2),[colours(i) '-']);
end
hold off
drawnow
