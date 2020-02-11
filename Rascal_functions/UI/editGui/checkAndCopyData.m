function out = checkAndCopyData(dataPath,projectPath);

disp('Debug!');
out = [];
%This needs to....
%1. Find the specified data file and try to load it in
%2. Check to see whether the /dataFiles directroy exists
%3. If not. Make this directory
%4. Copy the datafile to there...

%1.
data = [];
try
    [header,thisFile] = hdrload(dataPath);
    l = size(thisFile,1);
    for i = 1:l;
        thisLine = thisFile(i,:);
        if thisLine(2) ~= 0
            data = [data ; thisLine(1:3)];
        end
    end

catch
    out{1} = 'fail';
    out{2} = 'the datafile could not be read';
    return
end

slashes = findstr(dataPath,'\');
fname = dataPath(slashes(end)+1:end);
savePath = [projectPath '\dataFiles\' fname];

 try
     dlmwrite(savePath,data);
 catch
    out{1} = 'fail';
    out{2} = 'the datafile could not be copied to dataFiles dir';
 end
 
 out{1} = 'ok';

