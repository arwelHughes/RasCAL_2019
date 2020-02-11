/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_initialize.c
 *
 * Code generation for function 'callParatt_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "callParatt_initialize.h"
#include "callParatt_data.h"

/* Function Definitions */
void callParatt_initialize(void)
{
  rt_InitInfAndNaN(8U);
  omp_init_nest_lock(&emlrtNestLockGlobal);
}

/* End of code generation (callParatt_initialize.c) */
