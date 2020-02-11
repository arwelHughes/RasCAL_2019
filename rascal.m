function rascal()

%RASCAL is a program for analysing multiple contrast neutron reflectivity data.
% Copyright (c) Arwel V Hughes, 2008.

%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.


setappdata(0,'bayesGuiOpen','false');

warning('off','MATLAB:dispatcher:InexactMatch');
warning('off','MATLAB:javaclasspath:jarAlreadySpecified')

% Can change this to installed dir.
rascalPath = pwd;
setappdata(0,'rascalPath',rascalPath);
addRascalPaths;

splash = SplashScreen('rascal','rascalSplash.png');

hourglassBusy = javax.swing.ImageIcon(fullfile(rascalPath,'Rascal_functions','Hourglass.gif'));
hourglassBusy = javaObjectEDT(hourglassBusy);
setappdata(0,'hourglassBusy',hourglassBusy);

stopIcon = javax.swing.ImageIcon(fullfile(rascalPath,'Rascal_functions','stop.jpg'));
stopIcon = javaObjectEDT(stopIcon);
setappdata(0,'stopIcon',stopIcon);

readyIcon = javax.swing.ImageIcon(fullfile(rascalPath,'Rascal_functions','Ready.gif'));
readyIcon = javaObjectEDT(readyIcon);
setappdata(0,'readyIcon',readyIcon);

startPath = fullfile(rascalPath,'defaultProject');
startName = 'defaultProject.mat';
problem = rLoadProblem(startPath,startName);

setappdata(0,'params_editflag',1);
problem = dealWithLegacyIssues(problem);
problem = rascal_defaults(problem);
problem.calculations.xtra_fitness = 0;
problem = backsorts(problem);
problem = packparams(problem);
setappdata(0,'problem',problem);

reflectivity_calculation();

rascal_initfigs();

UndoRedoSetup(problem);

splash.Visible = 'off';









