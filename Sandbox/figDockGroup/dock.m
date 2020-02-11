function varargout = dock(varargin)
%  VALIDHANDLES = DOCK(HANDLES,ADOCKGROUP,UNDOCKFLAG)   docks the figure(s) with the specified handle(s) 
%
%  The function works by setting the  figure 'windowStyle' property to
%  'docked'
%
%  DOCK  docks the current figure into the default 'Figures' container. A
%  figure is created one if none exists
%
%  DOCK(HANDLES), where HANDLES is a matrix,
%  docks the figure(s) with the specified handle(s) into the default
%  'Figures' container. 
%
%  if HANDLES is set to 'all' or 'ALL', the function will dock all the
%  figures into the default 'Figures' container 
%
%  DOCK(HANDLES,ADOCKGROUP) docks the figure(s) with the
%  handle contained in HANDLES into the specified ADOCKGROUP
%  container. (uses the function SETFIGDOCKGROUP by Yari Altman)
%
%  VALIDHANDLES = DOCK(HANDLES) returns a vector of figure handles
%  containing only the elements of the original HANDLES
%  variable which are figure handles
%
%  DOCK(HANDLES,ADOCKGROUP,UNDOCKFLAG) undocks the figure(s) if the
%  parameter ADOCKGROUP is logically true (ie when the command 'if
%  UNDOCKFLAG' returns true). the use of the UNDOCKFLAG is deprecated. It
%  is recommended to use the UNDOCK function instead
%
%  Examples:
%     
%       dock
%       dock(aFigureHandle)
%       dock all
%       dock(gcf)
%       dock('all')
%       dock(figure(1))
%       dock([figure(1) figure(2) figure(3)])
%       dock(aFigureHandle,'aNewDockGroup')
%   a = dock([figure(1) figure(2) figure(3)])
%
%
%  See also UNDOCK SETFIGDOCKGROUP GTSCROLL
%
% Written by Riccardo Meldolesi 21-August-2008 
% --- Default inputs
inArgs = {gcf       , ... % current figure
          'Figures' , ... % default 'Figures' group
          false     , ... % undock if true
         };
inArgs(1:nargin) = varargin; % --- Replace defaults for specified arguments
[handles,group,undockFlag] = deal(inArgs{:});   % --- Initializations
% --- Get the handles to figures
handles = validateHandles(handles);
% --- Set the group
if ~isempty(group)
   try %#ok<TRYNC>
      setFigDockGroup(handles,group)      %  Download from File Exchange
                                          %  thanks Yair Altman
   end
end
% --- dock (or undock)
if undockFlag
   set(handles,'windowStyle','normal') % --- undock
else
   set(handles,'windowStyle','docked') % --- dock
end
% --- set output if required
if nargout
   varargout{1} = handles;
end
% -------------------------------------------------------
% --- Helper functions
function handles = validateHandles(handles)
if isempty(handles)
   handles = gcf;
elseif ischar(handles)
   switch upper(handles)
      case 'ALL'
         handles = parseHandles(get(0,'children'));
      otherwise
         error('The only char type input is ''all'' (not case sensitive)')
   end
else
   handles = parseHandles(handles);
end
% -------------------------------------------------------
function result = parseHandles(handles)
result = handles(find(strcmp(get(handles,'type'),'figure'))); %#ok<FNDSB>
% -------------------------
% --- the following code is meant to give hints on how to treat a group
% --- like a figure and dock it into another group
% --- I haven't worked out how to do it yet. Maybe someone else will.
% desktop = com.mathworks.mde.desk.MLDesktop.getInstance
% hContainer = desktop.getGroupContainer('pippo')
% desktop.getGroupTitles
% desktop.addGroup('pippo')
% desktop.showGroup('paperino',true)
% desktop.setGroupDocked('pippo',1)
% desktop.setGroupMaximized('pippo',true)
% desktop.setGroupMaximized('pippo',false)
% desktop.removeGroup('pippo')