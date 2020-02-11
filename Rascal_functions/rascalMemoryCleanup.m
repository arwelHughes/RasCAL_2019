function rascalMemoryCleanup()

%Java garbage collect...
java.lang.System.gc();
drawnow limitrate;

evalin('base','save tempfile.mat');
evalin('base','clear all');
evalin('base','load tempfile.mat');



