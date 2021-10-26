/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new_initialize.c
 *
 * Code generation for function 'abeles_loop_new_initialize'
 *
 */

/* Include files */
#include "abeles_loop_new_initialize.h"
#include "_coder_abeles_loop_new_mex.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void abeles_loop_new_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (abeles_loop_new_initialize.c) */
