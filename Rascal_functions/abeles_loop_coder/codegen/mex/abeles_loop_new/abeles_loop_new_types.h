/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new_types.h
 *
 * Code generation for function 'abeles_loop_new_types'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_cell_wrap_0
#define typedef_cell_wrap_0

typedef struct {
  emxArray_real_T *f1;
} cell_wrap_0;

#endif                                 /*typedef_cell_wrap_0*/

#ifndef typedef_cell_wrap_1
#define typedef_cell_wrap_1

typedef struct {
  emxArray_real_T *f1;
} cell_wrap_1;

#endif                                 /*typedef_cell_wrap_1*/

#ifndef typedef_emxArray_cell_wrap_0
#define typedef_emxArray_cell_wrap_0

typedef struct {
  cell_wrap_0 *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_0;

#endif                                 /*typedef_emxArray_cell_wrap_0*/

#ifndef typedef_emxArray_cell_wrap_1
#define typedef_emxArray_cell_wrap_1

typedef struct {
  cell_wrap_1 *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_1;

#endif                                 /*typedef_emxArray_cell_wrap_1*/

/* End of code generation (abeles_loop_new_types.h) */
