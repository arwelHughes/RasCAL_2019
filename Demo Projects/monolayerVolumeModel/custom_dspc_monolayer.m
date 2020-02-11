function [output,sub_rough] = custom_dspc_monolayer(params,bulk_in,bulk_out,contrast)
%CUSTOM_DSPC_MONOLAYER  RASCAL Custom Layer Model File.
%
%
% This file accepts 3 vectors containing the values for
% Params, bulk in and bulk out
% The final parameter is an index of the contrast being calculated
% The m-file should output a matrix of layer values, in the form..
% Output = [thick 1, SLD 1, Rough 1, Hydration 1...
%           ....
%           thick n, SLD n, Rough n, Hydration n]
% The "hydrate how" parameter decides if the layer is hydrated with
% Bulk out or Bulk in phases. Set to 1 for Bulk out, zero for Bulk in.
% Alternatively, leave out hydration and just return..
% Output = [thick 1, SLD 1, Rough 1,
%           ....
%           thick n, SLD n, Rough n] };


sub_rough = params(1);
tail_thick= params(2);
head_thick = params(3);
d_tail_sld = params(4);
h_tail_sld  = params(5);
head_hydr = params(6);
h_head_sld = params(7);
d_head_sld = params(8);
tail_rough = params(9);

tail_rough = sqrt(sub_rough^2 + tail_rough^2);

d_tails = [tail_thick d_tail_sld  tail_rough 0 1];
h_tails = [tail_thick h_tail_sld  tail_rough 0 1];

d_heads = [head_thick d_head_sld sub_rough head_hydr 1];
h_heads = [head_thick h_head_sld sub_rough head_hydr 1];

contrast_flags = [1 0 ;
    1 0;
    0 1;
    0 1;
    1 1;
    1 1;
    0 0];


thisContrast = contrast_flags(contrast,:);
if thisContrast(1) == 1
    tails = d_tails;
else
    tails = h_tails;
end

if thisContrast(2) == 1
    heads = d_heads;
else
    heads = h_heads;
end

output = [tails ; heads];


