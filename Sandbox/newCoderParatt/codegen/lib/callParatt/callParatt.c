/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * callParatt.c
 *
 * Code generation for function 'callParatt'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "callParatt.h"
#include "callParatt_emxutil.h"
#include "resolution_polly.h"
#include "paratt.h"

/* Function Definitions */
void callParatt(const emxArray_cell_wrap_0 *simXdata, const emxArray_cell_wrap_1
                *slds, const emxArray_real_T *nbairs, const emxArray_real_T
                *nbsubs, const emxArray_real_T *repeats, const emxArray_real_T
                *resolutions, const emxArray_real_T *ssubs, emxArray_cell_wrap_2
                *simRef)
{
  int ub_loop;
  int i0;
  int i;
  emxArray_real_T *thisRef;
  ub_loop = simXdata->size[0];
  i0 = simRef->size[0];
  simRef->size[0] = simXdata->size[0];
  emxEnsureCapacity_cell_wrap_2(simRef, i0);
  ub_loop--;

#pragma omp parallel \
 num_threads(omp_get_max_threads()) \
 private(thisRef)

  {
    emxInit_real_T(&thisRef, 1);

#pragma omp for nowait

    for (i = 0; i <= ub_loop; i++) {
      paratt(simXdata->data[i].f1, slds->data[i].f1, nbairs->data[i],
             nbsubs->data[i], repeats->data[i], ssubs->data[i], slds->data[i].
             f1->size[0], simXdata->data[i].f1->size[1], thisRef);
      resolution_polly(simXdata->data[i].f1, thisRef, resolutions->data[i],
                       simXdata->data[i].f1->size[1], simRef->data[i].f1);
    }

    emxFree_real_T(&thisRef);
  }
}

/* End of code generation (callParatt.c) */
