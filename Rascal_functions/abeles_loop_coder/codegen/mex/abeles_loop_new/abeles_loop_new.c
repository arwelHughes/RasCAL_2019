/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles_loop_new.c
 *
 * Code generation for function 'abeles_loop_new'
 *
 */

/* Include files */
#include "abeles_loop_new.h"
#include "abeles.h"
#include "abeles_loop_new_data.h"
#include "abeles_loop_new_emxutil.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 18,    /* lineNo */
  "abeles_loop_new",                   /* fcnName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 19,  /* lineNo */
  "abeles_loop_new",                   /* fcnName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 29,  /* lineNo */
  "resolution_polly",                  /* fcnName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m"/* pathName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  9,                                   /* lineNo */
  24,                                  /* colNo */
  "nbairs",                            /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  10,                                  /* lineNo */
  24,                                  /* colNo */
  "nbsubs",                            /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  11,                                  /* lineNo */
  27,                                  /* colNo */
  "repeats",                           /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  12,                                  /* lineNo */
  34,                                  /* colNo */
  "resolutions",                       /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  23,                                  /* colNo */
  "ssubs",                             /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  7,                                   /* lineNo */
  22,                                  /* colNo */
  "simXdata",                          /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  8,                                   /* lineNo */
  20,                                  /* colNo */
  "slds",                              /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo emlrtRTEI = { 28,  /* lineNo */
  13,                                  /* colNo */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m"/* pName */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  21,                                  /* lineNo */
  5,                                   /* colNo */
  "simRef",                            /* aName */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  13,                                  /* lineNo */
  5,                                   /* colNo */
  "dummydata",                         /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  34,                                  /* lineNo */
  24,                                  /* colNo */
  "dummydata",                         /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  34,                                  /* lineNo */
  9,                                   /* colNo */
  "dummydata",                         /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  22,                                  /* colNo */
  "xdata",                             /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  33,                                  /* colNo */
  "xdata",                             /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  48,                                  /* colNo */
  "xdata",                             /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  31,                                  /* lineNo */
  24,                                  /* colNo */
  "dummydata",                         /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  31,                                  /* lineNo */
  39,                                  /* colNo */
  "dummyref",                          /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  31,                                  /* lineNo */
  9,                                   /* colNo */
  "dummydata",                         /* aName */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo d_emlrtRTEI = { 1, /* lineNo */
  19,                                  /* colNo */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 7, /* lineNo */
  1,                                   /* colNo */
  "resolution_polly",                  /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/resolution_polly.m"/* pName */
};

static emlrtRTEInfo f_emlrtRTEI = { 21,/* lineNo */
  5,                                   /* colNo */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 18,/* lineNo */
  5,                                   /* colNo */
  "abeles_loop_new",                   /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles_loop_new.m"/* pName */
};

/* Function Definitions */
void abeles_loop_new(const emlrtStack *sp, const emxArray_cell_wrap_0 *simXdata,
                     const emxArray_cell_wrap_1 *slds, const emxArray_real_T
                     *nbairs, const emxArray_real_T *nbsubs, const
                     emxArray_real_T *repeats, const emxArray_real_T
                     *resolutions, const emxArray_real_T *ssubs,
                     emxArray_cell_wrap_0 *simRef)
{
  int32_T i;
  int32_T i1;
  emxArray_real_T *ref;
  emxArray_real_T *dummydata;
  int32_T b_i;
  int32_T varargin_2;
  int32_T ihi;
  int32_T j;
  real_T sumg;
  int32_T i2;
  int32_T ilow;
  int32_T c_i;
  int32_T i3;
  int32_T i4;
  real_T g;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  i = simXdata->size[1];
  i1 = simRef->size[0];
  simRef->size[0] = simXdata->size[1];
  emxEnsureCapacity_cell_wrap_0(sp, simRef, i1, &d_emlrtRTEI);
  emxInit_real_T(sp, &ref, 1, &g_emlrtRTEI, true);
  emxInit_real_T(sp, &dummydata, 1, &e_emlrtRTEI, true);
  for (b_i = 0; b_i < i; b_i++) {
    i1 = simXdata->size[1] - 1;
    if (b_i > i1) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, i1, &f_emlrtBCI, sp);
    }

    i1 = slds->size[1] - 1;
    if (b_i > i1) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, i1, &g_emlrtBCI, sp);
    }

    i1 = b_i + 1;
    if ((i1 < 1) || (i1 > nbairs->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, nbairs->size[1], &emlrtBCI, sp);
    }

    i1 = b_i + 1;
    if ((i1 < 1) || (i1 > nbsubs->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, nbsubs->size[1], &b_emlrtBCI, sp);
    }

    i1 = b_i + 1;
    if ((i1 < 1) || (i1 > repeats->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, repeats->size[1], &c_emlrtBCI, sp);
    }

    i1 = b_i + 1;
    if ((i1 < 1) || (i1 > resolutions->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, resolutions->size[1], &d_emlrtBCI, sp);
    }

    i1 = b_i + 1;
    if ((i1 < 1) || (i1 > ssubs->size[1])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, ssubs->size[1], &e_emlrtBCI, sp);
    }

    varargin_2 = simXdata->data[b_i].f1->size[0] - 10;
    st.site = &emlrtRSI;
    abeles(&st, simXdata->data[b_i].f1, slds->data[b_i].f1, nbairs->data[b_i],
           nbsubs->data[b_i], repeats->data[b_i], ssubs->data[b_i], slds->
           data[b_i].f1->size[0], simXdata->data[b_i].f1->size[0], ref);
    st.site = &b_emlrtRSI;

    /*  Apply resolution correction */
    i1 = dummydata->size[0];
    dummydata->size[0] = simXdata->data[b_i].f1->size[0];
    emxEnsureCapacity_real_T(&st, dummydata, i1, &e_emlrtRTEI);
    ihi = simXdata->data[b_i].f1->size[0];
    for (i1 = 0; i1 < ihi; i1++) {
      dummydata->data[i1] = 0.0;
    }

    i1 = simXdata->data[b_i].f1->size[0];
    for (j = 0; j < i1; j++) {
      sumg = 0.0;
      i2 = j + 1;
      if ((i2 < 1) || (i2 > dummydata->size[0])) {
        emlrtDynamicBoundsCheckR2012b(i2, 1, dummydata->size[0], &i_emlrtBCI,
          &st);
      }

      dummydata->data[i2 - 1] = 0.0;
      if (j + 1 > 10) {
        ilow = -10;
      } else {
        ilow = -j;
      }

      if (j + 1 < varargin_2) {
        ihi = 1;
      } else {
        ihi = varargin_2 - j;
      }

      /*     try */
      i2 = (ihi - ilow) + 9;
      emlrtForLoopVectorCheckR2012b(ilow, 1.0, ihi + 9, mxDOUBLE_CLASS, i2 + 1,
        &emlrtRTEI, &st);
      for (c_i = 0; c_i <= i2; c_i++) {
        b_st.site = &l_emlrtRSI;
        ihi = (int32_T)(((real_T)j + 1.0) + (real_T)(ilow + c_i));
        if ((ihi < 1) || (ihi > simXdata->data[b_i].f1->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ihi, 1, simXdata->data[b_i].f1->size[0],
            &l_emlrtBCI, &b_st);
        }

        i3 = j + 1;
        if ((i3 < 1) || (i3 > simXdata->data[b_i].f1->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, simXdata->data[b_i].f1->size[0],
            &m_emlrtBCI, &b_st);
        }

        i4 = j + 1;
        if ((i4 < 1) || (i4 > simXdata->data[b_i].f1->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, simXdata->data[b_i].f1->size[0],
            &n_emlrtBCI, &b_st);
        }

        g = (simXdata->data[b_i].f1->data[ihi - 1] - simXdata->data[b_i]
             .f1->data[i3 - 1]) / ((resolutions->data[b_i] + 0.0001) *
          simXdata->data[b_i].f1->data[i4 - 1]);
        g = muDoubleScalarExp(-(g * g));
        sumg += g;
        i3 = j + 1;
        if ((i3 < 1) || (i3 > dummydata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i3, 1, dummydata->size[0], &o_emlrtBCI,
            &st);
        }

        if (ihi > ref->size[0]) {
          emlrtDynamicBoundsCheckR2012b(ihi, 1, ref->size[0], &p_emlrtBCI, &st);
        }

        i4 = j + 1;
        if ((i4 < 1) || (i4 > dummydata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i4, 1, dummydata->size[0], &q_emlrtBCI,
            &st);
        }

        dummydata->data[i4 - 1] = dummydata->data[i3 - 1] + ref->data[ihi - 1] *
          g;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }

      if (sumg != 0.0) {
        i2 = j + 1;
        if ((i2 < 1) || (i2 > dummydata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i2, 1, dummydata->size[0], &j_emlrtBCI,
            &st);
        }

        ihi = j + 1;
        if ((ihi < 1) || (ihi > dummydata->size[0])) {
          emlrtDynamicBoundsCheckR2012b(ihi, 1, dummydata->size[0], &k_emlrtBCI,
            &st);
        }

        dummydata->data[ihi - 1] = dummydata->data[i2 - 1] / sumg;
      }

      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    i1 = simRef->size[0] - 1;
    i2 = simRef->size[0] - 1;
    if (b_i > i2) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, i2, &h_emlrtBCI, &st);
    }

    i2 = simRef->data[b_i].f1->size[0];
    simRef->data[b_i].f1->size[0] = dummydata->size[0];
    emxEnsureCapacity_real_T(&st, simRef->data[b_i].f1, i2, &f_emlrtRTEI);
    ihi = dummydata->size[0];
    for (i2 = 0; i2 < ihi; i2++) {
      if (b_i > i1) {
        emlrtDynamicBoundsCheckR2012b(b_i, 0, i1, &h_emlrtBCI, &st);
      }

      simRef->data[b_i].f1->data[i2] = dummydata->data[i2];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&dummydata);
  emxFree_real_T(&ref);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (abeles_loop_new.c) */
