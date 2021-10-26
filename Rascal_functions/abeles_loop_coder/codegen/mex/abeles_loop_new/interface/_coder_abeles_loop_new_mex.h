/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * _coder_abeles_loop_new_mex.h
 *
 * Code generation for function '_coder_abeles_loop_new_mex'
 *
 */

#pragma once

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "abeles_loop_new_types.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void abeles_loop_new_mexFunction(int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[7]);
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
  const mxArray *prhs[]);
emlrtCTX mexFunctionCreateRootTLS(void);

/* End of code generation (_coder_abeles_loop_new_mex.h) */
