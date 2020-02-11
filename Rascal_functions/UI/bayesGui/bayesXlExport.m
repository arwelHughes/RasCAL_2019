function bayesXlExport(filename)

disp(class(filename));
filename = char(filename);
disp(class(filename));

%Get the Bayes output...
output = getappdata(0,'bayesOutput');

data = output.data;
bestRef = output.bestRefs;
refBounds = output.refBounds;
sldBounds = output.sldBounds;
bestSld = output.bestSlds;
names = output.names;

colHeadersRef = {'Data X','Data Y','Data Z','Best Fit','Ref Min','Ref Max'};
colHeadersSld = {'SLD X','SLD Y','SLD Min','SLD Max'};
numberOfContrasts = length(data);

for i = 1:numberOfContrasts
    try
        thisSheet = ['Sheet' num2str(i+1)];
        xlswrite(filename,colHeadersRef,thisSheet,'A1');
        xlswrite(filename,data{i},thisSheet,'A2');
        xlswrite(filename,bestRef{i}(:,2),thisSheet,'D2');
        xlswrite(filename,refBounds{1}{i},thisSheet,'E2');
        xlswrite(filename,refBounds{2}{i},thisSheet,'F2');
        xlswrite(filename,colHeadersSld,thisSheet,'H1');
        xlswrite(filename,bestSld{i},thisSheet,'H2');
        xlswrite(filename,sldBounds{1}{i},thisSheet,'J2');
        xlswrite(filename,sldBounds{1}{i},thisSheet,'K2');
    catch
        disp('Error!');
    end
end
nextSheet = i+2;



xlswrite(filename,['Best Chi'],'Sheet1','A1')
xlswrite(filename,output.bestChi,'Sheet1','B1')

vals = calcLimits(output.chain,output.results,output.names);
xlswrite(filename,vals','Sheet1','C3');

titles = {};
hists = [];
count = 1;
for i = 1:length(output.names)
   thisPar = output.chain(:,i);
   [N,X] = hist(thisPar,30);
   titles{count} = sprintf('Hist %1.1d X',i);
   titles{count+1} = sprintf('Hist %1.1d Y',i);
   hists(:,count) = X(:);
   hists(:,count+1) = N(:);
   count = count + 2;
end

xlswrite(filename,titles,['Sheet' num2str(nextSheet)],'A1')
xlswrite(filename,hists,['Sheet' num2str(nextSheet)],'A2')

    
end






