function status=wbar(task,i,nsimu)
%%%% waitbar update
persistent hdl t0 tl hmsg

status = 1;

switch lower(task)
 case 'init'
  hdl=waitbar(0,'Generating chain...','CreateCancelBtn','delete(gcbf)');
  set(hdl,'Name','MCMC status');
  t0=clock;
  tl=t0;
  hmsg=get(findobj(hdl,'Type','Axes'),'xlabel');
  set(hmsg,'HorizontalAlignment','left');
  set(hmsg,'Position',[0,-1]);
 case 'close'
  if ishandle(hdl);delete(hdl);end
 case 'message'
  if ishandle(hdl)
    txt = i;
    set(hmsg,'String',txt);
    drawnow
  end
 otherwise
  if ~ishandle(hdl) % cancel pressed
    status = -1;
    return
  end
  if (i/50==fix(i/50))
    % too slow
%  if etime(clock,tl) >= 1 | i < 10 % update every 1 secs
    hh=i/nsimu;
    %    htitle=get(findobj(hdl,'Type','Axes'),'title');
    secs = etime(clock,t0)*(1-hh)/hh;
    mins = floor(secs/60);
    secs = ceil(secs - 60*mins);
    hrs  = floor(mins/60);
    mins = mins - hrs*60;
    %   if wbarupd
    waitbar(hh,hdl, ...
            sprintf('Generating chain, eta: %g:%02g:%02g', ...
                    hrs,mins,secs));
%    set(htitle,'String', ...
%               sprintf('Generating chain, eta: %g:%02g:%02g', ...
%                       hrs,mins,secs));
    drawnow
    tl = clock; % last time updated
  end
end
