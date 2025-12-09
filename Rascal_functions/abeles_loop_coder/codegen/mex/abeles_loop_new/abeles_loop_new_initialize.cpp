//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// abeles_loop_new_initialize.cpp
//
// Code generation for function 'abeles_loop_new_initialize'
//

// Include files
#include "abeles_loop_new_initialize.h"
#include "_coder_abeles_loop_new_mex.h"
#include "abeles_loop_new_data.h"
#include "rt_nonfinite.h"

// Function Declarations
static void abeles_loop_new_once();

// Function Definitions
static void abeles_loop_new_once()
{
  mex_InitInfAndNan();
}

void abeles_loop_new_initialize()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    abeles_loop_new_once();
  }
}

// End of code generation (abeles_loop_new_initialize.cpp)
