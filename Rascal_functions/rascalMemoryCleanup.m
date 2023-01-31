function rascalMemoryCleanup()

%Java garbage collect...
java.lang.System.gc();
drawnow limitrate;

[~,attr] = fileattrib(pwd);
if ~attr.UserWrite
    warning('no user save permissions on current directory');
else
    evalin('base','save tempfile.mat');
    evalin('base','clear all');
    evalin('base','load tempfile.mat');
end



