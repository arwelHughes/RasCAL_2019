function out = resolution_polly(xdata,ydata,res,points)
% Apply resolution correction



res = res + 0.0001;
dummydata = zeros(points,1);
dummyref = ydata;

for j = 1:points
    
    sumg = 0;
    dummydata(j) = 0;
    
    if (j>10)
        ilow = -10;
    else
        ilow = -j + 1;
    end
    
    if (j < (points - 10))
        ihi = 10;
    else
        ihi = points - j;
    end
    
%    try
    for i = ilow:ihi
        g = exp(-1*((xdata(j+i)-xdata(j))/(res*xdata(j)))^2);
        sumg = sumg + g;
        dummydata(j) = dummydata(j) + dummyref(i+j) * g;
    end
    if (sumg ~= 0)
        dummydata(j) = dummydata(j) / sumg;
    end
end

out = dummydata;

end