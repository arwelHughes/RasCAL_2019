function output = SAM_supported_bilayer(params,bulk_in,bulk_out,contrast);

%ubil_pos ubil_rough ubil_apm ucov lbil_head_pos lbil_rough lbil_apm lcov ox_thick subrough eff_pos
%params = problem.params;
%contrast = problem.which_contrast; 

sldwat = bulk_out(contrast);

ubil_pos = params(1);
ubil_rough = params(2);
ubil_apm = params(3);
ubil_thick = params(4);
ucov = params(5);

lbil_head_pos = params(6);
lbil_rough = params(7);
lbil_apm = params(8);
lcov = params(9);

ox_thick = params(10);
subrough = params(11);
erf_width_u = params(12);

ox_hydr = params(13);
%erf_width_l = params(13);

%need neutron b's
bo = 0.5843e-4;         %Oxygen
bh = -0.3739e-4;        %Hydrogen
bd = 0.6671e-4;         %Deuterium
H2O = (2*bh) + (1*bo);
D2O = (2*bd) + (1*bo);
Vwat = 30.18;
x = 0:220;
d2o_molfr = (1/D2O-H2O)*((sldwat/0.036182336306)-H2O);

%Make a substrate bit...
subcen = 0;
subs = convstep(x,50,0,subrough,1);
subs_edge = 25;
ox_surf = subs_edge + ox_thick;
ox = convstep(x,ox_thick,(subs_edge + (ox_thick/2)),subrough,1);

%Parameters for upper bilayer
p.Roughness = ubil_rough;
p.Position = ubil_pos + ox_surf;
p.APM = ubil_apm;
p.display = 0;
p.erfwidth = erf_width_u;
p.thick = ubil_thick;
p.d2o_molfr = d2o_molfr;
[upper_bil_sld,uwat_vf] = new_bil_model(x,p);
upper_pos = p.Position;%

%coverage correction.....
all_empty = ones(1,length(x));
uwat_vf = (ucov * uwat_vf) + ((1 - ucov) * all_empty);
upper_bil_sld = (ucov * upper_bil_sld);% + ((1 - ucov) * all_d2o);

%Now for lower layer
p.Roughness = lbil_rough;
p.Position = lbil_head_pos + ox_surf;
p.APM =lbil_apm;
p.display = 1;
p.erfwidth = erf_width_u;
p.d2o_molfr = d2o_molfr;
[lower_bil_sld,lwat_vf] = new_SAM_model(x,p,subs,ox,ox_surf);
lower_pos = p.Position;% + ox_surf;

%coverage correction.....
lwat_vf = (lcov * lwat_vf) + ((1 - lcov) * all_empty);
lower_bil_sld = (lcov * lower_bil_sld);

%Splice the two volume fractions
midp = floor(((upper_pos - lower_pos)/2) + lower_pos); 
tot_watvf = [lwat_vf(1:midp),uwat_vf(midp+1:end)];

%Calculate the water SLD
tot_watvf = tot_watvf - (subs + ox);
tot_watnd = tot_watvf / Vwat;
watsld = tot_watnd * ((d2o_molfr * D2O) + (1 - d2o_molfr)*H2O);
subs_sld = subs .* 2.07e-6;

ox_scat_length = (ox_hydr * sldwat) + ((1 - ox_hydr) * 3.41e-6);

ox_sld = ox .* ox_scat_length;

%Complete SLD of whole thing....
tot_sld = upper_bil_sld + lower_bil_sld + watsld + subs_sld + ox_sld;
output = [x(:) tot_sld(:)];

%debug plot
% figure (4)
% clf
% plot(x,upper_bil_sld,'r-')
% hold on
% plot(x,lower_bil_sld,'m-');
% plot(x,watsld,'b-');
% plot(x,subs_sld,'c-');
% plot(x,ox_sld,'y-');
% plot(x,tot_sld,'k-');
% hold off

return





%******************************************************************
function [tot_sld,vfwat] = new_bil_model(x,params)

%New version with sigmoidal volume sharing

%******************************************************************
%
%               Define all the common parameters
%
%******************************************************************

position = params.Position;
Roughness = params.Roughness;
APM = params.APM;               %Square angstrom;
d2o_molfr = params.d2o_molfr;
displ = params.display;
erfwidth = params.erfwidth;
thick = params.thick;

%define all the neutron b's.
bc = 0.6646e-4;	%Carbon
bo = 0.5843e-4;	%Oxygen
bh = -0.3739e-4;	%Hydrogen
bp = 0.513e-4;	%Phosphorus
bn = 0.936e-4;	%Nitrogen
bd = 0.6671e-4;	%Deuterium

%Work out the total scattering length in each fragment....
COO = (4*bo) + (2*bc);
GLYC = (3*bc) + (5*bh);
CH3 = (1*bc) + (3*bh);              %Note 2 ch3 groups
PO4 = (1*bp) + (4*bo);
CH2 = (1*bc) + (2*bh);
H2O = (2*bh) + (1*bo);
D2O = (2*bd) + (1*bo);
CHOL = (5*bc) + (13*bh) + (1*bn);

%Define volumes....
Vcoo = 39;		%Carboxy group..
Vglyc = 69;		%Glycerol group
Vpo4 = 54;		%Phospho group..
Vchol = 121;	%Choline group	
Vwat = 30.18;	%Water molecule
Vch3 = 52;      %Methyl group
Vch2 = 28.1;    %Methylene group

chainvol = 32 * Vch2;  %volume of the alkyl region from Armen et al (ie 26 CH2's of 28Å^3 each)
thickness = thick;%chainvol / APM;

%and intrinsic roughness'
Ach3 = 2.95;
Acoo = 2.73;
Aglyc = 2.37;
Apo4 = 3.08;
Achol = 3.48;
Awat = 4.63;

%Include a general bilayer roughness
%Use R = sqrt(i2 + r2)
Roughness = Roughness^2;
Ach3 = sqrt(Ach3^2 + Roughness);
Acoo = sqrt(Acoo^2 + Roughness);
Aglyc = sqrt(Aglyc^2 + Roughness);
Apo4 = sqrt(Apo4^2 + Roughness);
Achol = sqrt(Achol^2 + Roughness);
Awat = sqrt(Awat^2 + Roughness);

%Each gaussian has a height of 1...
ncoo = 1;	%i.e there's 1 coo fragment, 1 glyc fragment etc..
nglyc = 1;
npo4 = 1;
nchol = 1;
nch3 = 2;      

%***********************************************************%
%                                                           %
%               Upper Leaflet Headgroup                     %
%                                                           %
%************************************************************

%Define centre positions
upper_Zcoo = position + thickness;   
upper_Zglyc = upper_Zcoo + 2.7;
upper_Zpo4 = upper_Zcoo + 4.22;
upper_Zchol = upper_Zcoo + 5.96; 
upper_Zch3 = position;

%Make gaussians 
upper_nGcoo = gssian(x,upper_Zcoo,ncoo,Acoo);
upper_nGglyc = gssian(x,upper_Zglyc,nglyc,Aglyc);
upper_nGpo4 = gssian(x,upper_Zpo4,npo4,Apo4);
upper_nGchol = gssian(x,upper_Zchol,nchol,Achol);
upper_nGch3 = gssian(x,upper_Zch3,nch3,Ach3);

%Gaussians are number of 'molecules' per unit
%length. To get per unit volume we divide by
%the APM. Number per unit volume will be
%the NUMBER DENSITY
upper_nGcoo = upper_nGcoo / APM;
upper_nGglyc = upper_nGglyc / APM;
upper_nGpo4 = upper_nGpo4 / APM;
upper_nGchol = upper_nGchol / APM;
upper_nGch3 = upper_nGch3 / APM;

%Now, we need to calculate a volume fraction
%i.e. a dimensionless quantity between 0 and 1.
%We just multiply by the component vols
upper_vfGcoo = upper_nGcoo * Vcoo;    %...these are now dimensionless
upper_vfGglyc = upper_nGglyc * Vglyc; %since Å3 * Å-3
upper_vfGpo4 = upper_nGpo4 * Vpo4;
upper_vfGchol = upper_nGchol * Vchol;
upper_vfGch3 = upper_nGch3 * Vch3;



%***********************************************************%
%                                                           %
%               Lower Leaflet Headgroup                     %
%                                                           %
%************************************************************
%Define centre positions
lower_Zcoo = position - thickness;   
lower_Zglyc = lower_Zcoo - 2.7;
lower_Zpo4 = lower_Zcoo - 4.22;
lower_Zchol = lower_Zcoo - 5.96; 
lower_Zch3 = position;

%Make gaussians 
lower_nGcoo = gssian(x,lower_Zcoo,ncoo,Acoo);
lower_nGglyc = gssian(x,lower_Zglyc,nglyc,Aglyc);
lower_nGpo4 = gssian(x,lower_Zpo4,npo4,Apo4);
lower_nGchol = gssian(x,lower_Zchol,nchol,Achol);
lower_nGch3 = gssian(x,lower_Zch3,nch3,Ach3);

%Gaussians are number of 'molecules' per unit
%length. To get per unit volume we divide by
%the APM. Number per unit volume will be
%the NUMBER DENSITY
lower_nGcoo = lower_nGcoo / APM;
lower_nGglyc = lower_nGglyc / APM;
lower_nGpo4 = lower_nGpo4 / APM;
lower_nGchol = lower_nGchol / APM;
lower_nGch3 = lower_nGch3 / APM;

%Now, we need to calculate a volume fraction
%i.e. a dimensionless quantity between 0 and 1.
%We just multiply by the component vols
lower_vfGcoo = lower_nGcoo * Vcoo;    %...these are now dimensionless
lower_vfGglyc = lower_nGglyc * Vglyc; %since Å3 * Å-3
lower_vfGpo4 = lower_nGpo4 * Vpo4;
lower_vfGchol = lower_nGchol * Vchol;
lower_vfGch3 = lower_nGch3 * Vch3;



%*******************************************************************
%
%               Now deal with the volume calculation
%
%*******************************************************************

%So to get the free volume fraction, add them all up
%and its then 1 - total
vfTot = upper_vfGcoo + upper_vfGglyc + upper_vfGpo4 + upper_vfGchol + ... 
+ lower_vfGch3 + lower_vfGcoo + lower_vfGglyc + lower_vfGpo4 + lower_vfGchol + lower_vfGch3;
vf_free = 1 - vfTot;

%we need to penalise chi squared for over filling
too_much = find(vfTot > 1);
toomuch = vfTot(too_much) - 1;
add = sum(toomuch);

%Split up the volume fraction between the water and CH2's
%On one side its all water, on the other its all ch2
%The interface is assumed to be a sigmoidal accross
%the glyc group for now.

%Make the sigmoidals....
%vf_change_upper = sigmoid(x,upper_Zglyc+erfpos,0,1,(Aglyc/(sqrt(2*pi))));  %note conversion from 1/e roughness
%vf_change_lower = sigmoid(x,lower_Zglyc-erfpos,1,0,(Aglyc/(sqrt(2*pi))));

vf_change_upper = sigmoid(x,upper_Zglyc,0,1,erfwidth); 
vf_change_lower = sigmoid(x,lower_Zglyc,1,0,erfwidth);

%Splice at centre of bilayer....
vf_change_total = [vf_change_lower(1:round(position)) , vf_change_upper(round(position)+1:end)];

%So water vfrac is free vol times this...
vfwat = vf_change_total .* vf_free;

%..and ch2 is the opposite
vfch2 = (1-vf_change_total) .* vf_free;

%Now we need to convert all this into a 
%scattering length density.....
%For the gaussians, we need to just multiply
%the number density by sum nb (so units Å-2)....
upper_sld_coo = upper_nGcoo * COO;
upper_sld_glyc = upper_nGglyc * GLYC;
upper_sld_po4 = upper_nGpo4 * PO4;
upper_sld_chol = upper_nGchol * CHOL;
upper_sld_ch3 = upper_nGch3 * CH3;

lower_sld_coo = lower_nGcoo * COO;
lower_sld_glyc = lower_nGglyc * GLYC;
lower_sld_po4 = lower_nGpo4 * PO4;
lower_sld_chol = lower_nGchol * CHOL;
lower_sld_ch3 = lower_nGch3 * CH3;

%For the water and ch2, we have to do a bit more
%work. We need to convert from volume fraction
%to number density. 
%i.e. nD(Å-3) = Volume Frac / component vol(Å3)
nd_wat = vfwat / Vwat;  %assume water occupies 30 Å3
nd_ch2 = vfch2 / Vch2;

%The multiply by nb as before
sld_wat = nd_wat * ((d2o_molfr * D2O) + (1 - d2o_molfr)*H2O);
sld_ch2 = nd_ch2 * CH2;

%And plot it all out......
switch displ
    case 1
        figure (3)
        %subplot(3,1,contrast);
        hold off
        plot(x,upper_sld_coo,'g-');
        hold on
        plot(x,upper_sld_glyc,'r-');
        plot(x,upper_sld_po4,'k-');
        plot(x,upper_sld_chol,'m-');
        plot(x,upper_sld_ch3 + lower_sld_ch3,'k-');
        plot(x,lower_sld_coo,'g-');
        plot(x,lower_sld_glyc,'r-');
        plot(x,lower_sld_po4,'k-');
        plot(x,lower_sld_chol,'m-');
        
        plot(x,sld_wat,'b-');
        plot(x,sld_ch2,'r-');
        ylabel('Scattering Length Density')
        xlabel('Distance normal to interface Å');
        axis ([(position - 30) (position + 30) -1e-6 4e-6])
end

%And D2O comes out to be 6.39e-6. BA DA BOOM! :o)

tot_sld = lower_sld_coo + lower_sld_glyc + lower_sld_po4 + lower_sld_chol + lower_sld_ch3 + ...
    upper_sld_coo + upper_sld_glyc + upper_sld_po4 + upper_sld_chol + upper_sld_ch3 + sld_ch2;% + sld_wat;

SLD = tot_sld(:);


return


%******************************************************************
function [tot_sld,vfwat] = new_SAM_model(x,params,subs,ox,ox_surf)

%Model for polymerised SAM with Sigmoidal volume sharing

%******************************************************************
%
%               Define all the common parameters
%
%******************************************************************

position = params.Position;
Roughness = params.Roughness;
APM = params.APM;               %Square angstrom;
d2o_molfr = params.d2o_molfr;
displ = params.display;
erfwidth = params.erfwidth;

%define all the neutron b's.
bc = 0.6646e-4;	%Carbon
bo = 0.5843e-4;	%Oxygen
bh = -0.3739e-4;	%Hydrogen
bp = 0.513e-4;	%Phosphorus
bn = 0.936e-4;	%Nitrogen
bd = 0.6671e-4;	%Deuterium

%Work out the total scattering length in each fragment....
COO = (4*bo) + (2*bc);
GLYC = (3*bc) + (5*bh);
CH3 = (1*bc) + (3*bh);              %Note 2 ch3 groups
PO4 = (1*bp) + (4*bo);
CH2 = (1*bc) + (2*bh);
H2O = (2*bh) + (1*bo);
D2O = (2*bd) + (1*bo);
CHOL = (5*bc) + (13*bh) + (1*bn);

%Define volumes....
Vcoo = 39;		%Carboxy group..
Vglyc = 69;		%Glycerol group
Vpo4 = 54;		%Phospho group..
Vchol = 121;	%Choline group	
Vwat = 30.18;	%Water molecule
Vch3 = 52;      %Methyl group
Vch2 = 28.1;    %Methylene group

%chainvol = 32 * Vch2;  %volume of the alkyl region from Armen et al (ie 26 CH2's of 28Å^3 each)
thickness = position-ox_surf;

%and intrinsic roughness'
Ach3 = 2.95;
Acoo = 2.73;
Aglyc = 2.37;
Apo4 = 3.08;
Achol = 3.48;
Awat = 4.63;

%Include a general bilayer roughness
%Use R = sqrt(i2 + r2)
Roughness = Roughness^2;
Ach3 = sqrt(Ach3^2 + Roughness);
Acoo = sqrt(Acoo^2 + Roughness);
Aglyc = sqrt(Aglyc^2 + Roughness);
Apo4 = sqrt(Apo4^2 + Roughness);
Achol = sqrt(Achol^2 + Roughness);
Awat = sqrt(Awat^2 + Roughness);

%Each gaussian has a height of 1...
ncoo = 1;	%i.e there's 1 coo fragment, 1 glyc fragment etc..
nglyc = 1;
npo4 = 1;
nchol = 1;
nch3 = 1;      



%***********************************************************%
%                                                           %
%               Upper Leaflet Headgroup                     %
%                                                           %
%************************************************************

%Define centre positions
upper_Zcoo = position + thickness;   
upper_Zglyc = upper_Zcoo + 2.7;
upper_Zpo4 = upper_Zcoo + 4.22;
upper_Zchol = upper_Zcoo + 5.96; 
upper_Zch3 = position;

%Make gaussians 
upper_nGcoo = gssian(x,upper_Zcoo,ncoo,Acoo);
upper_nGglyc = gssian(x,upper_Zglyc,nglyc,Aglyc);
upper_nGpo4 = gssian(x,upper_Zpo4,npo4,Apo4);
upper_nGchol = gssian(x,upper_Zchol,nchol,Achol);
upper_nGch3 = gssian(x,upper_Zch3,nch3,Ach3);

%Gaussians are number of 'molecules' per unit
%length. To get per unit volume we divide by
%the APM. Number per unit volume will be
%the NUMBER DENSITY
upper_nGcoo = upper_nGcoo / APM;
upper_nGglyc = upper_nGglyc / APM;
upper_nGpo4 = upper_nGpo4 / APM;
upper_nGchol = upper_nGchol / APM;
upper_nGch3 = upper_nGch3 / APM;

%Now, we need to calculate a volume fraction
%i.e. a dimensionless quantity between 0 and 1.
%We just multiply by the component vols
upper_vfGcoo = upper_nGcoo * Vcoo;    %...these are now dimensionless
upper_vfGglyc = upper_nGglyc * Vglyc; %since Å3 * Å-3
upper_vfGpo4 = upper_nGpo4 * Vpo4;
upper_vfGchol = upper_nGchol * Vchol;
upper_vfGch3 = upper_nGch3 * Vch3;



%*******************************************************************
%
%               Now deal with the volume calculation
%
%*******************************************************************

%So to get the free volume fraction, add them all up
%and its then 1 - total
vfSubs = subs;%./max(subs);
vfOx = ox;%./max(ox);
vfTot = upper_vfGcoo + upper_vfGglyc + upper_vfGpo4 + upper_vfGchol + vfSubs + vfOx;
vf_free = 1 - vfTot;

%we need to penalise chi squared for over filling
too_much = find(vfTot > 1);
toomuch = vfTot(too_much) - 1;
add = sum(toomuch);

%Split up the volume fraction between the water and CH2's
%On one side its all water, on the other its all ch2
%The interface is assumed to be a sigmoidal accross
%the glyc group for now.

%Make the sigmoidals....
vf_change_upper = sigmoid(x,upper_Zglyc,0,1,erfwidth);  %note conversion from 1/e roughness

%So water vfrac is free vol times this...
vfwat = vf_change_upper .* vf_free;

%..and ch2 is the opposite
vfch2 = (1-vf_change_upper) .* vf_free;

%Now we need to convert all this into a 
%scattering length density.....
%For the gaussians, we need to just multiply
%the number density by sum nb (so units Å-2)....
upper_sld_coo = upper_nGcoo * COO;
upper_sld_glyc = upper_nGglyc * GLYC;
upper_sld_po4 = upper_nGpo4 * PO4;
upper_sld_chol = upper_nGchol * CHOL;
upper_sld_ch3 = upper_nGch3 * CH3;


%For the water and ch2, we have to do a bit more
%work. We need to convert from volume fraction
%to number density. 
%i.e. nD(Å-3) = Volume Frac / component vol(Å3)
nd_wat = vfwat / Vwat;  %assume water occupies 30 Å3
nd_ch2 = vfch2 / Vch2;

%The multiply by nb as before
sld_wat = nd_wat * ((d2o_molfr * D2O) + (1 - d2o_molfr)*H2O);
sld_ch2 = nd_ch2 * CH2;

%And plot it all out......
% switch displ
%     case 1
%         figure (3)
%         %subplot(3,1,contrast);
%         hold off
%         plot(x,upper_sld_coo,'g-');
%         hold on
%         plot(x,upper_sld_glyc,'r-');
%         plot(x,upper_sld_po4,'k-');
%         plot(x,upper_sld_chol,'m-');
%         plot(x,upper_sld_ch3 + lower_sld_ch3,'k-');
%         plot(x,lower_sld_coo,'g-');
%         plot(x,lower_sld_glyc,'r-');
%         plot(x,lower_sld_po4,'k-');
%         plot(x,lower_sld_chol,'m-');
%         
%         plot(x,sld_wat,'b-');
%         plot(x,sld_ch2,'r-');
%         ylabel('Scattering Length Density')
%         xlabel('Distance normal to interface Å');
%         axis ([(position - 30) (position + 30) -1e-6 4e-6])
% end

%And D2O comes out to be 6.39e-6. BA DA BOOM! :o)

tot_sld = upper_sld_coo + upper_sld_glyc + upper_sld_po4 + upper_sld_chol + sld_ch2;

SLD = tot_sld(:);
vfwat = vfwat + vfSubs + vfOx;

return






%--------------------------------------------------
function f = gssian(z,Z,N,A)
%f(z) = gaussian(z,Z,N,A)
%
%	produces a gaussian at centre Z, of height
%	N and 1/e half width of A.

pi = 3.142;
%a = A*sqrt(2*pi);
f = (N/(A*sqrt(pi)))*exp(-((z-Z).^2)/(A^2));

%_________________________________________________-


function y = sigmoid(x,cen,ymin,ymax,width)

%y = sigmoid(x,cen,ymin,ymax,width)

y = ymin + ((ymax - ymin) ./ (1 + exp(-(x-cen)/width)));
