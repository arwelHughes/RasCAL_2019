//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// _coder_abeles_loop_new_mex.h
//
// Code generation for function 'abeles_loop_new'
//

#ifndef _CODER_ABELES_LOOP_NEW_MEX_H
#define _CODER_ABELES_LOOP_NEW_MEX_H

// Include files
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"

// Function Declarations
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[],
                                     int32_T nrhs, const mxArray *prhs[]);

emlrtCTX mexFunctionCreateRootTLS();

void unsafe_abeles_loop_new_mexFunction(int32_T nlhs, mxArray *plhs[1],
                                        int32_T nrhs, const mxArray *prhs[7]);

#endif
// End of code generation (_coder_abeles_loop_new_mex.h)
