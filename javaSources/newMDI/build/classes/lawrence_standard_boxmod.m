function problem = lawrence()

%Data and module details
problem.path = 'C:\Gwaith2007\Rascal\Rascal1.6\Test\';
problem.datapath = [problem.path 'Data_files'];
problem.datafiles = strvcat('d70acmw20.dat','d70d2o20.dat','d83acmw20.dat','d83d2o20.dat','d13acmw20.dat','d13d2o20.dat','hd2o20.dat');
problem.module.name = 'standard_box';
problem.module.calculation_type = 'parratt';    %or 'Fourier' etc....
problem.module.experiment_type = 'air liquid';      %or air solid etc....
problem.q4 = 'no';
problem.fitlowrange = [0.0001  0.0001  0.0001  0.0001  0.0001  0.0001  0.0001];
problem.fithirange =   [0.5     0.5     0.5     0.5     0.5     0.5     0.5];
problem.include_data = [1 1 1 1 1 0 0];
problem.resolution = 0.03;

%Parameters details
problem.params = [17 -0.4e-6 7e-6 4 10 2e-6 5e-6 4 3];
problem.fityesno = [1 1 1 1 1 1 1 1 1];
problem.paramnames = {'d chain','sld Hchain','sld Dchain','r chain','d head','sld Hhead','sld Dhead','r head','sub rough'};
problem.fiterrs = [0 0 0 0 0 0 0 0 0];

%Layers details
L1 = {'1,2,4' 'Hydrogenated Chain'};
L2 = {'1,3,4' 'Deuterated Chain'};
L3 = {'5,6,8' 'Hydrogenated head'};
L4 = {'5,7,8' 'Deuterated heads'};
problem.layersDetails = {L1 ; L2 ; L3 ; L4};

c1_lays = ['2,3'];
c2_lays = ['2,3'];
c3_lays = ['2,4'];
c4_lays = ['2,4'];
c5_lays = ['1,4'];
c6_lays = ['1,4'];
c7_lays = ['1,3'];
problem.contrastLayers = {c1_lays , c2_lays , c3_lays , c4_lays , c5_lays , c6_lays , c7_lays};


%constraints 
c_d_chain  =  [15 30];
c_sld_Hchain =  [-0.4e-6 0.5e-6];
c_sld_Dchain = [4e-6 8e-6];
c_r_chain = [3 7];
c_d_head = [7 15];
c_sld_Hhead = [1e-6 5e-6];
c_sld_Dhead = [3e-6 6e-6]; 
c_r_head = [3 7];
c_sub_rough = [3 8];

problem.constr = [c_d_chain;
c_sld_Hchain;
c_sld_Dchain;
c_r_chain;
c_d_head;
c_sld_Hhead;
c_sld_Dhead;
c_r_head;
c_sub_rough];

%Backgrounds....
problem.backs = [6e-006 3e-6];
backslb = [5e-7 5e-7];
backsub = [7e-6 7e-6];
problem.backs_constr = [backslb(:) backsub(:)];
problem.backgrounds_appliesto = {'1 3 5','2 4 6 7'};
problem.backgrounds_fityesno = [1   1];

%Q shifts
problem.shifts_horisontal = [0];
shiftslb = -0.03;
shiftsub = 0.03;
problem.shifts_constr = [shiftslb(:) shiftsub(:)];
problem.shifts_appliesto = {'1:7'};
problem.shifts_fityesno = 0;

%Scale factors
problem.scalefac = [0.2044];
scalelb = 0.1;
scaleub = 0.3;
problem.scale_constr = [scalelb(:) scaleub(:)];
problem.scalefac_appliesto = {'1:7'};
problem.scalefac_fityesno = 1;

%Nbairs....
problem.nba = 0;
nbairslb = 0;
nbairsub = 0;
problem.nbairs_constr = [nbairslb(:) nbairsub(:)];
problem.nbairs_appliesto = {'1:7'};
problem.nbairs_fityesno = 0;


%Nb subs.....
problem.nbs = [0 6.35e-6];
nbsubs_lb = [-0.1e-6 6.3e-6];
nbsubs_ub = [0.1e-6 6.4e-6];
problem.nbsubs_constr = [nbsubs_lb(:) nbsubs_ub(:)];
problem.nbsubs_appliesto = {'1 3 5','2 4 6 7'};
problem.nbsubs_fityesno = [0 0];

%problem.nbsubs = [0 6.35e-6 0 6.35e-6 0 6.35e-6 6.35e-6 6.35e-6];




