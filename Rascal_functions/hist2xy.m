function data = hist2xy(x,y,e)

try
count = 1;
if ~any(y)
    addInfoText('Y data is all zero!');
    return
end
for i = 1:length(x)-1
    newx = ((x(i+1) - x(i))/2)+x(i);
    if y(i) ~= 0
        data(count,:) = [newx y(i) e(i)];
        count = count + 1;
    end
end
catch
    addInfoText(lasterr);
end

%disp('test')
