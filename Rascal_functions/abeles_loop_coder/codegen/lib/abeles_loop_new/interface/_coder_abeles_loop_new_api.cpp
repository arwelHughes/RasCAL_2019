//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// _coder_abeles_loop_new_api.cpp
//
// Code generation for function 'abeles_loop_new'
//

// Include files
#include "_coder_abeles_loop_new_api.h"
#include "_coder_abeles_loop_new_mex.h"
#include "coder_array_mex.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131610U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "abeles_loop_new",                                    // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, // fSigWrd
    nullptr                                               // fSigMem
};

// Function Declarations
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 2U> &ret);

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               coder::array<real_T, 1U> &y);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 1U> &ret);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 1U> &ret);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *simXdata,
                             const char_T *identifier,
                             coder::array<cell_wrap_0, 1U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<cell_wrap_0, 1U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 1U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *slds,
                             const char_T *identifier,
                             coder::array<cell_wrap_1, 1U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<cell_wrap_1, 1U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 2U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nbairs,
                             const char_T *identifier,
                             coder::array<real_T, 1U> &y);

static const mxArray *emlrt_marshallOut(const coder::array<cell_wrap_0, 1U> &u);

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 1U> &u);

// Function Definitions
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 2U> &ret)
{
  static const int32_T dims[2]{-1, 3};
  int32_T iv[2];
  const boolean_T bv[2]{true, false};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 2U, (void *)&dims[0], &bv[0], &iv[0]);
  ret.set_size(iv[0], iv[1]);
  emlrtImportArrayR2015b((emlrtCTX)sp, src, &ret[0], 8, false);
  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               coder::array<real_T, 1U> &y)
{
  d_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 1U> &ret)
{
  static const int32_T dims{-1};
  int32_T i;
  const boolean_T b{true};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 1U, (void *)&dims, &b, &i);
  ret.set_size(i);
  emlrtImportArrayR2015b((emlrtCTX)sp, src, &(ret.data())[0], 8, false);
  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 1U> &ret)
{
  static const int32_T dims{-1};
  int32_T i;
  const boolean_T b{true};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 1U, (void *)&dims, &b, &i);
  ret.prealloc(i);
  ret.set_size(i);
  ret.set((real_T *)emlrtMxGetData(src), ret.size(0));
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *simXdata,
                             const char_T *identifier,
                             coder::array<cell_wrap_0, 1U> &y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(simXdata), &thisId, y);
  emlrtDestroyArray(&simXdata);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<cell_wrap_0, 1U> &y)
{
  emlrtMsgIdentifier thisId;
  int32_T n;
  int32_T sizes;
  char_T str[11];
  boolean_T b;
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  n = -1;
  b = true;
  emlrtCheckVsCell((emlrtCTX)sp, parentId, u, 1U, &n, &b, &sizes);
  y.set_size(sizes);
  for (n = 0; n < sizes; n++) {
    sprintf(&str[0], "%d", n + 1);
    thisId.fIdentifier = &str[0];
    emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, n)),
                     &thisId, y[n].f1);
  }
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 1U> &y)
{
  c_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *slds,
                             const char_T *identifier,
                             coder::array<cell_wrap_1, 1U> &y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(slds), &thisId, y);
  emlrtDestroyArray(&slds);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<cell_wrap_1, 1U> &y)
{
  emlrtMsgIdentifier thisId;
  int32_T n;
  int32_T sizes;
  char_T str[11];
  boolean_T b;
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  n = -1;
  b = true;
  emlrtCheckVsCell((emlrtCTX)sp, parentId, u, 1U, &n, &b, &sizes);
  y.set_size(sizes);
  for (n = 0; n < sizes; n++) {
    sprintf(&str[0], "%d", n + 1);
    thisId.fIdentifier = &str[0];
    emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, n)),
                     &thisId, y[n].f1);
  }
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 2U> &y)
{
  b_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *nbairs,
                             const char_T *identifier,
                             coder::array<real_T, 1U> &y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(nbairs), &thisId, y);
  emlrtDestroyArray(&nbairs);
}

static const mxArray *emlrt_marshallOut(const coder::array<cell_wrap_0, 1U> &u)
{
  const mxArray *y;
  y = nullptr;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(
                      1, ((coder::array<cell_wrap_0, 1U> *)&u)->size()));
  for (int32_T i{0}; i < u.size(0); i++) {
    emlrtSetCell(y, i, emlrt_marshallOut(u[i].f1));
  }
  return y;
}

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 1U> &u)
{
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T i;
  y = nullptr;
  i = u.size(0);
  m = emlrtCreateNumericArray(1, &i, mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (int32_T b_i{0}; b_i < u.size(0); b_i++) {
    pData[i] = u[b_i];
    i++;
  }
  emlrtAssign(&y, m);
  return y;
}

void abeles_loop_new_api(const mxArray *const prhs[7], const mxArray **plhs)
{
  coder::array<cell_wrap_0, 1U> simRef;
  coder::array<cell_wrap_0, 1U> simXdata;
  coder::array<cell_wrap_1, 1U> slds;
  coder::array<real_T, 1U> nbairs;
  coder::array<real_T, 1U> nbsubs;
  coder::array<real_T, 1U> repeats;
  coder::array<real_T, 1U> resolutions;
  coder::array<real_T, 1U> ssubs;
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  // Marshall function inputs
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "simXdata", simXdata);
  emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "slds", slds);
  nbairs.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "nbairs", nbairs);
  nbsubs.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "nbsubs", nbsubs);
  repeats.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "repeats", repeats);
  resolutions.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "resolutions", resolutions);
  ssubs.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "ssubs", ssubs);
  // Invoke the target function
  abeles_loop_new(simXdata, slds, nbairs, nbsubs, repeats, resolutions, ssubs,
                  simRef);
  // Marshall function outputs
  *plhs = emlrt_marshallOut(simRef);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

void abeles_loop_new_atexit()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  abeles_loop_new_xil_terminate();
  abeles_loop_new_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
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
  emlrtClearAllocCountR2012b(&st, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void abeles_loop_new_terminate()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

// End of code generation (_coder_abeles_loop_new_api.cpp)
