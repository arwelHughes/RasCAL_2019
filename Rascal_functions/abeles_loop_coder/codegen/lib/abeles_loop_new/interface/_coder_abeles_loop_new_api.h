/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 * File: _coder_abeles_loop_new_api.h
 *
 * MATLAB Coder version            : 5.0
 * C/C++ source code generated on  : 23-Oct-2021 10:24:46
 */

#ifndef _CODER_ABELES_LOOP_NEW_API_H
#define _CODER_ABELES_LOOP_NEW_API_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

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

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void abeles_loop_new(emxArray_cell_wrap_0 *simXdata, emxArray_cell_wrap_1
  *slds, emxArray_real_T *nbairs, emxArray_real_T *nbsubs, emxArray_real_T
  *repeats, emxArray_real_T *resolutions, emxArray_real_T *ssubs,
  emxArray_cell_wrap_0 *simRef);
extern void abeles_loop_new_api(const mxArray * const prhs[7], int32_T nlhs,
  const mxArray *plhs[1]);
extern void abeles_loop_new_atexit(void);
extern void abeles_loop_new_initialize(void);
extern void abeles_loop_new_terminate(void);
extern void abeles_loop_new_xil_shutdown(void);
extern void abeles_loop_new_xil_terminate(void);

#endif

/*
 * File trailer for _coder_abeles_loop_new_api.h
 *
 * [EOF]
 */
