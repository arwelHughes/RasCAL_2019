function out = abeles_single(x,sld,nbair,nbsub,nrepeats,rsub,layers,points)

	
% nbair = nbairs(thisCont);
% nbsub = nbsubs(thisCont);
% ssub = ssubs(thisCont);
% nrepeats = nrepeatss(thisCont);
% resol = resols(thisCont);
out = zeros(points,1);


c0 = complex(0,0);
c1 = complex(1,0);
ci = complex(0,1);
plast = complex(0);
blast = complex(0);
N = [c0 c0; c0 c0];
MI = [c0 c0; c0 c0];
M = [c0 c0; c0 c0];
%pi = 3.141592653589;
lam = 1.54;
rfac = ((4*pi)*(4*pi))/2;
twopi = 2*pi;
snair = (1.0 - (nbair*((lam*lam) / twopi)));
snsub = (1.0 - (nbsub*((lam*lam) / twopi)));
for loop = 1:points
    q = x(loop);
    theta = asin(q*lam / (4*pi));
    preal = ((snsub)*(snsub)) - ((snair)*(snair))*(cos(theta)^2);
    psub = sqrt(preal*c1);
    pair = snair*sin(theta)*c1;
    plast = pair;
    blast = 0.0;
    rlast = sld(1,3);
    MI(1,1) = c1;
    MI(2,2) = c1;
    MI(1,2) = c0;
    MI(2,1) = c0;
    for reploop = 1:nrepeats
        for nl = 1:layers
            thick = sld(nl,1);
            rho = sld(nl,2);
            rough = sld(nl,3);
            snlay = (1 - (rho*((lam*lam) / twopi)));
            preal = (snlay*snlay) - (snair*snair) *cos(theta)^2;
            pimag = sqrt(preal*c1);
            beta = (twopi / lam)*thick*pimag;
            rij = complex(plast - pimag) / complex(plast + pimag);
            rij = rij * exp(-rfac*plast*pimag*(rough*rough)/(lam*lam));
            N(1 , 1) = exp(blast*ci);
            N(2 , 1) = rij * exp( - blast*ci);
            N(2 , 2) = exp( - blast*ci);
            N(1 , 2) = rij * exp(blast*ci);
            plast = pimag;
            blast = beta;
            rlast = rough;
            M = MI;
            MI = M * N;
        end
    end
    rij = (complex(plast - psub)) / (complex(plast + psub));
    rij = rij * exp(-rfac*plast*psub*(rsub*rsub)/(lam*lam));
    N(1,1) = exp(blast*ci);
    N(2,1) = rij*exp( - blast*ci);
    N(2,2) = exp( - blast*ci);
    N(1,2) = rij*exp(blast*ci);
    M = MI;
    MI = M * N;
    num = MI(2 , 1)*conj(MI(2 , 1));
    den = MI(1 , 1)*conj(MI(1 , 1));
    quo = num/den;
    out(loop) = abs(quo);
end

return
end 