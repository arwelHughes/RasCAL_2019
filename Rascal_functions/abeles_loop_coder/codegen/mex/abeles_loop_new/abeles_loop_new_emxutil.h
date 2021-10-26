/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new_emxutil.h
 *
 * Code generation for function 'abeles_loop_new_emxutil'
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
void emxEnsureCapacity_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  *emxArray, int32_T oldNumel, const emlrtRTEInfo *srcLocation);
void emxEnsureCapacity_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  *emxArray, int32_T oldNumel, const emlrtRTEInfo *srcLocation);
void emxEnsureCapacity_real_T(const emlrtStack *sp, emxArray_real_T *emxArray,
  int32_T oldNumel, const emlrtRTEInfo *srcLocation);
void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);
void emxFree_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray);
void emxFree_real_T(emxArray_real_T **pEmxArray);
void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0 **pEmxArray,
  int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
void emxInit_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1 **pEmxArray,
  int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray, int32_T
                    numDimensions, const emlrtRTEInfo *srcLocation, boolean_T
                    doPush);

/* End of code generation (abeles_loop_new_emxutil.h) */
