function export_fits()

%Needs debugging!

problem = getappdata(0,'problem');
fname = problem.name{:};

ss = problem.shifted_data;
rr = problem.calculations.reflectivity;

number_of_datafiles  = size(ss,2);
mat = [];
point = findstr(fname,'.');
if ~isempty(point)
    prefix = fname(1:point-1);
else
    prefix = fname;
end


for i = 1:number_of_datafiles;
    thisdat = ss{i};
    thisfit = rr{i};
    thisFileName = [prefix '_curve' num2str(i) '.dat'];
    thisMat = [thisdat thisfit];
    dlmwrite(thisFileName,thisMat,'\t');
    disp(sprintf(['Writing curve %d to ' thisFileName],i));
end




% c1 = ss{1};
% f1 = rr{1};
% 
% figure(111);
% clf
% errorbar(c1(:,1),c1(:,2),c1(:,3),'bo');
% hold on
% plot(f1(:,1),f1(:,2));
% set(gca,'YScale','log');
% hold off
