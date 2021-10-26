% ABELES_LOOP_NEW_CODEONLY_COMPILE_SCRIPT   Generate static library
%  abeles_loop_new from abeles_loop_new.
% 
% Script generated from project 'abeles_loop_new.prj' on 23-Oct-2021.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.EmbeddedCodeConfig'.
cfg = coder.config('lib','ecoder',true);
cfg.IncludeTerminateFcn = false;
cfg.IncludeInitializeFcn = false;
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;
cfg.DynamicMemoryAllocationInterface = 'C++';
cfg.TargetLang = 'C++';
cfg.PreserveArrayDimensions = true;
cfg.GenCodeOnly = true;
cfg.TargetLangStandard = 'C++11 (ISO)';
cfg.Verbose = true;

%% Define argument types for entry-point 'abeles_loop_new'.
ARGS = cell(1,1);
ARGS{1} = cell(7,1);
ARG = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{1} = coder.typeof({ARG}, [1 Inf],[0 1]);
ARG = coder.typeof(0,[Inf  3],[1 0]);
ARGS{1}{2} = coder.typeof({ARG}, [1 Inf],[0 1]);
ARGS{1}{3} = coder.typeof(0,[1 Inf],[0 1]);
ARGS{1}{4} = coder.typeof(0,[1 Inf],[0 1]);
ARGS{1}{5} = coder.typeof(0,[1 Inf],[0 1]);
ARGS{1}{6} = coder.typeof(0,[1 Inf],[0 1]);
ARGS{1}{7} = coder.typeof(0,[1 Inf],[0 1]);

%% Invoke MATLAB Coder.
codegen -config cfg abeles_loop_new -args ARGS{1}

