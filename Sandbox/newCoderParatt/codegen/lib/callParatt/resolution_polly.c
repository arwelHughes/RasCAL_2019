/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * resolution_polly.c
 *
 * Code generation for function 'resolution_polly'
 *
 */

/* Include files */
#include <math.h>
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "resolution_polly.h"
#include "callParatt_emxutil.h"

/* Function Definitions */
void resolution_polly(const emxArray_real_T *xdata, const emxArray_real_T *ydata,
                      double res, double points, emxArray_real_T *out)
{
  int i5;
  int loop_ub;
  int j;
  double sumg;
  int ilow;
  double d0;
  int i;
  int a_tmp;
  double g;
  res += 0.0001;
  i5 = out->size[0];
  loop_ub = (int)points;
  out->size[0] = loop_ub;
  emxEnsureCapacity_real_T(out, i5);
  for (i5 = 0; i5 < loop_ub; i5++) {
    out->data[i5] = 0.0;
  }

  for (j = 0; j < loop_ub; j++) {
    sumg = 0.0;
    out->data[j] = 0.0;
    if (1U + j > 10U) {
      ilow = -10;
    } else {
      ilow = -j;
    }

    /*     try */
    if (1.0 + (double)j < points - 10.0) {
      d0 = 10.0;
    } else {
      d0 = points - (1.0 + (double)j);
    }

    i5 = (int)(d0 + (1.0 - (double)ilow));
    for (i = 0; i < i5; i++) {
      a_tmp = (j + ilow) + i;
      g = (xdata->data[a_tmp] - xdata->data[j]) / (res * xdata->data[j]);
      g = exp(-(g * g));
      sumg += g;
      out->data[j] += ydata->data[a_tmp] * g;
    }

    if (sumg != 0.0) {
      out->data[j] /= sumg;
    }

    /*      catch */
    /*          disp('debug!'); */
    /*      end */
  }
}

/* End of code generation (resolution_polly.c) */
