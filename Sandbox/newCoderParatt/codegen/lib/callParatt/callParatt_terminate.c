/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_terminate.c
 *
 * Code generation for function 'callParatt_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "callParatt_terminate.h"
#include "callParatt_data.h"

/* Function Definitions */
void callParatt_terminate(void)
{
  omp_destroy_nest_lock(&emlrtNestLockGlobal);
}

/* End of code generation (callParatt_terminate.c) */
