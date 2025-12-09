//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// _coder_abeles_loop_new_api.h
//
// Code generation for function 'abeles_loop_new'
//

#ifndef _CODER_ABELES_LOOP_NEW_API_H
#define _CODER_ABELES_LOOP_NEW_API_H

// Include files
#include "coder_array_mex.h"
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <algorithm>
#include <cstring>

// Type Definitions
struct cell_wrap_0 {
  coder::array<real_T, 1U> f1;
};

struct cell_wrap_1 {
  coder::array<real_T, 2U> f1;
};

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void abeles_loop_new(coder::array<cell_wrap_0, 1U> *simXdata,
                     coder::array<cell_wrap_1, 1U> *slds,
                     coder::array<real_T, 1U> *nbairs,
                     coder::array<real_T, 1U> *nbsubs,
                     coder::array<real_T, 1U> *repeats,
                     coder::array<real_T, 1U> *resolutions,
                     coder::array<real_T, 1U> *ssubs,
                     coder::array<cell_wrap_0, 1U> *simRef);

void abeles_loop_new_api(const mxArray *const prhs[7], const mxArray **plhs);

void abeles_loop_new_atexit();

void abeles_loop_new_initialize();

void abeles_loop_new_terminate();

void abeles_loop_new_xil_shutdown();

void abeles_loop_new_xil_terminate();

#endif
// End of code generation (_coder_abeles_loop_new_api.h)
