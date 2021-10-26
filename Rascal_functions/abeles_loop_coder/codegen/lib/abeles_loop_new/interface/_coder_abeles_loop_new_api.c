/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 * File: _coder_abeles_loop_new_api.c
 *
 * MATLAB Coder version            : 5.0
 * C/C++ source code generated on  : 23-Oct-2021 10:24:46
 */

/* Include Files */
#include "_coder_abeles_loop_new_api.h"
#include "_coder_abeles_loop_new_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131594U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "abeles_loop_new",                   /* fFunctionName */
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
  emxArray_cell_wrap_0 *u);
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
static void emxFree_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray);
static void emxFree_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInitStruct_cell_wrap_0(const emlrtStack *sp, cell_wrap_0 *pStruct,
  boolean_T doPush);
static void emxInitStruct_cell_wrap_1(const emlrtStack *sp, cell_wrap_1 *pStruct,
  boolean_T doPush);
static void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  **pEmxArray, int32_T numDimensions, boolean_T doPush);
static void emxInit_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                emxArray_cell_wrap_0 *y
 * Return Type  : void
 */
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
  emxEnsureCapacity_cell_wrap_0(sp, y, i);
  for (i = 0; i < sizes[1]; i++) {
    sprintf(&str[0], "%d", i + 1);
    thisId.fIdentifier = &str[0];
    c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i)), &thisId,
                       y->data[i].f1);
  }

  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                emxArray_real_T *y
 * Return Type  : void
 */
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *slds
 *                const char_T *identifier
 *                emxArray_cell_wrap_1 *y
 * Return Type  : void
 */
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                emxArray_cell_wrap_1 *y
 * Return Type  : void
 */
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
  emxEnsureCapacity_cell_wrap_1(sp, y, i);
  for (i = 0; i < sizes[1]; i++) {
    sprintf(&str[0], "%d", i + 1);
    thisId.fIdentifier = &str[0];
    f_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell(sp, parentId, u, i)), &thisId,
                       y->data[i].f1);
  }

  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *simXdata
 *                const char_T *identifier
 *                emxArray_cell_wrap_0 *y
 * Return Type  : void
 */
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

/*
 * Arguments    : const emlrtStack *sp
 *                const emxArray_cell_wrap_0 *u
 * Return Type  : const mxArray *
 */
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
  int32_T b_n[1];
  const mxArray *m;
  real_T *pData;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  y = NULL;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(1, *(int32_T (*)[1])u->size));
  i = 0;
  n = u->size[0];
  emxInit_real_T(sp, &b_u, 1, true);
  while (i < n) {
    i1 = b_u->size[0];
    b_u->size[0] = u->data[i].f1->size[0];
    emxEnsureCapacity_real_T(b_u, i1);
    loop_ub = u->data[i].f1->size[0];
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_u->data[i1] = u->data[i].f1->data[i1];
    }

    b_y = NULL;
    b_n[0] = b_u->size[0];
    m = emlrtCreateNumericArray(1, &b_n[0], mxDOUBLE_CLASS, mxREAL);
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

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_0 *emxArray
 *                int32_T oldNumel
 * Return Type  : void
 */
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
        i *= 2;
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

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_1 *emxArray
 *                int32_T oldNumel
 * Return Type  : void
 */
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
        i *= 2;
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

/*
 * Arguments    : emxArray_real_T *emxArray
 *                int32_T oldNumel
 * Return Type  : void
 */
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
        i *= 2;
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

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_0 *emxArray
 *                int32_T fromIndex
 *                int32_T toIndex
 * Return Type  : void
 */
static void emxExpand_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  *emxArray, int32_T fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_cell_wrap_0(sp, &emxArray->data[i], false);
  }
}

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_1 *emxArray
 *                int32_T fromIndex
 *                int32_T toIndex
 * Return Type  : void
 */
static void emxExpand_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  *emxArray, int32_T fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_cell_wrap_1(sp, &emxArray->data[i], false);
  }
}

/*
 * Arguments    : cell_wrap_0 *pStruct
 * Return Type  : void
 */
static void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

/*
 * Arguments    : cell_wrap_1 *pStruct
 * Return Type  : void
 */
static void emxFreeStruct_cell_wrap_1(cell_wrap_1 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

/*
 * Arguments    : emxArray_cell_wrap_0 **pEmxArray
 * Return Type  : void
 */
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

/*
 * Arguments    : emxArray_cell_wrap_1 **pEmxArray
 * Return Type  : void
 */
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

/*
 * Arguments    : emxArray_real_T **pEmxArray
 * Return Type  : void
 */
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

/*
 * Arguments    : const emlrtStack *sp
 *                cell_wrap_0 *pStruct
 *                boolean_T doPush
 * Return Type  : void
 */
static void emxInitStruct_cell_wrap_0(const emlrtStack *sp, cell_wrap_0 *pStruct,
  boolean_T doPush)
{
  emxInit_real_T(sp, &pStruct->f1, 1, doPush);
}

/*
 * Arguments    : const emlrtStack *sp
 *                cell_wrap_1 *pStruct
 *                boolean_T doPush
 * Return Type  : void
 */
static void emxInitStruct_cell_wrap_1(const emlrtStack *sp, cell_wrap_1 *pStruct,
  boolean_T doPush)
{
  emxInit_real_T(sp, &pStruct->f1, 2, doPush);
}

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_0 **pEmxArray
 *                int32_T numDimensions
 *                boolean_T doPush
 * Return Type  : void
 */
static void emxInit_cell_wrap_0(const emlrtStack *sp, emxArray_cell_wrap_0
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_cell_wrap_0 *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_cell_wrap_0 *)emlrtMallocMex(sizeof
    (emxArray_cell_wrap_0));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void *)
      &emxFree_cell_wrap_0);
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

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_cell_wrap_1 **pEmxArray
 *                int32_T numDimensions
 *                boolean_T doPush
 * Return Type  : void
 */
static void emxInit_cell_wrap_1(const emlrtStack *sp, emxArray_cell_wrap_1
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_cell_wrap_1 *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_cell_wrap_1 *)emlrtMallocMex(sizeof
    (emxArray_cell_wrap_1));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void *)
      &emxFree_cell_wrap_1);
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

/*
 * Arguments    : const emlrtStack *sp
 *                emxArray_real_T **pEmxArray
 *                int32_T numDimensions
 *                boolean_T doPush
 * Return Type  : void
 */
static void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void *)
      &emxFree_real_T);
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

/*
 * Arguments    : emxArray_cell_wrap_0 *emxArray
 *                int32_T fromIndex
 *                int32_T toIndex
 * Return Type  : void
 */
static void emxTrim_cell_wrap_0(emxArray_cell_wrap_0 *emxArray, int32_T
  fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxFreeStruct_cell_wrap_0(&emxArray->data[i]);
  }
}

/*
 * Arguments    : emxArray_cell_wrap_1 *emxArray
 *                int32_T fromIndex
 *                int32_T toIndex
 * Return Type  : void
 */
static void emxTrim_cell_wrap_1(emxArray_cell_wrap_1 *emxArray, int32_T
  fromIndex, int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxFreeStruct_cell_wrap_1(&emxArray->data[i]);
  }
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                emxArray_real_T *y
 * Return Type  : void
 */
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nbairs
 *                const char_T *identifier
 *                emxArray_real_T *y
 * Return Type  : void
 */
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

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                emxArray_real_T *y
 * Return Type  : void
 */
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                emxArray_real_T *ret
 * Return Type  : void
 */
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
  emxEnsureCapacity_real_T(ret, i);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                emxArray_real_T *ret
 * Return Type  : void
 */
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
  emxEnsureCapacity_real_T(ret, i);
  emlrtImportArrayR2015b(sp, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                emxArray_real_T *ret
 * Return Type  : void
 */
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
  emxEnsureCapacity_real_T(ret, i);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const mxArray * const prhs[7]
 *                int32_T nlhs
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
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
  emxInit_cell_wrap_0(&st, &simXdata, 2, true);
  emxInit_cell_wrap_1(&st, &slds, 2, true);
  emxInit_real_T(&st, &nbairs, 2, true);
  emxInit_real_T(&st, &nbsubs, 2, true);
  emxInit_real_T(&st, &repeats, 2, true);
  emxInit_real_T(&st, &resolutions, 2, true);
  emxInit_real_T(&st, &ssubs, 2, true);
  emxInit_cell_wrap_0(&st, &simRef, 1, true);

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
  abeles_loop_new(simXdata, slds, nbairs, nbsubs, repeats, resolutions, ssubs,
                  simRef);

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

/*
 * Arguments    : void
 * Return Type  : void
 */
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
  abeles_loop_new_xil_terminate();
  abeles_loop_new_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void abeles_loop_new_initialize(void)
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

/*
 * Arguments    : void
 * Return Type  : void
 */
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

/*
 * File trailer for _coder_abeles_loop_new_api.c
 *
 * [EOF]
 */
