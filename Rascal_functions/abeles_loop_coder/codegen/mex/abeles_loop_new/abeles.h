/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles.h
 *
 * Code generation for function 'abeles'
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
void abeles(const emlrtStack *sp, const emxArray_real_T *x, const
            emxArray_real_T *sld, real_T nbair, real_T nbsub, real_T nrepeats,
            real_T ssub, real_T layers, real_T points, emxArray_real_T *out);

/* End of code generation (abeles.h) */
