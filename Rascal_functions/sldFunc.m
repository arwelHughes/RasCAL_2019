function sldVal = sldFunc(x)

% sldVal = sldFunc(x,SLD)
% SLD = [x rho;....xn rho]
%   x = value in Angstrom.
%
% This function returns the SLD (y) value associated with the
% supplied value of x. SLD is a two column, XY array defining an
% SLD profile. This function interpolates the SLD profile
% to return the SLD at the specific value of X. X can be a vector of
% multiple points.
%
% (c) Arwel Hughes 2019.
% Last modified - AVH, 26/11/19.
global sldProfile

SLD = sldProfile;

%SLD = getappdata(0,'sldFuncSLD');

z = SLD(:,1);
rho = SLD(:,2);

where = find(z == x);

if ~isempty(where)
    sldVal = rho(where);
else
    belowVals = find(x > z);
    aboveVals = find(x < z);
    below = belowVals(end);
    above = aboveVals(1);
    
    belowY = rho(below);
    aboveY = rho(above);
    
    yDiff = abs(aboveY-belowY);
    xDiff = z(above) - z(below);
    
    tanTheta = yDiff/xDiff;
    
    deltaX = x - z(below);
    deltaY = deltaX * tanTheta;
    
    if belowY < aboveY
        sldVal = belowY + deltaY;
    else
        sldVal = belowY - deltaY;
    end
    
    %sldVal = interp1(z,rho,x);
end


