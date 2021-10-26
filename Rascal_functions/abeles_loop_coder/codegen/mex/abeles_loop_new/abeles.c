/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * abeles.c
 *
 * Code generation for function 'abeles'
 *
 */

/* Include files */
#include "abeles.h"
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "abeles_loop_new_emxutil.h"
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo e_emlrtRSI = { 20,  /* lineNo */
  "abeles",                            /* fcnName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m"/* pathName */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  11,                                  /* lineNo */
  11,                                  /* colNo */
  "x",                                 /* aName */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo b_emlrtRTEI = { 26,/* lineNo */
  19,                                  /* colNo */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m"/* pName */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  25,                                  /* colNo */
  "sld",                               /* aName */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  29,                                  /* lineNo */
  23,                                  /* colNo */
  "sld",                               /* aName */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo c_emlrtRTEI = { 14,/* lineNo */
  9,                                   /* colNo */
  "asin",                              /* fName */
  "/usr/local/MATLAB/R2020a/toolbox/eml/lib/matlab/elfun/asin.m"/* pName */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  30,                                  /* lineNo */
  21,                                  /* colNo */
  "sld",                               /* aName */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  58,                                  /* lineNo */
  5,                                   /* colNo */
  "out",                               /* aName */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo h_emlrtRTEI = { 3, /* lineNo */
  7,                                   /* colNo */
  "abeles",                            /* fName */
  "/home/arwel/Desktop/Rascal2019/Sandbox/abeles_loop_coder/abeles.m"/* pName */
};

/* Function Definitions */
void abeles(const emlrtStack *sp, const emxArray_real_T *x, const
            emxArray_real_T *sld, real_T nbair, real_T nbsub, real_T nrepeats,
            real_T ssub, real_T layers, real_T points, emxArray_real_T *out)
{
  int32_T i;
  int32_T i1;
  real_T snair;
  real_T snsub;
  int32_T i2;
  int32_T loop;
  int32_T i3;
  real_T ar_tmp;
  creal_T MI[4];
  real_T im;
  real_T theta;
  real_T psub_tmp_tmp;
  creal_T psub;
  real_T pair_re;
  real_T pair_im;
  real_T blast_re;
  real_T blast_im;
  int32_T reploop;
  int32_T nl;
  real_T re;
  real_T ar;
  real_T rij_re;
  real_T rij_im;
  real_T brm;
  real_T bim;
  real_T x_re;
  real_T x_im;
  creal_T pimag;
  creal_T b_MI[4];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  i = (int32_T)points;
  i1 = out->size[0];
  out->size[0] = i;
  emxEnsureCapacity_real_T(sp, out, i1, &h_emlrtRTEI);
  snair = 1.0 - nbair * 0.377451863036739;
  snsub = 1.0 - nbsub * 0.377451863036739;
  if (0 <= i - 1) {
    i2 = (int32_T)nrepeats;
    if (0 <= i2 - 1) {
      i3 = (int32_T)layers;
    }

    ar_tmp = ssub * ssub;
  }

  for (loop = 0; loop < i; loop++) {
    i1 = loop + 1;
    if ((i1 < 1) || (i1 > x->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, x->size[0], &r_emlrtBCI, sp);
    }

    MI[0].re = 1.0;
    MI[0].im = 0.0;
    MI[1].re = 0.0;
    MI[1].im = 0.0;
    MI[2].re = 0.0;
    MI[2].im = 0.0;
    MI[3].re = 1.0;
    MI[3].im = 0.0;
    st.site = &e_emlrtRSI;
    im = x->data[loop] * 1.54 / 12.566370614359172;
    if ((im < -1.0) || (im > 1.0)) {
      emlrtErrorWithMessageIdR2018a(&st, &c_emlrtRTEI,
        "Coder:toolbox:ElFunDomainError", "Coder:toolbox:ElFunDomainError", 3, 4,
        4, "asin");
    }

    theta = muDoubleScalarAsin(im);
    im = muDoubleScalarCos(theta);
    psub_tmp_tmp = snair * snair * (im * im);
    im = snsub * snsub - psub_tmp_tmp;
    psub.re = im;
    psub.im = im * 0.0;
    b_sqrt(&psub);
    pair_re = snair * muDoubleScalarSin(theta);
    pair_im = pair_re * 0.0;
    blast_re = 0.0;
    blast_im = 0.0;
    emlrtForLoopVectorCheckR2012b(1.0, 1.0, nrepeats, mxDOUBLE_CLASS, (int32_T)
      nrepeats, &b_emlrtRTEI, sp);
    for (reploop = 0; reploop < i2; reploop++) {
      for (nl = 0; nl < i3; nl++) {
        i1 = nl + 1;
        if ((i1 < 1) || (i1 > sld->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, sld->size[0], &s_emlrtBCI, sp);
        }

        i1 = nl + 1;
        if ((i1 < 1) || (i1 > sld->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, sld->size[0], &t_emlrtBCI, sp);
        }

        i1 = (int32_T)(nl + 1U);
        if ((i1 < 1) || (i1 > sld->size[0])) {
          emlrtDynamicBoundsCheckR2012b(i1, 1, sld->size[0], &u_emlrtBCI, sp);
        }

        theta = sld->data[(i1 + sld->size[0] * 2) - 1];
        im = 1.0 - sld->data[nl + sld->size[0]] * 0.377451863036739;
        im = im * im - psub_tmp_tmp;
        pimag.re = im;
        pimag.im = im * 0.0;
        b_sqrt(&pimag);
        re = -78.956835208714864 * pair_re;
        im = -78.956835208714864 * pair_im;
        theta *= theta;
        ar = (re * pimag.re - im * pimag.im) * theta;
        re = (re * pimag.im + im * pimag.re) * theta;
        if (re == 0.0) {
          rij_re = ar / 2.3716;
          rij_im = 0.0;
        } else if (ar == 0.0) {
          rij_re = 0.0;
          rij_im = re / 2.3716;
        } else {
          rij_re = ar / 2.3716;
          rij_im = re / 2.3716;
        }

        if (rij_im == 0.0) {
          rij_re = muDoubleScalarExp(rij_re);
          rij_im = 0.0;
        } else if (muDoubleScalarIsInf(rij_im) && muDoubleScalarIsInf(rij_re) &&
                   (rij_re < 0.0)) {
          rij_re = 0.0;
          rij_im = 0.0;
        } else {
          theta = muDoubleScalarExp(rij_re / 2.0);
          rij_re = theta * (theta * muDoubleScalarCos(rij_im));
          rij_im = theta * (theta * muDoubleScalarSin(rij_im));
        }

        ar = pair_re - pimag.re;
        re = pair_im - pimag.im;
        theta = pair_re + pimag.re;
        im = pair_im + pimag.im;
        if (im == 0.0) {
          if (re == 0.0) {
            pair_re = ar / theta;
            pair_im = 0.0;
          } else if (ar == 0.0) {
            pair_re = 0.0;
            pair_im = re / theta;
          } else {
            pair_re = ar / theta;
            pair_im = re / theta;
          }
        } else if (theta == 0.0) {
          if (ar == 0.0) {
            pair_re = re / im;
            pair_im = 0.0;
          } else if (re == 0.0) {
            pair_re = 0.0;
            pair_im = -(ar / im);
          } else {
            pair_re = re / im;
            pair_im = -(ar / im);
          }
        } else {
          brm = muDoubleScalarAbs(theta);
          bim = muDoubleScalarAbs(im);
          if (brm > bim) {
            bim = im / theta;
            theta += bim * im;
            pair_re = (ar + bim * re) / theta;
            pair_im = (re - bim * ar) / theta;
          } else if (bim == brm) {
            if (theta > 0.0) {
              bim = 0.5;
            } else {
              bim = -0.5;
            }

            if (im > 0.0) {
              theta = 0.5;
            } else {
              theta = -0.5;
            }

            pair_re = (ar * bim + re * theta) / brm;
            pair_im = (re * bim - ar * theta) / brm;
          } else {
            bim = theta / im;
            theta = im + bim * theta;
            pair_re = (bim * ar + re) / theta;
            pair_im = (bim * re - ar) / theta;
          }
        }

        re = pair_re * rij_re - pair_im * rij_im;
        im = pair_re * rij_im + pair_im * rij_re;
        x_re = blast_re * 0.0 - blast_im;
        x_im = blast_re + blast_im * 0.0;
        if (x_im == 0.0) {
          x_re = muDoubleScalarExp(x_re);
          x_im = 0.0;
        } else if (muDoubleScalarIsInf(x_im) && muDoubleScalarIsInf(x_re) &&
                   (x_re < 0.0)) {
          x_re = 0.0;
          x_im = 0.0;
        } else {
          theta = muDoubleScalarExp(x_re / 2.0);
          x_re = theta * (theta * muDoubleScalarCos(x_im));
          x_im = theta * (theta * muDoubleScalarSin(x_im));
        }

        pair_re = -blast_re * 0.0 - (-blast_im);
        pair_im = -blast_re + -blast_im * 0.0;
        if (pair_im == 0.0) {
          pair_re = muDoubleScalarExp(pair_re);
          pair_im = 0.0;
        } else if (muDoubleScalarIsInf(pair_im) && muDoubleScalarIsInf(pair_re) &&
                   (pair_re < 0.0)) {
          pair_re = 0.0;
          pair_im = 0.0;
        } else {
          theta = muDoubleScalarExp(pair_re / 2.0);
          pair_re = theta * (theta * muDoubleScalarCos(pair_im));
          pair_im = theta * (theta * muDoubleScalarSin(pair_im));
        }

        rij_re = re * pair_re - im * pair_im;
        bim = re * pair_im + im * pair_re;
        brm = pair_re;
        rij_im = pair_im;
        ar = re * x_re - im * x_im;
        theta = re * x_im + im * x_re;
        pair_re = pimag.re;
        pair_im = pimag.im;
        blast_re = 4.0799904592075231 * sld->data[nl] * pimag.re;
        blast_im = 4.0799904592075231 * sld->data[nl] * pimag.im;
        for (i1 = 0; i1 < 2; i1++) {
          im = MI[i1 + 2].re;
          re = MI[i1 + 2].im;
          b_MI[i1].re = (MI[i1].re * x_re - MI[i1].im * x_im) + (im * rij_re -
            re * bim);
          b_MI[i1].im = (MI[i1].re * x_im + MI[i1].im * x_re) + (im * bim + re *
            rij_re);
          b_MI[i1 + 2].re = (MI[i1].re * ar - MI[i1].im * theta) + (im * brm -
            re * rij_im);
          b_MI[i1 + 2].im = (MI[i1].re * theta + MI[i1].im * ar) + (im * rij_im
            + re * brm);
        }

        memcpy(&MI[0], &b_MI[0], 4U * sizeof(creal_T));
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(sp);
        }
      }

      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(sp);
      }
    }

    re = -78.956835208714864 * pair_re;
    im = -78.956835208714864 * pair_im;
    ar = (re * psub.re - im * psub.im) * ar_tmp;
    re = (re * psub.im + im * psub.re) * ar_tmp;
    if (re == 0.0) {
      rij_re = ar / 2.3716;
      rij_im = 0.0;
    } else if (ar == 0.0) {
      rij_re = 0.0;
      rij_im = re / 2.3716;
    } else {
      rij_re = ar / 2.3716;
      rij_im = re / 2.3716;
    }

    if (rij_im == 0.0) {
      rij_re = muDoubleScalarExp(rij_re);
      rij_im = 0.0;
    } else if (muDoubleScalarIsInf(rij_im) && muDoubleScalarIsInf(rij_re) &&
               (rij_re < 0.0)) {
      rij_re = 0.0;
      rij_im = 0.0;
    } else {
      theta = muDoubleScalarExp(rij_re / 2.0);
      rij_re = theta * (theta * muDoubleScalarCos(rij_im));
      rij_im = theta * (theta * muDoubleScalarSin(rij_im));
    }

    ar = pair_re - psub.re;
    re = pair_im - psub.im;
    theta = pair_re + psub.re;
    im = pair_im + psub.im;
    if (im == 0.0) {
      if (re == 0.0) {
        pair_re = ar / theta;
        pair_im = 0.0;
      } else if (ar == 0.0) {
        pair_re = 0.0;
        pair_im = re / theta;
      } else {
        pair_re = ar / theta;
        pair_im = re / theta;
      }
    } else if (theta == 0.0) {
      if (ar == 0.0) {
        pair_re = re / im;
        pair_im = 0.0;
      } else if (re == 0.0) {
        pair_re = 0.0;
        pair_im = -(ar / im);
      } else {
        pair_re = re / im;
        pair_im = -(ar / im);
      }
    } else {
      brm = muDoubleScalarAbs(theta);
      bim = muDoubleScalarAbs(im);
      if (brm > bim) {
        bim = im / theta;
        theta += bim * im;
        pair_re = (ar + bim * re) / theta;
        pair_im = (re - bim * ar) / theta;
      } else if (bim == brm) {
        if (theta > 0.0) {
          bim = 0.5;
        } else {
          bim = -0.5;
        }

        if (im > 0.0) {
          theta = 0.5;
        } else {
          theta = -0.5;
        }

        pair_re = (ar * bim + re * theta) / brm;
        pair_im = (re * bim - ar * theta) / brm;
      } else {
        bim = theta / im;
        theta = im + bim * theta;
        pair_re = (bim * ar + re) / theta;
        pair_im = (bim * re - ar) / theta;
      }
    }

    re = pair_re * rij_re - pair_im * rij_im;
    im = pair_re * rij_im + pair_im * rij_re;
    x_re = blast_re * 0.0 - blast_im;
    x_im = blast_re + blast_im * 0.0;
    if (x_im == 0.0) {
      x_re = muDoubleScalarExp(x_re);
      x_im = 0.0;
    } else if (muDoubleScalarIsInf(x_im) && muDoubleScalarIsInf(x_re) && (x_re <
                0.0)) {
      x_re = 0.0;
      x_im = 0.0;
    } else {
      theta = muDoubleScalarExp(x_re / 2.0);
      x_re = theta * (theta * muDoubleScalarCos(x_im));
      x_im = theta * (theta * muDoubleScalarSin(x_im));
    }

    pair_re = -blast_re * 0.0 - (-blast_im);
    pair_im = -blast_re + -blast_im * 0.0;
    if (pair_im == 0.0) {
      pair_re = muDoubleScalarExp(pair_re);
      pair_im = 0.0;
    } else if (muDoubleScalarIsInf(pair_im) && muDoubleScalarIsInf(pair_re) &&
               (pair_re < 0.0)) {
      pair_re = 0.0;
      pair_im = 0.0;
    } else {
      theta = muDoubleScalarExp(pair_re / 2.0);
      pair_re = theta * (theta * muDoubleScalarCos(pair_im));
      pair_im = theta * (theta * muDoubleScalarSin(pair_im));
    }

    rij_re = re * pair_re - im * pair_im;
    bim = re * pair_im + im * pair_re;
    brm = re * x_re - im * x_im;
    rij_im = re * x_im + im * x_re;
    for (i1 = 0; i1 < 2; i1++) {
      ar = MI[i1 + 2].re;
      theta = MI[i1 + 2].im;
      b_MI[i1].re = (MI[i1].re * x_re - MI[i1].im * x_im) + (ar * rij_re - theta
        * bim);
      b_MI[i1].im = (MI[i1].re * x_im + MI[i1].im * x_re) + (ar * bim + theta *
        rij_re);
      b_MI[i1 + 2].re = (MI[i1].re * brm - MI[i1].im * rij_im) + (ar * pair_re -
        theta * pair_im);
      b_MI[i1 + 2].im = (MI[i1].re * rij_im + MI[i1].im * brm) + (ar * pair_im +
        theta * pair_re);
    }

    re = b_MI[1].re * b_MI[1].re - b_MI[1].im * -b_MI[1].im;
    rij_re = b_MI[1].re * -b_MI[1].im + b_MI[1].im * b_MI[1].re;
    im = b_MI[0].re * b_MI[0].re - b_MI[0].im * -b_MI[0].im;
    theta = b_MI[0].re * -b_MI[0].im + b_MI[0].im * b_MI[0].re;
    if (theta == 0.0) {
      if (rij_re == 0.0) {
        pair_re = re / im;
        pair_im = 0.0;
      } else if (re == 0.0) {
        pair_re = 0.0;
        pair_im = rij_re / im;
      } else {
        pair_re = re / im;
        pair_im = rij_re / im;
      }
    } else if (im == 0.0) {
      if (re == 0.0) {
        pair_re = rij_re / theta;
        pair_im = 0.0;
      } else if (rij_re == 0.0) {
        pair_re = 0.0;
        pair_im = -(re / theta);
      } else {
        pair_re = rij_re / theta;
        pair_im = -(re / theta);
      }
    } else {
      brm = muDoubleScalarAbs(im);
      bim = muDoubleScalarAbs(theta);
      if (brm > bim) {
        bim = theta / im;
        theta = im + bim * theta;
        pair_re = (re + bim * rij_re) / theta;
        pair_im = (rij_re - bim * re) / theta;
      } else if (bim == brm) {
        if (im > 0.0) {
          bim = 0.5;
        } else {
          bim = -0.5;
        }

        if (theta > 0.0) {
          theta = 0.5;
        } else {
          theta = -0.5;
        }

        pair_re = (re * bim + rij_re * theta) / brm;
        pair_im = (rij_re * bim - re * theta) / brm;
      } else {
        bim = im / theta;
        theta += bim * im;
        pair_re = (bim * re + rij_re) / theta;
        pair_im = (bim * rij_re - re) / theta;
      }
    }

    i1 = (int32_T)(loop + 1U);
    if ((i1 < 1) || (i1 > out->size[0])) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, out->size[0], &v_emlrtBCI, sp);
    }

    out->data[i1 - 1] = pair_re * pair_re - pair_im * pair_im;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }
}

/* End of code generation (abeles.c) */
