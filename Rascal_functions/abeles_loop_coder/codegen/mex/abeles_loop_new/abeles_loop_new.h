/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new.h
 *
 * Code generation for function 'abeles_loop_new'
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
void abeles_loop_new(const emlrtStack *sp, const emxArray_cell_wrap_0 *simXdata,
                     const emxArray_cell_wrap_1 *slds, const emxArray_real_T
                     *nbairs, const emxArray_real_T *nbsubs, const
                     emxArray_real_T *repeats, const emxArray_real_T
                     *resolutions, const emxArray_real_T *ssubs,
                     emxArray_cell_wrap_0 *simRef);

/* End of code generation (abeles_loop_new.h) */
