/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt.h
 *
 * Code generation for function 'callParatt'
 *
 */

#ifndef CALLPARATT_H
#define CALLPARATT_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "callParatt_types.h"

/* Function Declarations */
extern void callParatt(const emxArray_cell_wrap_0 *simXdata, const
  emxArray_cell_wrap_1 *slds, const emxArray_real_T *nbairs, const
  emxArray_real_T *nbsubs, const emxArray_real_T *repeats, const emxArray_real_T
  *resolutions, const emxArray_real_T *ssubs, emxArray_cell_wrap_2 *simRef);

#endif

/* End of code generation (callParatt.h) */
