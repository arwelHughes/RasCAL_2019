function msgBoxTest(type,message,value)

persistent box
%box = getappdata(0,'currentBox');

switch type
case 'waitbar'
    h = waitbar(0,message,'windowstyle', 'modal');
    box.type = type;
    box.handle = h;
    frames = java.awt.Frame.getFrames();
    frames(end).setAlwaysOnTop(1); 
    set(h,'CloseRequestFcn',@msgBoxClose);
case'msgbox'
    h = msgbox(message,'windowstyle','modal');
    hc=get(h,'Children');
    set(hc(1),'Visible','off');
    box.type = type;
    box.handle = h;
    frames = java.awt.Frame.getFrames();
    frames(end).setAlwaysOnTop(1); 
    set(h,'CloseRequestFcn',@msgBoxClose);
case'update'
    if isempty(box)
        disp('nothing to update');
        return
    end
    
    if strcmpi(box.type,'waitbar')
        waitbar(value,box.handle);
    elseif strcmpi(box.type, 'msgbox')
        disp('hello');
    end
case 'close'
    if isempty(box)
        disp('nothing to close')
        return
    end

    close(box.handle)
    box.handle = []';
    box.type = '';
end
   
    
end


