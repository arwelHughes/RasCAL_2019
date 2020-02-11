/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include files */
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "main.h"
#include "callParatt_terminate.h"
#include "callParatt_emxAPI.h"
#include "callParatt_initialize.h"

/* Function Declarations */
static emxArray_real_T *argInit_1xUnbounded_real_T(void);
static emxArray_cell_wrap_0 *argInit_Unboundedx1_cell_wrap_0(void);
static emxArray_cell_wrap_1 *argInit_Unboundedx1_cell_wrap_1(void);
static emxArray_real_T *argInit_Unboundedx1_real_T(void);
static emxArray_real_T *argInit_Unboundedx3_real_T(void);
static cell_wrap_0 argInit_cell_wrap_0(void);
static cell_wrap_1 argInit_cell_wrap_1(void);
static double argInit_real_T(void);
static void main_callParatt(void);

/* Function Definitions */
static emxArray_real_T *argInit_1xUnbounded_real_T(void)
{
  emxArray_real_T *result;
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreate_real_T(1, 2);

  /* Loop over the array to initialize each element. */
  for (idx1 = 0; idx1 < result->size[1U]; idx1++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx1] = argInit_real_T();
  }

  return result;
}

static emxArray_cell_wrap_0 *argInit_Unboundedx1_cell_wrap_0(void)
{
  emxArray_cell_wrap_0 *result;
  static int iv0[1] = { 2 };

  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_cell_wrap_0(1, iv0);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0] = argInit_cell_wrap_0();
  }

  return result;
}

static emxArray_cell_wrap_1 *argInit_Unboundedx1_cell_wrap_1(void)
{
  emxArray_cell_wrap_1 *result;
  static int iv1[1] = { 2 };

  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_cell_wrap_1(1, iv1);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0] = argInit_cell_wrap_1();
  }

  return result;
}

static emxArray_real_T *argInit_Unboundedx1_real_T(void)
{
  emxArray_real_T *result;
  static int iv2[1] = { 2 };

  int idx0;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreateND_real_T(1, iv2);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0] = argInit_real_T();
  }

  return result;
}

static emxArray_real_T *argInit_Unboundedx3_real_T(void)
{
  emxArray_real_T *result;
  int idx0;
  double d1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result = emxCreate_real_T(2, 3);

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < result->size[0U]; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    d1 = argInit_real_T();
    result->data[idx0] = d1;

    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0 + result->size[0]] = d1;

    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result->data[idx0 + (result->size[0] << 1)] = argInit_real_T();
  }

  return result;
}

static cell_wrap_0 argInit_cell_wrap_0(void)
{
  cell_wrap_0 result;

  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  result.f1 = argInit_1xUnbounded_real_T();
  return result;
}

static cell_wrap_1 argInit_cell_wrap_1(void)
{
  cell_wrap_1 result;

  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  result.f1 = argInit_Unboundedx3_real_T();
  return result;
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void main_callParatt(void)
{
  emxArray_cell_wrap_2 *simRef;
  emxArray_cell_wrap_0 *simXdata;
  emxArray_cell_wrap_1 *slds;
  emxArray_real_T *nbairs;
  emxArray_real_T *nbsubs;
  emxArray_real_T *repeats;
  emxArray_real_T *resolutions;
  emxArray_real_T *ssubs;
  emxInitArray_cell_wrap_2(&simRef, 1);

  /* Initialize function 'callParatt' input arguments. */
  /* Initialize function input argument 'simXdata'. */
  simXdata = argInit_Unboundedx1_cell_wrap_0();

  /* Initialize function input argument 'slds'. */
  slds = argInit_Unboundedx1_cell_wrap_1();

  /* Initialize function input argument 'nbairs'. */
  nbairs = argInit_Unboundedx1_real_T();

  /* Initialize function input argument 'nbsubs'. */
  nbsubs = argInit_Unboundedx1_real_T();

  /* Initialize function input argument 'repeats'. */
  repeats = argInit_Unboundedx1_real_T();

  /* Initialize function input argument 'resolutions'. */
  resolutions = argInit_Unboundedx1_real_T();

  /* Initialize function input argument 'ssubs'. */
  ssubs = argInit_Unboundedx1_real_T();

  /* Call the entry-point 'callParatt'. */
  callParatt(simXdata, slds, nbairs, nbsubs, repeats, resolutions, ssubs, simRef);
  emxDestroyArray_cell_wrap_2(simRef);
  emxDestroyArray_real_T(ssubs);
  emxDestroyArray_real_T(resolutions);
  emxDestroyArray_real_T(repeats);
  emxDestroyArray_real_T(nbsubs);
  emxDestroyArray_real_T(nbairs);
  emxDestroyArray_cell_wrap_1(slds);
  emxDestroyArray_cell_wrap_0(simXdata);
}

int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  callParatt_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_callParatt();

  /* Terminate the application.
     You do not need to do this more than one time. */
  callParatt_terminate();
  return 0;
}

/* End of code generation (main.c) */
