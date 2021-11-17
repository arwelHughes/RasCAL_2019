function resampFigClosereq(varargin)
%CLOSEREQ  Figure close request function.
%   CLOSEREQ deletes the current figure window.  By default, CLOSEREQ is
%   the CloseRequestFcn for new figures.

%   Copyright 1984-2012 The MathWorks, Inc.

%   Note that closereq now honors the user's ShowHiddenHandles setting
%   during figure deletion.  This means that deletion listeners and
%   DeleteFcns will now operate in an environment which is not guaranteed
%   to show hidden handles.
if isempty(gcbf)
    if length(dbstack) == 1
        warning(message('MATLAB:closereq:ObsoleteUsage'));
    end
    close('force');
else
    close(gcbf);
end

setappdata(0,'resampleCheckVisible',false);
setappdata(0,'resampleCheckFigure',[]);
