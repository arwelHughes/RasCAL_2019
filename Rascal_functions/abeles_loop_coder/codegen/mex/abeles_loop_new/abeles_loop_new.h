//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// abeles_loop_new.h
//
// Code generation for function 'abeles_loop_new'
//

#pragma once

// Include files
#include "abeles_loop_new_types.h"
#include "rtwtypes.h"
#include "coder_array.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Function Declarations
void abeles_loop_new(const emlrtStack *sp,
                     const coder::array<cell_wrap_0, 1U> &simXdata,
                     const coder::array<cell_wrap_1, 1U> &slds,
                     const coder::array<real_T, 1U> &nbairs,
                     const coder::array<real_T, 1U> &nbsubs,
                     const coder::array<real_T, 1U> &repeats,
                     const coder::array<real_T, 1U> &resolutions,
                     const coder::array<real_T, 1U> &ssubs,
                     coder::array<cell_wrap_0, 1U> &simRef);

// End of code generation (abeles_loop_new.h)
