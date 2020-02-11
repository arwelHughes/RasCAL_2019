clear

x1 = linspace(0.01,0.1);
x2 = [2 4 6 8 10];
xData = {x1(:) ; x2(:)};

sld1 = [1 2 3 ; 4 5 6 ; 7 8 9];
sld2 = [1 2 3 ; 4 5 6 ; 7 8 9];
slds = {sld1 ; sld2};

nbairs = [0 0];
nbsubs = [2.07e-6 2.07e-6];
repeats = [1 1];
resolutions = [0.03 0.03];
sLast = [3 3];

out = mexGatewayJT_abeles2(xData, slds, nbairs, nbsubs, repeats, resolutions, sLast);

%simRef = abeles_loop_3(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));
