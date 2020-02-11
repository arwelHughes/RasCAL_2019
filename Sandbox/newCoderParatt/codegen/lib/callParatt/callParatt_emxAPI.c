/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_emxAPI.c
 *
 * Code generation for function 'callParatt_emxAPI'
 *
 */

/* Include files */
#include <stdlib.h>
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "callParatt_emxAPI.h"
#include "callParatt_emxutil.h"

/* Function Definitions */
emxArray_cell_wrap_0 *emxCreateND_cell_wrap_0(int numDimensions, int *size)
{
  emxArray_cell_wrap_0 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_0(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = (cell_wrap_0 *)calloc((unsigned int)numEl, sizeof(cell_wrap_0));
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_cell_wrap_1 *emxCreateND_cell_wrap_1(int numDimensions, int *size)
{
  emxArray_cell_wrap_1 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_1(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = (cell_wrap_1 *)calloc((unsigned int)numEl, sizeof(cell_wrap_1));
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_cell_wrap_2 *emxCreateND_cell_wrap_2(int numDimensions, int *size)
{
  emxArray_cell_wrap_2 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_2(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = (cell_wrap_2 *)calloc((unsigned int)numEl, sizeof(cell_wrap_2));
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_real_T *emxCreateND_real_T(int numDimensions, int *size)
{
  emxArray_real_T *emx;
  int numEl;
  int i;
  emxInit_real_T(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = (double *)calloc((unsigned int)numEl, sizeof(double));
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_cell_wrap_0 *emxCreateWrapperND_cell_wrap_0(cell_wrap_0 *data, int
  numDimensions, int *size)
{
  emxArray_cell_wrap_0 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_0(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = data;
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_1 *emxCreateWrapperND_cell_wrap_1(cell_wrap_1 *data, int
  numDimensions, int *size)
{
  emxArray_cell_wrap_1 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_1(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = data;
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_2 *emxCreateWrapperND_cell_wrap_2(cell_wrap_2 *data, int
  numDimensions, int *size)
{
  emxArray_cell_wrap_2 *emx;
  int numEl;
  int i;
  emxInit_cell_wrap_2(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = data;
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  emx->canFreeData = false;
  return emx;
}

emxArray_real_T *emxCreateWrapperND_real_T(double *data, int numDimensions, int *
  size)
{
  emxArray_real_T *emx;
  int numEl;
  int i;
  emxInit_real_T(&emx, numDimensions);
  numEl = 1;
  for (i = 0; i < numDimensions; i++) {
    numEl *= size[i];
    emx->size[i] = size[i];
  }

  emx->data = data;
  emx->numDimensions = numDimensions;
  emx->allocatedSize = numEl;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_0 *emxCreateWrapper_cell_wrap_0(cell_wrap_0 *data, int rows,
  int cols)
{
  emxArray_cell_wrap_0 *emx;
  emxInit_cell_wrap_0(&emx, 2);
  emx->size[0] = rows;
  emx->size[1] = cols;
  emx->data = data;
  emx->numDimensions = 2;
  emx->allocatedSize = rows * cols;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_1 *emxCreateWrapper_cell_wrap_1(cell_wrap_1 *data, int rows,
  int cols)
{
  emxArray_cell_wrap_1 *emx;
  emxInit_cell_wrap_1(&emx, 2);
  emx->size[0] = rows;
  emx->size[1] = cols;
  emx->data = data;
  emx->numDimensions = 2;
  emx->allocatedSize = rows * cols;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_2 *emxCreateWrapper_cell_wrap_2(cell_wrap_2 *data, int rows,
  int cols)
{
  emxArray_cell_wrap_2 *emx;
  emxInit_cell_wrap_2(&emx, 2);
  emx->size[0] = rows;
  emx->size[1] = cols;
  emx->data = data;
  emx->numDimensions = 2;
  emx->allocatedSize = rows * cols;
  emx->canFreeData = false;
  return emx;
}

emxArray_real_T *emxCreateWrapper_real_T(double *data, int rows, int cols)
{
  emxArray_real_T *emx;
  emxInit_real_T(&emx, 2);
  emx->size[0] = rows;
  emx->size[1] = cols;
  emx->data = data;
  emx->numDimensions = 2;
  emx->allocatedSize = rows * cols;
  emx->canFreeData = false;
  return emx;
}

emxArray_cell_wrap_0 *emxCreate_cell_wrap_0(int rows, int cols)
{
  emxArray_cell_wrap_0 *emx;
  int numEl;
  emxInit_cell_wrap_0(&emx, 2);
  emx->size[0] = rows;
  numEl = rows * cols;
  emx->size[1] = cols;
  emx->data = (cell_wrap_0 *)calloc((unsigned int)numEl, sizeof(cell_wrap_0));
  emx->numDimensions = 2;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_cell_wrap_1 *emxCreate_cell_wrap_1(int rows, int cols)
{
  emxArray_cell_wrap_1 *emx;
  int numEl;
  emxInit_cell_wrap_1(&emx, 2);
  emx->size[0] = rows;
  numEl = rows * cols;
  emx->size[1] = cols;
  emx->data = (cell_wrap_1 *)calloc((unsigned int)numEl, sizeof(cell_wrap_1));
  emx->numDimensions = 2;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_cell_wrap_2 *emxCreate_cell_wrap_2(int rows, int cols)
{
  emxArray_cell_wrap_2 *emx;
  int numEl;
  emxInit_cell_wrap_2(&emx, 2);
  emx->size[0] = rows;
  numEl = rows * cols;
  emx->size[1] = cols;
  emx->data = (cell_wrap_2 *)calloc((unsigned int)numEl, sizeof(cell_wrap_2));
  emx->numDimensions = 2;
  emx->allocatedSize = numEl;
  return emx;
}

emxArray_real_T *emxCreate_real_T(int rows, int cols)
{
  emxArray_real_T *emx;
  int numEl;
  emxInit_real_T(&emx, 2);
  emx->size[0] = rows;
  numEl = rows * cols;
  emx->size[1] = cols;
  emx->data = (double *)calloc((unsigned int)numEl, sizeof(double));
  emx->numDimensions = 2;
  emx->allocatedSize = numEl;
  return emx;
}

void emxDestroyArray_cell_wrap_0(emxArray_cell_wrap_0 *emxArray)
{
  emxFree_cell_wrap_0(&emxArray);
}

void emxDestroyArray_cell_wrap_1(emxArray_cell_wrap_1 *emxArray)
{
  emxFree_cell_wrap_1(&emxArray);
}

void emxDestroyArray_cell_wrap_2(emxArray_cell_wrap_2 *emxArray)
{
  emxFree_cell_wrap_2(&emxArray);
}

void emxDestroyArray_real_T(emxArray_real_T *emxArray)
{
  emxFree_real_T(&emxArray);
}

void emxInitArray_cell_wrap_0(emxArray_cell_wrap_0 **pEmxArray, int
  numDimensions)
{
  emxInit_cell_wrap_0(pEmxArray, numDimensions);
}

void emxInitArray_cell_wrap_1(emxArray_cell_wrap_1 **pEmxArray, int
  numDimensions)
{
  emxInit_cell_wrap_1(pEmxArray, numDimensions);
}

void emxInitArray_cell_wrap_2(emxArray_cell_wrap_2 **pEmxArray, int
  numDimensions)
{
  emxInit_cell_wrap_2(pEmxArray, numDimensions);
}

void emxInitArray_real_T(emxArray_real_T **pEmxArray, int numDimensions)
{
  emxInit_real_T(pEmxArray, numDimensions);
}

/* End of code generation (callParatt_emxAPI.c) */
