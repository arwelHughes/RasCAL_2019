/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_types.h
 *
 * Code generation for function 'callParatt'
 *
 */

#ifndef CALLPARATT_TYPES_H
#define CALLPARATT_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
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

#ifndef typedef_cell_wrap_2
#define typedef_cell_wrap_2

typedef struct {
  emxArray_real_T *f1;
} cell_wrap_2;

#endif                                 /*typedef_cell_wrap_2*/

#ifndef typedef_emxArray_cell_wrap_0
#define typedef_emxArray_cell_wrap_0

typedef struct {
  cell_wrap_0 *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_0;

#endif                                 /*typedef_emxArray_cell_wrap_0*/

#ifndef typedef_emxArray_cell_wrap_1
#define typedef_emxArray_cell_wrap_1

typedef struct {
  cell_wrap_1 *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_1;

#endif                                 /*typedef_emxArray_cell_wrap_1*/

#ifndef typedef_emxArray_cell_wrap_2
#define typedef_emxArray_cell_wrap_2

typedef struct {
  cell_wrap_2 *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_2;

#endif                                 /*typedef_emxArray_cell_wrap_2*/
#endif

/* End of code generation (callParatt_types.h) */
