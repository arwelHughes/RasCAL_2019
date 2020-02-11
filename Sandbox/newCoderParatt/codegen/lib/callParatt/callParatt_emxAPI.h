/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_emxAPI.h
 *
 * Code generation for function 'callParatt_emxAPI'
 *
 */

#ifndef CALLPARATT_EMXAPI_H
#define CALLPARATT_EMXAPI_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "callParatt_types.h"

/* Function Declarations */
extern emxArray_cell_wrap_0 *emxCreateND_cell_wrap_0(int numDimensions, int
  *size);
extern emxArray_cell_wrap_1 *emxCreateND_cell_wrap_1(int numDimensions, int
  *size);
extern emxArray_cell_wrap_2 *emxCreateND_cell_wrap_2(int numDimensions, int
  *size);
extern emxArray_real_T *emxCreateND_real_T(int numDimensions, int *size);
extern emxArray_cell_wrap_0 *emxCreateWrapperND_cell_wrap_0(cell_wrap_0 *data,
  int numDimensions, int *size);
extern emxArray_cell_wrap_1 *emxCreateWrapperND_cell_wrap_1(cell_wrap_1 *data,
  int numDimensions, int *size);
extern emxArray_cell_wrap_2 *emxCreateWrapperND_cell_wrap_2(cell_wrap_2 *data,
  int numDimensions, int *size);
extern emxArray_real_T *emxCreateWrapperND_real_T(double *data, int
  numDimensions, int *size);
extern emxArray_cell_wrap_0 *emxCreateWrapper_cell_wrap_0(cell_wrap_0 *data, int
  rows, int cols);
extern emxArray_cell_wrap_1 *emxCreateWrapper_cell_wrap_1(cell_wrap_1 *data, int
  rows, int cols);
extern emxArray_cell_wrap_2 *emxCreateWrapper_cell_wrap_2(cell_wrap_2 *data, int
  rows, int cols);
extern emxArray_real_T *emxCreateWrapper_real_T(double *data, int rows, int cols);
extern emxArray_cell_wrap_0 *emxCreate_cell_wrap_0(int rows, int cols);
extern emxArray_cell_wrap_1 *emxCreate_cell_wrap_1(int rows, int cols);
extern emxArray_cell_wrap_2 *emxCreate_cell_wrap_2(int rows, int cols);
extern emxArray_real_T *emxCreate_real_T(int rows, int cols);
extern void emxDestroyArray_cell_wrap_0(emxArray_cell_wrap_0 *emxArray);
extern void emxDestroyArray_cell_wrap_1(emxArray_cell_wrap_1 *emxArray);
extern void emxDestroyArray_cell_wrap_2(emxArray_cell_wrap_2 *emxArray);
extern void emxDestroyArray_real_T(emxArray_real_T *emxArray);
extern void emxInitArray_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray, int
  numDimensions);
extern void emxInitArray_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray, int
  numDimensions);
extern void emxInitArray_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray, int
  numDimensions);
extern void emxInitArray_real_T(emxArray_real_T **pEmxArray, int numDimensions);

#endif

/* End of code generation (callParatt_emxAPI.h) */
