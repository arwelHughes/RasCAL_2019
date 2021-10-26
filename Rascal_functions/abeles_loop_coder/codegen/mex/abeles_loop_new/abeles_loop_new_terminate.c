/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new_terminate.c
 *
 * Code generation for function 'abeles_loop_new_terminate'
 *
 */

/* Include files */
#include "abeles_loop_new_terminate.h"
#include "_coder_abeles_loop_new_mex.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void abeles_loop_new_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void abeles_loop_new_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (abeles_loop_new_terminate.c) */
