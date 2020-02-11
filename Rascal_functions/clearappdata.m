function clearappdata()

a = getappdata(0);
n = fields(a);
for i = 1:length(n)
    rmappdata(0,n{i});
end
