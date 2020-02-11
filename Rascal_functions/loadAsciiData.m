function [problem,out] = loadAsciiData(problem,i);

out{1} = 'fail';

switch computer
    case {'PCWIN','PCWIN64'}
        sep = '\';
    otherwise
        sep = '/';
end

if strcmp(problem.path(end),sep)
    dataPath = [problem.path 'dataFiles' sep];
else
    dataPath = [problem.path sep 'dataFiles' sep];
end

thisFile = problem.contrastFiles{i};
thisFullName = [dataPath thisFile];

if (exist(thisFullName,'file') ~= 0) && (problem.forceReload(i) == 0)
    addInfoText([thisFile '  exists in data directory. Loading']);
    try
        data = dlmread(thisFullName);
    catch
        out{1} = 'fail';
        addInfoText(['There was an error loading ' thisFile ' from data directory. Please check']);
        addInfoText(['Changing contrast to Simulation']);
        problem = changeContrastToSimulation(problem,i);
        return
    end
    data = makeErrorBarsNonZero(data);
    problem.data{i} = data;
    problem.include_data(i) = 1;
    problem.dataPresent(i) = 1;
    if problem.dataLimits{i}(1) < data(1,1)
        problem.dataLimits{i}(1) = data(1,1);
    end
    if problem.dataLimits{i}(2) > data(end,1);
        problem.dataLimits{i}(2) = data(end,1);
    end
    if problem.simLimits{i}(1) > data(1,1);
        problem.simLimits{i}(1) = data(1,1);
    end
    if problem.simLimits{i}(2) < data(end,1);
        problem.simLimits{i}(2) = data(end,1);
    end
    out{1} = 'ok';
    return
elseif (exist(thisFullName,'file') == 0) && (problem.forceReload(i) == 0)
    addInfoText([thisFile '  absent from data directory.']);
end

originalPath = problem.datapath{i};
newFullName = fullfile(originalPath,thisFile);
slashes = findstr(newFullName,sep);
newFullNameForPrint = newFullName;
newFullNameForPrint(slashes) = '/';
addInfoText(['Trying to locate ' newFullNameForPrint]);

if ~exist(newFullName,'file')
    addInfoText(sprintf('File not found. Contrast %d changed to "Simulation"',i));
    problem = changeContrastToSimulation(problem,i);
    out{1} = 'fail';
    return
else
    thisFileType = problem.contrastFileTypes(i);
    switch thisFileType
        case 1
            addInfoText(['Attempting to load ' newFullNameForPrint ' as 3 column ASCII with single line header']);
            try
                [header,thisData] = hdrload(newFullName);
                thisData = makeErrorBarsNonZero(thisData);
                l = size(thisData,1);
                data = [];
                for n = 1:l;
                    thisLine = thisData(n,:);
                    if thisLine(2) ~= 0
                        data = [data ; thisLine(1:3)];
                    end
                end
                problem.data{i} = data;
                problem.include_data(i) = 1;
                problem.dataPresent(i) = 1;
                if problem.dataLimits{i}(1) < data(1,1)
                    problem.dataLimits{i}(1) = data(1,1);
                end
                if problem.dataLimits{i}(2) > data(end,1);
                    problem.dataLimits{i}(2) = data(end,1);
                end
                if problem.simLimits{i}(1) > data(1,1);
                    problem.simLimits{i}(1) = data(1,1);
                end
                if problem.simLimits{i}(2) < data(end,1);
                    problem.simLimits{i}(2) = data(end,1);
                end
                addInfoText('Load OK. Copying file to data directory...');
                out{1} = 'ok';
                try
                    dlmwrite(fullfile(dataPath,thisFile),data);
                    addInfoText('Copy OK.');
                catch
                    addInfoText('Copy to data directory failed. Please check permissions');
                end
            catch
                addInfoText(sprintf('Load failed. Please check file type. Contrast %d changed to "Simulation"',i));
                problem = changeContrastToSimulation(problem,i);
                out{1} = 'fail';
                return
            end
        case 0
            addInfoText(['Trying to load ' newFullNameForPrint ' as simple 3 column ascii...']);
            try
                data = dlmread(newFullName);
                data = makeErrorBarsNonZero(data);
                problem.data{i} = data;
                problem.include_data(i) = 1;
                problem.dataPresent(i) = 1;
                if problem.dataLimits{i}(1) < data(1,1)
                    problem.dataLimits{i}(1) = data(1,1);
                end
                if problem.dataLimits{i}(2) > data(end,1);
                    problem.dataLimits{i}(2) = data(end,1);
                end
                if problem.simLimits{i}(1) > data(1,1);
                    problem.simLimits{i}(1) = data(1,1);
                end
                if problem.simLimits{i}(2) < data(end,1);
                    problem.simLimits{i}(2) = data(end,1);
                end
                addInfoText('Load OK. Copying file to data directory...');
                out{1} = 'ok';
                try
                    dlmwrite(fullfile(dataPath,thisFile),data);
                    addInfoText('Copy OK.');
                catch
                    addInfoText('Copy to data directory failed. Please check permissions');
                end
            catch
                addInfoText(['Could not load ' newFullNameForPrint]);
                addInfoText(sprintf('Contrast %d changed to "Simulation"',i));
                problem = changeContrastToSimulation(problem,i);
                addInfoText('Please check file (header must be single line and start with a letter or be absent. Data must be 3 column delimited ASCII)');
                out{1} = 'fail';
                return
            end
        case 2
            addInfoText(['Trying to load ' newFullNameForPrint ' as ISIS histogram...']);
           try
                [header,thisData] = hdrload(newFullName);
                thisData = hist2xy(thisData(:,1),thisData(:,2),thisData(:,3));
                thisData = makeErrorBarsNonZero(thisData);
                l = size(thisData,1);
                data = [];
                for n = 1:l;
                    thisLine = thisData(n,:);
                    if thisLine(2) ~= 0
                        data = [data ; thisLine(1:3)];
                    end
                end
                problem.data{i} = data;
                problem.include_data(i) = 1;
                problem.dataPresent(i) = 1;
                if problem.dataLimits{i}(1) < data(1,1)
                    problem.dataLimits{i}(1) = data(1,1);
                end
                if problem.dataLimits{i}(2) > data(end,1);
                    problem.dataLimits{i}(2) = data(end,1);
                end
                if problem.simLimits{i}(1) > data(1,1);
                    problem.simLimits{i}(1) = data(1,1);
                end
                if problem.simLimits{i}(2) < data(end,1);
                    problem.simLimits{i}(2) = data(end,1);
                end
                addInfoText('Load OK. Copying file to data directory...');
                out{1} = 'ok';
                try
                    dlmwrite(fullfile(dataPath,thisFile),data);
                    addInfoText('Copy OK.');
                catch
                    addInfoText('Copy to data directory failed. Please check permissions');
                end
            catch
                addInfoText(sprintf('Load failed. Please check file type. Contrast %d changed to "Simulation"',i));
                problem = changeContrastToSimulation(problem,i);
                out{1} = 'fail';
                return
            end
    end
end
end




%__________________________________________________________________________

function newData = makeErrorBarsNonZero(data)

points = size(data,1);
newData = [];

for i = 1:points;
    thisLine = data(i,:);
    newData(i,1) = thisLine(1);
    newData(i,2) = thisLine(2);
    
    if length(thisLine) == 3;
        if thisLine(3) <= 0;
            newData(i,3) = 1e-15;
        else
            newData(i,3) = data(i,3);
        end
    elseif length(thisLine) < 3
        newData(i,3) = 1e-15;
    end
end

end

        

%__________________________________________________________________________

function problem = changeContrastToSimulation(problem,i)

    problem.contrastTypes{i} = 'Simulation';
    problem.include_data(i) = 0;
    problem.dataPresent(i) = 0;
    problem.dataLimits{i}(1) = 1e-3;
    problem.dataLimits{i}(2) = 0.5;
    problem.simLimits{i}(1) = 1e-3;
    problem.simLimits{i}(2) = 0.5;
    
end




                
                