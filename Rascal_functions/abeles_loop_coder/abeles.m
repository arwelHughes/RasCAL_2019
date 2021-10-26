function out = abeles(x,sld,nbair,nbsub,nrepeats,ssub,layers,points)
	
out = zeros(points,1);

lam = 1.54;
rfac = ((4*pi)^2)/2;
twopi = 2*pi;
snair = (1.0 - (nbair*((lam^2) / twopi)));
snsub = (1.0 - (nbsub*((lam^2) / twopi)));
for loop = 1:points
    q = x(loop);
    
    c0 = complex(0,0);
    c1 = complex(1,0);
    ci = complex(0,1);
    
    N = [c0 c0; c0 c0];
    MI = [c1 c0; c0 c1];
    
    theta = asin(q*lam / (4*pi));
    preal = ((snsub)^2) - ((snair)^2)*(cos(theta)^2);
    psub = sqrt(preal*c1);
    pair = snair*sin(theta)*c1;
    plast = pair;
    blast = complex(0,0);
    for reploop = 1:nrepeats
        for nl = 1:layers
            thick = sld(nl,1);
            rho = sld(nl,2);
            rough = sld(nl,3);
            snlay = (1 - (rho*((lam^2) / twopi)));
            preal = (snlay^2) - (snair^2) *cos(theta)^2;
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
            M = MI;
            MI = M * N;
        end
    end
    rij = (complex(plast - psub)) / (complex(plast + psub));
    rij = rij * exp(-rfac*plast*psub*(ssub^2)/(lam^2));
    N(1,1) = exp(blast*ci);
    N(2,1) = rij*exp(-blast*ci);
    N(2,2) = exp(-blast*ci);
    N(1,2) = rij*exp(blast*ci);
    M = MI;
    MI = M * N;
    num = MI(2,1)*conj(MI(2,1));
    den = MI(1,1)*conj(MI(1,1));
    R = num/den;
    out(loop) = real(R^2);    
end

return
end 