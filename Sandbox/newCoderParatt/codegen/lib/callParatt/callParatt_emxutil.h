/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_emxutil.h
 *
 * Code generation for function 'callParatt_emxutil'
 *
 */

#ifndef CALLPARATT_EMXUTIL_H
#define CALLPARATT_EMXUTIL_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "callParatt_types.h"

/* Function Declarations */
extern void emxEnsureCapacity_cell_wrap_2(emxArray_cell_wrap_2 *emxArray, int
  oldNumel);
extern void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int oldNumel);
extern void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);
extern void emxFree_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray);
extern void emxFree_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray, int
  numDimensions);
extern void emxInit_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray, int
  numDimensions);
extern void emxInit_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray, int
  numDimensions);
extern void emxInit_real_T(emxArray_real_T **pEmxArray, int numDimensions);

#endif

/* End of code generation (callParatt_emxutil.h) */
