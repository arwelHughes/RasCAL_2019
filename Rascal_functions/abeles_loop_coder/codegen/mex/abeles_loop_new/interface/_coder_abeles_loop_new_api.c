/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * _coder_abeles_loop_new_api.c
 *
 * Code generation for function '_coder_abeles_loop_new_api'
 *
 */

/* Include files */
#include "_coder_abeles_loop_new_api.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "abeles_loop_new_emxutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo i_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_abeles_loop_new_api",        /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_0 *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *slds, const
  char_T *identifier, emxArray_cell_wrap_1 *y);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_1 *y);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *simXdata,
  const char_T *identifier, emxArray_cell_wrap_0 *y);
static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_cell_wrap_0 *u);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nbairs,
  const char_T *identifier, emxArray_real_T *y);
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_0 *y)
{
  emlrtMsgIdentifier thisId;
  int32_T iv[2];
  static const boolean_T bv[2] = { false, true };

  int32_T sizes[2];
  int32_T i;
  char_T str[11];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  iv[0] = 1;
  iv[1] = -1;
  emlrtCheckVsCell(sp, parentId, u, 2U, iv, bv, sizes);
  i = y->size[0] * y->size[1];
  y->size[0] = sizes[0];
  y->size[1] = sizes[1];
  emxEnsureCapacity_cell_wrap_0(sp, y, i, (emlrtRTEInfo *)NULL);
  for (i = 0; i < sizes[1]; i++) {
    sprintf(&str[0], "%d", i + 1);
    thisId.fIdentifier = &str[0];
    c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i)), &thisId,
                       y->data[i].f1);
  }

  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *slds, const
  char_T *identifier, emxArray_cell_wrap_1 *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  e_emlrt_marshallIn(sp, emlrtAlias(slds), &thisId, y);
  emlrtDestroyArray(&slds);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_cell_wrap_1 *y)
{
  emlrtMsgIdentifier thisId;
  int32_T iv[2];
  static const boolean_T bv[2] = { false, true };

  int32_T sizes[2];
  int32_T i;
  char_T str[11];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  iv[0] = 1;
  iv[1] = -1;
  emlrtCheckVsCell(sp, parentId, u, 2U, iv, bv, sizes);
  i = y->size[0] * y->size[1];
  y->size[0] = sizes[0];
  y->size[1] = sizes[1];
  emxEnsureCapacity_cell_wrap_1(sp, y, i, (emlrtRTEInfo *)NULL);
  for (i = 0; i < sizes[1]; i++) {
    sprintf(&str[0], "%d", i + 1);
    thisId.fIdentifier = &str[0];
    f_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i)), &thisId,
                       y->data[i].f1);
  }

  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *simXdata,
  const char_T *identifier, emxArray_cell_wrap_0 *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(simXdata), &thisId, y);
  emlrtDestroyArray(&simXdata);
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_cell_wrap_0 *u)
{
  const mxArray *y;
  int32_T i;
  int32_T n;
  emxArray_real_T *b_u;
  int32_T i1;
  int32_T loop_ub;
  const mxArray *b_y;
  const mxArray *m;
  real_T *pData;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  y = NULL;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(1, *(int32_T (*)[1])u->size));
  i = 0;
  n = u->size[0];
  emxInit_real_T(sp, &b_u, 1, (emlrtRTEInfo *)NULL, true);
  while (i < n) {
    i1 = b_u->size[0];
    b_u->size[0] = u->data[i].f1->size[0];
    emxEnsureCapacity_real_T(sp, b_u, i1, (emlrtRTEInfo *)NULL);
    loop_ub = u->data[i].f1->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_u->data[i1] = u->data[i].f1->data[i1];
    }

    b_y = NULL;
    m = emlrtCreateNumericArray(1, &b_u->size[0], mxDOUBLE_CLASS, mxREAL);
    pData = emlrtMxGetPr(m);
    i1 = 0;
    for (loop_ub = 0; loop_ub < b_u->size[0]; loop_ub++) {
      pData[i1] = b_u->data[loop_ub];
      i1++;
    }

    emlrtAssign(&b_y, m);
    emlrtSetCell(y, i, b_y);
    i++;
  }

  emxFree_real_T(&b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nbairs,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  h_emlrt_marshallIn(sp, emlrtAlias(nbairs), &thisId, y);
  emlrtDestroyArray(&nbairs);
}

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[1] = { -1 };

  const boolean_T bv[1] = { true };

  int32_T iv[1];
  int32_T i;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv[0],
    iv);
  i = ret->size[0];
  ret->size[0] = iv[0];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { -1, 3 };

  const boolean_T bv[2] = { true, false };

  int32_T iv[2];
  int32_T i;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv[0],
    iv);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 1, -1 };

  const boolean_T bv[2] = { false, true };

  int32_T iv[2];
  int32_T i;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv[0],
    iv);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void abeles_loop_new_api(const mxArray * const prhs[7], int32_T nlhs, const
  mxArray *plhs[1])
{
  emxArray_cell_wrap_0 *simXdata;
  emxArray_cell_wrap_1 *slds;
  emxArray_real_T *nbairs;
  emxArray_real_T *nbsubs;
  emxArray_real_T *repeats;
  emxArray_real_T *resolutions;
  emxArray_real_T *ssubs;
  emxArray_cell_wrap_0 *simRef;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_cell_wrap_0(&st, &simXdata, 2, &i_emlrtRTEI, true);
  emxInit_cell_wrap_1(&st, &slds, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&st, &nbairs, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&st, &nbsubs, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&st, &repeats, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&st, &resolutions, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&st, &ssubs, 2, &i_emlrtRTEI, true);
  emxInit_cell_wrap_0(&st, &simRef, 1, &i_emlrtRTEI, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "simXdata", simXdata);
  d_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "slds", slds);
  nbairs->canFreeData = false;
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "nbairs", nbairs);
  nbsubs->canFreeData = false;
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "nbsubs", nbsubs);
  repeats->canFreeData = false;
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "repeats", repeats);
  resolutions->canFreeData = false;
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[5]), "resolutions", resolutions);
  ssubs->canFreeData = false;
  g_emlrt_marshallIn(&st, emlrtAlias(prhs[6]), "ssubs", ssubs);

  /* Invoke the target function */
  abeles_loop_new(&st, simXdata, slds, nbairs, nbsubs, repeats, resolutions,
                  ssubs, simRef);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, simRef);
  emxFree_cell_wrap_0(&simRef);
  emxFree_real_T(&ssubs);
  emxFree_real_T(&resolutions);
  emxFree_real_T(&repeats);
  emxFree_real_T(&nbsubs);
  emxFree_real_T(&nbairs);
  emxFree_cell_wrap_1(&slds);
  emxFree_cell_wrap_0(&simXdata);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_abeles_loop_new_api.c) */
