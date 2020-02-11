function [output,sub_rough] = Model_IIb(params,bulk_in,bulk_out,contrast)
%MODEL_1  RASCAL Custom Layer Model File.
%
%
% This file accepts 3 vectors containing the values for
% Params, bulk in and bulk out
% The final parameter is an index of the contrast being calculated
% The m-file should output a matrix of layer values, in the form..
% Output = [thick 1, SLD 1, Rough 1, Percent Hydration 1, Hydrate how 1
%           ....
%           thick n, SLD n, Rough n, Percent Hydration n, Hydration how n]
% The "hydrate how" parameter decides if the layer is hydrated with
% Bulk out or Bulk in phases. Set to 1 for Bulk out, zero for Bulk in.
% Alternatively, leave out hydration and just return..
% Output = [thick 1, SLD 1, Rough 1,
%           ....
%           thick n, SLD n, Rough n] };
% The second output parameter should be the substrate roughness


Roughness = params(1);
APM = params(2);
thickHead = params(3);
theta = params(4);
% vTail = params(4);
% vHead = params(5);

%Make a flag to say which deuteration this is calculating
%[subs head tail]
deut = [0 0 1;
        1 0 1;
        0 1 0;
        1 1 0;
        0 1 1;
        1 1 1;
        1 0 0];
    

%Neutron b's..
%define all the neutron b's.
bc = 0.6646e-4;     %Carbon
bo = 0.5843e-4;     %Oxygen
bh = -0.3739e-4;	%Hydrogen
bp = 0.513e-4;      %Phosphorus
bn = 0.936e-4;      %Nitrogen
bd = 0.6671e-4;     %Deuterium

%Work out the total scattering length in each fragment....
%Define scattering lengths..
%Hydrogenated version....
COO = (4*bo) + (2*bc);
GLYC = (3*bc) + (5*bh);
CH3 = (2*bc) + (6*bh);             
PO4 = (1*bp) + (4*bo);
CH2 = (1*bc) + (2*bh);
CHOL = (5*bc) + (12*bh) + (1*bn);
H2O = (2*bh) + (1*bo);

%..and deuterated...
dGLYC = (3*bc) + (5*bd);
dCH3 = (2*bc) + (6*bd); 
dCH2 = (1*bc) + (2*bd);
dCHOL = (5*bc) + (12*bd) + (1*bn);
D2O = (2*bd) + (1*bo);

%And also volumes....
vCH3 = 52.7;
vCH2 = 28.1;
vCOO = 39.0;
vGLYC = 68.8;
vPO4 = 53.7;
vCHOL = 120.4;
vWAT = 30.4;

vHead = vCHOL + vPO4 + vGLYC + 2*vCOO;%320.9;
vTail = 2*(16*vCH2)+ 2*(vCH3);%1005;

%Make the SLD's first...
thisMask = deut(contrast,:);

switch thisMask(1)  
    case 0
        thisWater = (H2O * 0.9249) + (D2O * 0.0871);
    case 1
        thisWater = D2O;
end

%Calculate mole fraction of D2O from the bulk SLD..
d2o_molfr = (1/D2O-H2O)*((bulk_out(contrast)/0.036182336306)-H2O);
thisWater = (d2o_molfr * D2O) + ((1-d2o_molfr)*H2O);


switch thisMask(2)
    case 0
        thisHead = CHOL + PO4 + GLYC + COO;
    case 1
        thisHead = dCHOL + PO4 + GLYC + COO;
end

switch thisMask(3);
    case 0
        thisTail = (32*CH2) + CH3;
    case 1
        thisTail = (32*dCH2) + dCH3;
end

noWat = ((thickHead*APM)-vHead)/vWAT;
thisHead = thisHead + noWat*thisWater;
vHead = vHead + noWat*vWAT;


sldHead = thisHead/vHead;
%thickHead = vHead/APM;

sldTail = thisTail/vTail;
%thickTail = vTail/APM;

thickTail = (1.5 + 16*1.265)*cosd(theta);

output = [thickTail sldTail Roughness;
          thickHead sldHead Roughness;];
      

sub_rough = Roughness;
      





