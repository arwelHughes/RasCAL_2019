/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt_rtwutil.c
 *
 * Code generation for function 'callParatt_rtwutil'
 *
 */

/* Include files */
#include <math.h>
#include "rt_nonfinite.h"
#include "callParatt_rtwutil.h"

/* Function Definitions */
double rt_hypotd_snf(double u0, double u1)
{
  double y;
  double a;
  double b;
  a = fabs(u0);
  b = fabs(u1);
  if (a < b) {
    a /= b;
    y = b * sqrt(a * a + 1.0);
  } else if (a > b) {
    b /= a;
    y = a * sqrt(b * b + 1.0);
  } else if (rtIsNaN(b)) {
    y = b;
  } else {
    y = a * 1.4142135623730951;
  }

  return y;
}

/* End of code generation (callParatt_rtwutil.c) */
