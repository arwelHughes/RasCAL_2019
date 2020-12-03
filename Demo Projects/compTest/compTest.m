function [sld,r] = compTest(params,bulk_in,bulk_out,contrast)


r = params(1);

sld_real = 5e-6;
sld_imag = 1e-6;

sld = [100, complex(sld_real,sld_imag) r];


end