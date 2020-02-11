function [output,subs_rough] = singleBilayerTest(params,bulk_in,bulk_out,contrast)
%SINGLEBILAYERTEST  RASCAL Custom Layer Model File.
%
%
% This file accepts 3 vectors containing the values for
% Params, bulk in and bulk out
% The final parameter is an index of the contrast being calculated
% The m-file should output a matrix of layer values, in the form..
% Output = [thick 1, SLD 1, Rough 1, Hydration 1 , Hydrate How 1...
%           ....
%           thick n, SLD n, Rough n, Hydration n , Hydrate How n]
% The "hydrate how" parameter decides if the layer is hydrated with
% Bulk out or Bulk in phases. Set to 1 for Bulk out, zero for Bulk in.
% Alternatively, leave out hydration and just return..
% Output = [thick 1, SLD 1, Rough 1,
%           ....
%           thick n, SLD n, Rough n] };

subs_rough = params(1);
APM = params(2);
LW_thick = params(3);
CW_thick = params(4);
Waters_per_head = params(5);
bilayer_hydration = params(6);
bilayer_hydration_upper = params(7);
bil_rough_upper = params(8);
ox_thick = params(9);
bilayer_rough_lower = params(10);

%Define all the neutron b's
bc = 0.6646e-4;	%Carbon
bo = 0.5843e-4;	%Oxygen
bh = -0.3739e-4;	%Hydrogen
bp = 0.513e-4;	%Phosphorus
bn = 0.936e-4;	%Nitrogen
bd = 0.6671e-4;	%Deuterium

%Formulae of the molecule sections...
CH2 = (1*bc) + (2*bh);
CH3 = (1*bc) + (3*bh);
D2O = (2*bd) + (1*bo);
H2O = (2*bh) + (1*bo);

%Calculate mole fraction of D2O from the bulk SLD..
d2o_molfr = (1/D2O-H2O)*((bulk_out(contrast)/0.036182336306)-H2O);
wMol = (d2o_molfr * D2O) + ((1-d2o_molfr)*H2O);

%sum b's of all the different fragments
sum_b_tails = (32*CH2);% + (2*CH3);
sum_b_methyl = 4*CH3;
sum_b_heads = (6*bo) + (1*bp) + (1*bn) + (4*CH2) + (3*CH3) + (Waters_per_head * wMol);

%volumes of each fragment
vCH2 = 27.7;
nCH2 = 32;
volume_tails = nCH2 * vCH2;
volume_methyl = 214;
volume_heads = 331;

%Calculate thickness of each fragment
TailThick = volume_tails / APM;
HeadThick = volume_heads / APM;
CH3_thick = volume_methyl / APM;

%and thus the SLD
Rho_heads = sum_b_heads / volume_heads;
Rho_tails = sum_b_tails / volume_tails;
Rho_CH3 = sum_b_methyl / volume_methyl;

%Group all the parameters into layers
Oxide_layer = [ox_thick , 3.41e-6 , subs_rough , 0 ,1];
LW_layer = [LW_thick , bulk_out(contrast) , bilayer_rough_lower , 0 , 1];
Head_layer_lower = [HeadThick , Rho_heads , bilayer_rough_lower , bilayer_hydration , 1];
Tail_layer_lower = [TailThick , Rho_tails , bilayer_rough_lower , bilayer_hydration , 1];
CH3_layer_lower = [CH3_thick , Rho_CH3 , bilayer_rough_lower , bilayer_hydration , 1];
central_water = [CW_thick , bulk_out(contrast), bil_rough_upper , 0 , 1];
Head_layer_upper = [HeadThick , Rho_heads , bil_rough_upper , bilayer_hydration_upper , 1];
Tail_layer_upper = [TailThick , Rho_tails , bil_rough_upper , bilayer_hydration_upper , 1];
CH3_layer_upper = [CH3_thick , Rho_CH3 , bil_rough_upper , bilayer_hydration_upper , 1];

lower_bilayer = [Head_layer_lower ; Tail_layer_lower ; CH3_layer_lower ; Tail_layer_lower ; Head_layer_lower];
upper_bilayer  = [Head_layer_upper ; Tail_layer_upper ; CH3_layer_upper ; Tail_layer_upper ; Head_layer_upper];

%Put the layers together into the final model.
output = [Oxide_layer ; LW_layer ; lower_bilayer ; central_water ; upper_bilayer ];

    





