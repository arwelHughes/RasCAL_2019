% ABELES_LOOP_NEW_COMPILE_SCRIPT   Generate MEX-function abeles_loop_new_mex
%  from abeles_loop_new.
% 
% Script generated from project 'abeles_loop_new.prj' on 11-Nov-2021.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.config('mex');
cfg.TargetLang = 'C++';
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;

%% Define argument types for entry-point 'abeles_loop_new'.
ARGS = cell(1,1);
ARGS{1} = cell(7,1);
ARG = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{1} = coder.typeof({ARG}, [Inf  1],[1 0]);
ARG = coder.typeof(0,[Inf  3],[1 0]);
ARGS{1}{2} = coder.typeof({ARG}, [Inf  1],[1 0]);
ARGS{1}{3} = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{4} = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{5} = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{6} = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{7} = coder.typeof(0,[Inf  1],[1 0]);

%% Invoke MATLAB Coder.
codegen -config cfg abeles_loop_new -args ARGS{1}

