/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * _coder_abeles_loop_new_mex.c
 *
 * Code generation for function '_coder_abeles_loop_new_mex'
 *
 */

/* Include files */
#include "_coder_abeles_loop_new_mex.h"
#include "_coder_abeles_loop_new_api.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "abeles_loop_new_initialize.h"
#include "abeles_loop_new_terminate.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void abeles_loop_new_mexFunction(int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[7]);

/* Function Definitions */
void abeles_loop_new_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[7])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 7) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 7, 4,
                        15, "abeles_loop_new");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 15,
                        "abeles_loop_new");
  }

  /* Call the function. */
  abeles_loop_new_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&abeles_loop_new_atexit);

  /* Module initialization. */
  abeles_loop_new_initialize();

  /* Dispatch the entry-point. */
  abeles_loop_new_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  abeles_loop_new_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_abeles_loop_new_mex.c) */
