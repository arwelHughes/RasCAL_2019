/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * paratt.h
 *
 * Code generation for function 'paratt'
 *
 */

#ifndef PARATT_H
#define PARATT_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "omp.h"
#include "callParatt_types.h"

/* Function Declarations */
extern void paratt(const emxArray_real_T *x, const emxArray_real_T *sld, double
                   nbair, double nbsub, double nrepeats, double ssub, double
                   layers, double points, emxArray_real_T *out);

#endif

/* End of code generation (paratt.h) */
