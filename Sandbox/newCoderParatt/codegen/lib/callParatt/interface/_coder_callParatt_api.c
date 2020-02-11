/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * _coder_callParatt_api.c
 *
 * Code generation for function '_coder_callParatt_api'
 *
 */

/* Include files */
#include <string.h>
#include "tmwtypes.h"
#include "_coder_callParatt_api.h"
#include "_coder_callParatt_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131482U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "callParatt",                        /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
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
  emxArray_cell_wrap_2 *u);
static void emxEnsureCapacity_cell_wrap_0(const emlrtStack *sp,
  emxArray_cell_wrap_0 *emxArray, int32_T oldNumel);
static void emxEnsureCapacity_cell_wrap_1(const emlrtStack *sp,
  emxArray_cell_wrap_1 *emxArray, int32_T oldNumel);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel);
static void emxExpand_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  *emxArray, int32_T fromIndex, int32_T toIndex);
static void emxExpand_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  *emxArray, int32_T fromIndex, int32_T toIndex);
static void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct);
static void emxFreeStruct_cell_wrap_1(cell_wrap_1 *pStruct);
static void emxFreeStruct_cell_wrap_2(cell_wrap_2 *pStruct);
static void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);
static void emxFree_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray);
static void emxFree_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInitStruct_cell_wrap_0(const emlrtStack *sp, cell_wrap_0 *pStruct,
  boolean_T doPush);
static void emxInitStruct_cell_wrap_1(const emlrtStack *sp, cell_wrap_1 *pStruct,
  boolean_T doPush);
static void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  **pEmxArray, int32_T numDimensions, boolean_T doPush);
static void emxInit_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  **pEmxArray, int32_T numDimensions, boolean_T doPush);
static void emxInit_cell_wrap_2(const emlrtStack *sp, emxArray_cell_wrap_2
  **pEmxArray, int32_T numDimensions, boolean_T doPush);
static void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush);
static void emxTrim_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T
  fromIndex, int32_T toIndex);
static void emxTrim_cell_wrap_1(emxArray_cell_wrap_1 *emxArray, int32_T
  fromIndex, int32_T toIndex);
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
  int32_T n[1];
  boolean_T bv0[1];
  int32_T sizes[1];
  int32_T i0;
  char_T str[11];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  n[0] = -1;
  bv0[0] = true;
  emlrtCheckVsCell(sp, parentId, u, 1U, n, bv0, sizes);
  i0 = y->size[0];
  y->size[0] = sizes[0];
  emxEnsureCapacity_cell_wrap_0(sp, y, i0);
  for (i0 = 0; i0 < sizes[0]; i0++) {
    sprintf(&str[0], "%d", i0 + 1);
    thisId.fIdentifier = &str[0];
    c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i0)),
                       &thisId, y->data[i0].f1);
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
  int32_T n[1];
  boolean_T bv1[1];
  int32_T sizes[1];
  int32_T i1;
  char_T str[11];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  n[0] = -1;
  bv1[0] = true;
  emlrtCheckVsCell(sp, parentId, u, 1U, n, bv1, sizes);
  i1 = y->size[0];
  y->size[0] = sizes[0];
  emxEnsureCapacity_cell_wrap_1(sp, y, i1);
  for (i1 = 0; i1 < sizes[0]; i1++) {
    sprintf(&str[0], "%d", i1 + 1);
    thisId.fIdentifier = &str[0];
    f_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i1)),
                       &thisId, y->data[i1].f1);
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
  emxArray_cell_wrap_2 *u)
{
  const mxArray *y;
  int32_T i2;
  int32_T n;
  emxArray_real_T *b_u;
  int32_T i3;
  int32_T loop_ub;
  const mxArray *b_y;
  const mxArray *m0;
  real_T *pData;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  y = NULL;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(1, *(int32_T (*)[1])u->size));
  i2 = 0;
  n = u->size[0];
  emxInit_real_T(sp, &b_u, 1, true);
  while (i2 < n) {
    i3 = b_u->size[0];
    b_u->size[0] = u->data[i2].f1->size[0];
    emxEnsureCapacity_real_T(b_u, i3);
    loop_ub = u->data[i2].f1->size[0];
    for (i3 = 0; i3 < loop_ub; i3++) {
      b_u->data[i3] = u->data[i2].f1->data[i3];
    }

    b_y = NULL;
    m0 = emlrtCreateNumericArray(1, *(int32_T (*)[1])b_u->size, mxDOUBLE_CLASS,
      mxREAL);
    pData = emlrtMxGetPr(m0);
    i3 = 0;
    for (loop_ub = 0; loop_ub < b_u->size[0]; loop_ub++) {
      pData[i3] = b_u->data[loop_ub];
      i3++;
    }

    emlrtAssign(&b_y, m0);
    emlrtSetCell(y, i2, b_y);
    i2++;
  }

  emxFree_real_T(&b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static void emxEnsureCapacity_cell_wrap_0(const emlrtStack *sp,
  emxArray_cell_wrap_0 *emxArray, int32_T oldNumel)
{
  int32_T newNumel;
  int32_T i;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i <<= 1;
      }
    }

    newData = emlrtCallocMex((uint32_T)i, sizeof(cell_wrap_0));
    if (emxArray->data != NULL) {
      memcpy(newData, emxArray->data, sizeof(cell_wrap_0) * oldNumel);
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = (cell_wrap_0 *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }

  if (oldNumel > newNumel) {
    emxTrim_cell_wrap_0(emxArray, newNumel, oldNumel);
  } else {
    if (oldNumel < newNumel) {
      emxExpand_cell_wrap_0(sp, emxArray, oldNumel, newNumel);
    }
  }
}

static void emxEnsureCapacity_cell_wrap_1(const emlrtStack *sp,
  emxArray_cell_wrap_1 *emxArray, int32_T oldNumel)
{
  int32_T newNumel;
  int32_T i;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i <<= 1;
      }
    }

    newData = emlrtCallocMex((uint32_T)i, sizeof(cell_wrap_1));
    if (emxArray->data != NULL) {
      memcpy(newData, emxArray->data, sizeof(cell_wrap_1) * oldNumel);
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = (cell_wrap_1 *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }

  if (oldNumel > newNumel) {
    emxTrim_cell_wrap_1(emxArray, newNumel, oldNumel);
  } else {
    if (oldNumel < newNumel) {
      emxExpand_cell_wrap_1(sp, emxArray, oldNumel, newNumel);
    }
  }
}

static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel)
{
  int32_T newNumel;
  int32_T i;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i <<= 1;
      }
    }

    newData = emlrtCallocMex((uint32_T)i, sizeof(real_T));
    if (emxArray->data != NULL) {
      memcpy(newData, emxArray->data, sizeof(real_T) * oldNumel);
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = (real_T *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxExpand_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  *emxArray, int32_T fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_cell_wrap_0(sp, &emxArray->data[i], false);
  }
}

static void emxExpand_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  *emxArray, int32_T fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_cell_wrap_1(sp, &emxArray->data[i], false);
  }
}

static void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

static void emxFreeStruct_cell_wrap_1(cell_wrap_1 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

static void emxFreeStruct_cell_wrap_2(cell_wrap_2 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

static void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray)
{
  int32_T numEl;
  int32_T i;
  if (*pEmxArray != (emxArray_cell_wrap_0 *)NULL) {
    if ((*pEmxArray)->data != (cell_wrap_0 *)NULL) {
      numEl = 1;
      for (i = 0; i < (*pEmxArray)->numDimensions; i++) {
        numEl *= (*pEmxArray)->size[i];
      }

      for (i = 0; i < numEl; i++) {
        emxFreeStruct_cell_wrap_0(&(*pEmxArray)->data[i]);
      }

      if ((*pEmxArray)->canFreeData) {
        emlrtFreeMex((*pEmxArray)->data);
      }
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_cell_wrap_0 *)NULL;
  }
}

static void emxFree_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray)
{
  int32_T numEl;
  int32_T i;
  if (*pEmxArray != (emxArray_cell_wrap_1 *)NULL) {
    if ((*pEmxArray)->data != (cell_wrap_1 *)NULL) {
      numEl = 1;
      for (i = 0; i < (*pEmxArray)->numDimensions; i++) {
        numEl *= (*pEmxArray)->size[i];
      }

      for (i = 0; i < numEl; i++) {
        emxFreeStruct_cell_wrap_1(&(*pEmxArray)->data[i]);
      }

      if ((*pEmxArray)->canFreeData) {
        emlrtFreeMex((*pEmxArray)->data);
      }
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_cell_wrap_1 *)NULL;
  }
}

static void emxFree_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray)
{
  int32_T numEl;
  int32_T i;
  if (*pEmxArray != (emxArray_cell_wrap_2 *)NULL) {
    if ((*pEmxArray)->data != (cell_wrap_2 *)NULL) {
      numEl = 1;
      for (i = 0; i < (*pEmxArray)->numDimensions; i++) {
        numEl *= (*pEmxArray)->size[i];
      }

      for (i = 0; i < numEl; i++) {
        emxFreeStruct_cell_wrap_2(&(*pEmxArray)->data[i]);
      }

      if ((*pEmxArray)->canFreeData) {
        emlrtFreeMex((*pEmxArray)->data);
      }
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_cell_wrap_2 *)NULL;
  }
}

static void emxFree_real_T(emxArray_real_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_real_T *)NULL) {
    if (((*pEmxArray)->data != (real_T *)NULL) && (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_real_T *)NULL;
  }
}

static void emxInitStruct_cell_wrap_0(const emlrtStack *sp, cell_wrap_0 *pStruct,
  boolean_T doPush)
{
  emxInit_real_T(sp, &pStruct->f1, 2, doPush);
}

static void emxInitStruct_cell_wrap_1(const emlrtStack *sp, cell_wrap_1 *pStruct,
  boolean_T doPush)
{
  emxInit_real_T(sp, &pStruct->f1, 2, doPush);
}

static void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_cell_wrap_0 *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_cell_wrap_0 *)emlrtMallocMex(sizeof
    (emxArray_cell_wrap_0));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_cell_wrap_0);
  }

  emxArray = *pEmxArray;
  emxArray->data = (cell_wrap_0 *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_cell_wrap_1 *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_cell_wrap_1 *)emlrtMallocMex(sizeof
    (emxArray_cell_wrap_1));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_cell_wrap_1);
  }

  emxArray = *pEmxArray;
  emxArray->data = (cell_wrap_1 *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_cell_wrap_2(const emlrtStack *sp, emxArray_cell_wrap_2
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_cell_wrap_2 *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_cell_wrap_2 *)emlrtMallocMex(sizeof
    (emxArray_cell_wrap_2));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_cell_wrap_2);
  }

  emxArray = *pEmxArray;
  emxArray->data = (cell_wrap_2 *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_real_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (real_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxTrim_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T
  fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxFreeStruct_cell_wrap_0(&emxArray->data[i]);
  }
}

static void emxTrim_cell_wrap_1(emxArray_cell_wrap_1 *emxArray, int32_T
  fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxFreeStruct_cell_wrap_1(&emxArray->data[i]);
  }
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
  static const int32_T dims[2] = { 1, -1 };

  const boolean_T bv2[2] = { false, true };

  int32_T iv0[2];
  int32_T i4;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv2[0],
    iv0);
  i4 = ret->size[0] * ret->size[1];
  ret->size[0] = iv0[0];
  ret->size[1] = iv0[1];
  emxEnsureCapacity_real_T(ret, i4);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { -1, 3 };

  const boolean_T bv3[2] = { true, false };

  int32_T iv1[2];
  int32_T i5;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv3[0],
    iv1);
  i5 = ret->size[0] * ret->size[1];
  ret->size[0] = iv1[0];
  ret->size[1] = iv1[1];
  emxEnsureCapacity_real_T(ret, i5);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[1] = { -1 };

  const boolean_T bv4[1] = { true };

  int32_T iv2[1];
  int32_T i6;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 1U, dims, &bv4[0],
    iv2);
  ret->allocatedSize = iv2[0];
  i6 = ret->size[0];
  ret->size[0] = iv2[0];
  emxEnsureCapacity_real_T(ret, i6);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void callParatt_api(const mxArray * const prhs[7], int32_T nlhs, const mxArray
                    *plhs[1])
{
  emxArray_cell_wrap_0 *simXdata;
  emxArray_cell_wrap_1 *slds;
  emxArray_real_T *nbairs;
  emxArray_real_T *nbsubs;
  emxArray_real_T *repeats;
  emxArray_real_T *resolutions;
  emxArray_real_T *ssubs;
  emxArray_cell_wrap_2 *simRef;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_cell_wrap_0(&st, &simXdata, 1, true);
  emxInit_cell_wrap_1(&st, &slds, 1, true);
  emxInit_real_T(&st, &nbairs, 1, true);
  emxInit_real_T(&st, &nbsubs, 1, true);
  emxInit_real_T(&st, &repeats, 1, true);
  emxInit_real_T(&st, &resolutions, 1, true);
  emxInit_real_T(&st, &ssubs, 1, true);
  emxInit_cell_wrap_2(&st, &simRef, 1, true);

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
  callParatt(simXdata, slds, nbairs, nbsubs, repeats, resolutions, ssubs, simRef);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, simRef);
  emxFree_cell_wrap_2(&simRef);
  emxFree_real_T(&ssubs);
  emxFree_real_T(&resolutions);
  emxFree_real_T(&repeats);
  emxFree_real_T(&nbsubs);
  emxFree_real_T(&nbairs);
  emxFree_cell_wrap_1(&slds);
  emxFree_cell_wrap_0(&simXdata);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

void callParatt_atexit(void)
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
  callParatt_xil_terminate();
  callParatt_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void callParatt_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void callParatt_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (_coder_callParatt_api.c) */
