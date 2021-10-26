/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 * File: _coder_abeles_loop_new_mex.c
 *
 * MATLAB Coder version            : 5.0
 * C/C++ source code generated on  : 23-Oct-2021 10:24:46
 */

/* Include Files */
#include "_coder_abeles_loop_new_mex.h"
#include "_coder_abeles_loop_new_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void abeles_loop_new_mexFunction(int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[7]);

/* Function Definitions */

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[1]
 *                int32_T nrhs
 *                const mxArray *prhs[7]
 * Return Type  : void
 */
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

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[]
 *                int32_T nrhs
 *                const mxArray *prhs[]
 * Return Type  : void
 */
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

/*
 * Arguments    : void
 * Return Type  : emlrtCTX
 */
emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/*
 * File trailer for _coder_abeles_loop_new_mex.c
 *
 * [EOF]
 */
