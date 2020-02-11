/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * _coder_callParatt_api.h
 *
 * Code generation for function '_coder_callParatt_api'
 *
 */

#ifndef _CODER_CALLPARATT_API_H
#define _CODER_CALLPARATT_API_H

/* Include files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_callParatt_api.h"

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

#ifndef typedef_emxArray_cell_wrap_2
#define typedef_emxArray_cell_wrap_2

typedef struct {
  cell_wrap_2 *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
} emxArray_cell_wrap_2;

#endif                                 /*typedef_emxArray_cell_wrap_2*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void callParatt(emxArray_cell_wrap_0 *simXdata, emxArray_cell_wrap_1
  *slds, emxArray_real_T *nbairs, emxArray_real_T *nbsubs, emxArray_real_T
  *repeats, emxArray_real_T *resolutions, emxArray_real_T *ssubs,
  emxArray_cell_wrap_2 *simRef);
extern void callParatt_api(const mxArray * const prhs[7], int32_T nlhs, const
  mxArray *plhs[1]);
extern void callParatt_atexit(void);
extern void callParatt_initialize(void);
extern void callParatt_terminate(void);
extern void callParatt_xil_shutdown(void);
extern void callParatt_xil_terminate(void);

#endif

/* End of code generation (_coder_callParatt_api.h) */
