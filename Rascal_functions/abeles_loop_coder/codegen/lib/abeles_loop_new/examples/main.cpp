//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// main.cpp
//
// Code generation for function 'main'
//

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
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

// Include files
#include "main.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_terminate.h"
#include "abeles_loop_new_types.h"
#include "coder_array.h"

// Function Declarations
static coder::array<cell_wrap_0, 1U> argInit_Unboundedx1_cell_wrap_0();

static coder::array<cell_wrap_1, 1U> argInit_Unboundedx1_cell_wrap_1();

static coder::array<double, 1U> argInit_Unboundedx1_real_T();

static coder::array<double, 2U> argInit_Unboundedx3_real_T();

static cell_wrap_0 argInit_cell_wrap_0();

static cell_wrap_1 argInit_cell_wrap_1();

static double argInit_real_T();

static void main_abeles_loop_new();

// Function Definitions
static coder::array<cell_wrap_0, 1U> argInit_Unboundedx1_cell_wrap_0()
{
  coder::array<cell_wrap_0, 1U> result;
  // Set the size of the array.
  // Change this size to the value that the application requires.
  result.set_size(2);
  // Loop over the array to initialize each element.
  for (int idx0{0}; idx0 < result.size(0); idx0++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result[idx0] = argInit_cell_wrap_0();
  }
  return result;
}

static coder::array<cell_wrap_1, 1U> argInit_Unboundedx1_cell_wrap_1()
{
  coder::array<cell_wrap_1, 1U> result;
  // Set the size of the array.
  // Change this size to the value that the application requires.
  result.set_size(2);
  // Loop over the array to initialize each element.
  for (int idx0{0}; idx0 < result.size(0); idx0++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result[idx0] = argInit_cell_wrap_1();
  }
  return result;
}

static coder::array<double, 1U> argInit_Unboundedx1_real_T()
{
  coder::array<double, 1U> result;
  // Set the size of the array.
  // Change this size to the value that the application requires.
  result.set_size(2);
  // Loop over the array to initialize each element.
  for (int idx0{0}; idx0 < result.size(0); idx0++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result[idx0] = argInit_real_T();
  }
  return result;
}

static coder::array<double, 2U> argInit_Unboundedx3_real_T()
{
  coder::array<double, 2U> result;
  // Set the size of the array.
  // Change this size to the value that the application requires.
  result.set_size(2, 3);
  // Loop over the array to initialize each element.
  for (int idx0{0}; idx0 < result.size(0); idx0++) {
    for (int idx1{0}; idx1 < 3; idx1++) {
      // Set the value of the array element.
      // Change this value to the value that the application requires.
      result[idx0 + result.size(0) * idx1] = argInit_real_T();
    }
  }
  return result;
}

static cell_wrap_0 argInit_cell_wrap_0()
{
  cell_wrap_0 result;
  // Set the value of each structure field.
  // Change this value to the value that the application requires.
  result.f1 = argInit_Unboundedx1_real_T();
  return result;
}

static cell_wrap_1 argInit_cell_wrap_1()
{
  cell_wrap_1 result;
  // Set the value of each structure field.
  // Change this value to the value that the application requires.
  result.f1 = argInit_Unboundedx3_real_T();
  return result;
}

static double argInit_real_T()
{
  return 0.0;
}

static void main_abeles_loop_new()
{
  coder::array<cell_wrap_0, 1U> simRef;
  coder::array<cell_wrap_0, 1U> simXdata;
  coder::array<cell_wrap_1, 1U> slds;
  coder::array<double, 1U> nbairs_tmp;
  // Initialize function 'abeles_loop_new' input arguments.
  // Initialize function input argument 'simXdata'.
  simXdata = argInit_Unboundedx1_cell_wrap_0();
  // Initialize function input argument 'slds'.
  slds = argInit_Unboundedx1_cell_wrap_1();
  // Initialize function input argument 'nbairs'.
  nbairs_tmp = argInit_Unboundedx1_real_T();
  // Initialize function input argument 'nbsubs'.
  // Initialize function input argument 'repeats'.
  // Initialize function input argument 'resolutions'.
  // Initialize function input argument 'ssubs'.
  // Call the entry-point 'abeles_loop_new'.
  abeles_loop_new(simXdata, slds, nbairs_tmp, nbairs_tmp, nbairs_tmp,
                  nbairs_tmp, nbairs_tmp, simRef);
}

int main(int, char **)
{
  // The initialize function is being called automatically from your entry-point
  // function. So, a call to initialize is not included here. Invoke the
  // entry-point functions.
  // You can call entry-point functions multiple times.
  main_abeles_loop_new();
  // Terminate the application.
  // You do not need to do this more than one time.
  abeles_loop_new_terminate();
  return 0;
}

// End of code generation (main.cpp)
