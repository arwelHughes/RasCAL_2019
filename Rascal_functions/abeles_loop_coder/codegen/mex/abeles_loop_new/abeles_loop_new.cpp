//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// abeles_loop_new.cpp
//
// Code generation for function 'abeles_loop_new'
//

// Include files
#include "abeles_loop_new.h"
#include "abeles_loop_new_data.h"
#include "abeles_loop_new_types.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include "coder_array.h"
#include "mwmathutil.h"
#include <algorithm>

// Variable Definitions
static emlrtRSInfo emlrtRSI{
    18,                // lineNo
    "abeles_loop_new", // fcnName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pathName
};

static emlrtRSInfo b_emlrtRSI{
    19,                // lineNo
    "abeles_loop_new", // fcnName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pathName
};

static emlrtRSInfo c_emlrtRSI{
    28,              // lineNo
    "abeles_single", // fcnName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m" // pathName
};

static emlrtRSInfo h_emlrtRSI{
    29,                 // lineNo
    "resolution_polly", // fcnName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m" // pathName
};

static emlrtBCInfo emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    9,                 // lineNo
    24,                // colNo
    "nbairs",          // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo b_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    10,                // lineNo
    24,                // colNo
    "nbsubs",          // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo c_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    12,                // lineNo
    34,                // colNo
    "resolutions",     // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo d_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    7,                 // lineNo
    22,                // colNo
    "simXdata",        // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo e_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    8,                 // lineNo
    20,                // colNo
    "slds",            // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo f_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    27,              // lineNo
    11,              // colNo
    "x",             // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtBCInfo g_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    34,              // lineNo
    17,              // colNo
    "sld",           // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtRTEInfo emlrtRTEI{
    39,              // lineNo
    19,              // colNo
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m" // pName
};

static emlrtBCInfo h_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    41,              // lineNo
    25,              // colNo
    "sld",           // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtBCInfo i_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    42,              // lineNo
    23,              // colNo
    "sld",           // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtRTEInfo b_emlrtRTEI{
    28,                 // lineNo
    13,                 // colNo
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    14,     // lineNo
    9,      // colNo
    "asin", // fName
    "/Applications/MATLAB_R2021a.app/toolbox/eml/lib/matlab/elfun/asin.m" // pName
};

static emlrtBCInfo j_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    4,                 // lineNo
    33,                // colNo
    "simRef",          // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo k_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    11,                // lineNo
    19,                // colNo
    "repeats",         // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo l_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    13,                // lineNo
    17,                // colNo
    "ssubs",           // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo m_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    21,                // lineNo
    5,                 // colNo
    "simRef",          // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo n_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    13,                 // lineNo
    5,                  // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo o_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    34,                 // lineNo
    24,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo p_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    29,                 // lineNo
    22,                 // colNo
    "xdata",            // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo q_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    29,                 // lineNo
    33,                 // colNo
    "xdata",            // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo r_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    29,                 // lineNo
    48,                 // colNo
    "xdata",            // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo s_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    24,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo t_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    39,                 // colNo
    "dummyref",         // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo u_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    9,                  // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo v_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    43,              // lineNo
    21,              // colNo
    "sld",           // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtBCInfo w_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    72,              // lineNo
    5,               // colNo
    "out",           // aName
    "abeles_single", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_single.m", // pName
    0                                    // checkKind
};

static emlrtRTEInfo d_emlrtRTEI{
    1,                 // lineNo
    19,                // colNo
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    4,                 // lineNo
    33,                // colNo
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    18,                // lineNo
    11,                // colNo
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    7,                  // lineNo
    1,                  // colNo
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    21,                // lineNo
    5,                 // colNo
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m" // pName
};

// Function Definitions
void abeles_loop_new(const emlrtStack *sp,
                     const coder::array<cell_wrap_0, 1U> &simXdata,
                     const coder::array<cell_wrap_1, 1U> &slds,
                     const coder::array<real_T, 1U> &nbairs,
                     const coder::array<real_T, 1U> &nbsubs,
                     const coder::array<real_T, 1U> &repeats,
                     const coder::array<real_T, 1U> &resolutions,
                     const coder::array<real_T, 1U> &ssubs,
                     coder::array<cell_wrap_0, 1U> &simRef)
{
  coder::array<real_T, 1U> dummydata;
  coder::array<real_T, 1U> ref;
  emlrtStack b_st;
  emlrtStack st;
  creal_T MI[4];
  creal_T b_MI[4];
  creal_T pimag;
  creal_T psub;
  real_T ar_tmp;
  int32_T i;
  int32_T i2;
  int32_T ihi;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  ihi = simXdata.size(0);
  simRef.set_size(&d_emlrtRTEI, sp, simXdata.size(0));
  for (i = 0; i < ihi; i++) {
    if (i > simRef.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(i, 0, simRef.size(0) - 1, &j_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    simRef[i].f1.set_size(&d_emlrtRTEI, sp, 0);
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtCTX)sp);
    }
  }
  i = simXdata.size(0);
  simRef.set_size(&e_emlrtRTEI, sp, simXdata.size(0));
  for (int32_T b_i{0}; b_i < i; b_i++) {
    real_T nrepeats;
    real_T snair;
    real_T snlay;
    real_T snsub;
    real_T theta;
    int32_T i1;
    int32_T i3;
    int32_T i4;
    int32_T ilow;
    int32_T loop;
    int32_T points;
    if (b_i > simXdata.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, simXdata.size(0) - 1, &d_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (b_i > slds.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, slds.size(0) - 1, &e_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (b_i + 1 > nbairs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, nbairs.size(0), &emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (b_i + 1 > nbsubs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, nbsubs.size(0), &b_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    if (b_i + 1 > repeats.size(0)) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, repeats.size(0), &k_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    nrepeats = repeats[b_i];
    if (b_i + 1 > resolutions.size(0)) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, resolutions.size(0),
                                    &c_emlrtBCI, (emlrtCTX)sp);
    }
    if (b_i + 1 > ssubs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(b_i + 1, 1, ssubs.size(0), &l_emlrtBCI,
                                    (emlrtCTX)sp);
    }
    snlay = ssubs[b_i];
    points = simXdata[b_i].f1.size(0) - 10;
    st.site = &emlrtRSI;
    //  nbair = nbairs(thisCont);
    //  nbsub = nbsubs(thisCont);
    //  ssub = ssubs(thisCont);
    //  nrepeats = nrepeatss(thisCont);
    //  resol = resols(thisCont);
    ref.set_size(&f_emlrtRTEI, &st, simXdata[b_i].f1.size(0));
    // pi = 3.141592653589;
    snair = 1.0 - nbairs[b_i] * 0.377451863036739;
    snsub = 1.0 - nbsubs[b_i] * 0.377451863036739;
    i1 = simXdata[b_i].f1.size(0);
    if (0 <= i1 - 1) {
      i2 = static_cast<int32_T>(nrepeats);
      ar_tmp = snlay * snlay;
    }
    for (loop = 0; loop < i1; loop++) {
      real_T ar;
      real_T blast_im;
      real_T blast_re;
      real_T brm;
      real_T d;
      real_T d1;
      real_T pair_im;
      real_T pair_re;
      real_T psub_tmp_tmp;
      real_T re;
      real_T rij_im;
      real_T rij_re;
      real_T rough;
      real_T x_im;
      real_T x_re;
      i3 = simXdata[b_i].f1.size(0);
      if (loop + 1 > i3) {
        emlrtDynamicBoundsCheckR2012b(loop + 1, 1, i3, &f_emlrtBCI, &st);
      }
      b_st.site = &c_emlrtRSI;
      theta = simXdata[b_i].f1[loop] * 1.54 / 12.566370614359172;
      if ((theta < -1.0) || (theta > 1.0)) {
        emlrtErrorWithMessageIdR2018a(
            &b_st, &c_emlrtRTEI, "Coder:toolbox:ElFunDomainError",
            "Coder:toolbox:ElFunDomainError", 3, 4, 4, "asin");
      }
      theta = muDoubleScalarAsin(theta);
      snlay = muDoubleScalarCos(theta);
      psub_tmp_tmp = snair * snair * (snlay * snlay);
      snlay = snsub * snsub - psub_tmp_tmp;
      psub.re = snlay;
      psub.im = snlay * 0.0;
      coder::b_sqrt(&psub);
      pair_re = snair * muDoubleScalarSin(theta);
      pair_im = pair_re * 0.0;
      blast_re = 0.0;
      blast_im = 0.0;
      i3 = slds[b_i].f1.size(0);
      if (1 > i3) {
        emlrtDynamicBoundsCheckR2012b(1, 1, i3, &g_emlrtBCI, &st);
      }
      MI[0].re = 1.0;
      MI[0].im = 0.0;
      MI[3].re = 1.0;
      MI[3].im = 0.0;
      MI[2].re = 0.0;
      MI[2].im = 0.0;
      MI[1].re = 0.0;
      MI[1].im = 0.0;
      emlrtForLoopVectorCheckR2021a(1.0, 1.0, nrepeats, mxDOUBLE_CLASS,
                                    static_cast<int32_T>(nrepeats), &emlrtRTEI,
                                    &st);
      for (ihi = 0; ihi < i2; ihi++) {
        i3 = slds[b_i].f1.size(0);
        for (ilow = 0; ilow < i3; ilow++) {
          i4 = slds[b_i].f1.size(0);
          if (ilow + 1 > i4) {
            emlrtDynamicBoundsCheckR2012b(ilow + 1, 1, i4, &h_emlrtBCI, &st);
          }
          i4 = slds[b_i].f1.size(0);
          if (ilow + 1 > i4) {
            emlrtDynamicBoundsCheckR2012b(ilow + 1, 1, i4, &i_emlrtBCI, &st);
          }
          i4 = slds[b_i].f1.size(0);
          if (ilow + 1 > i4) {
            emlrtDynamicBoundsCheckR2012b(ilow + 1, 1, i4, &v_emlrtBCI, &st);
          }
          rough = slds[b_i].f1[ilow + slds[b_i].f1.size(0) * 2];
          snlay = 1.0 -
                  slds[b_i].f1[ilow + slds[b_i].f1.size(0)] * 0.377451863036739;
          theta = snlay * snlay - psub_tmp_tmp;
          pimag.re = theta;
          pimag.im = theta * 0.0;
          coder::b_sqrt(&pimag);
          re = -78.956835208714864 * pair_re;
          snlay = -78.956835208714864 * pair_im;
          theta = rough * rough;
          ar = (re * pimag.re - snlay * pimag.im) * theta;
          rough = (re * pimag.im + snlay * pimag.re) * theta;
          if (rough == 0.0) {
            rij_re = ar / 2.3716;
            rij_im = 0.0;
          } else if (ar == 0.0) {
            rij_re = 0.0;
            rij_im = rough / 2.3716;
          } else {
            rij_re = ar / 2.3716;
            rij_im = rough / 2.3716;
          }
          if (rij_im == 0.0) {
            rij_re = muDoubleScalarExp(rij_re);
            rij_im = 0.0;
          } else if (muDoubleScalarIsInf(rij_im) &&
                     muDoubleScalarIsInf(rij_re) && (rij_re < 0.0)) {
            rij_re = 0.0;
            rij_im = 0.0;
          } else {
            theta = muDoubleScalarExp(rij_re / 2.0);
            rij_re = theta * (theta * muDoubleScalarCos(rij_im));
            rij_im = theta * (theta * muDoubleScalarSin(rij_im));
          }
          ar = pair_re - pimag.re;
          rough = pair_im - pimag.im;
          theta = pair_re + pimag.re;
          snlay = pair_im + pimag.im;
          if (snlay == 0.0) {
            if (rough == 0.0) {
              pair_re = ar / theta;
              pair_im = 0.0;
            } else if (ar == 0.0) {
              pair_re = 0.0;
              pair_im = rough / theta;
            } else {
              pair_re = ar / theta;
              pair_im = rough / theta;
            }
          } else if (theta == 0.0) {
            if (ar == 0.0) {
              pair_re = rough / snlay;
              pair_im = 0.0;
            } else if (rough == 0.0) {
              pair_re = 0.0;
              pair_im = -(ar / snlay);
            } else {
              pair_re = rough / snlay;
              pair_im = -(ar / snlay);
            }
          } else {
            brm = muDoubleScalarAbs(theta);
            re = muDoubleScalarAbs(snlay);
            if (brm > re) {
              re = snlay / theta;
              theta += re * snlay;
              pair_re = (ar + re * rough) / theta;
              pair_im = (rough - re * ar) / theta;
            } else if (re == brm) {
              if (theta > 0.0) {
                re = 0.5;
              } else {
                re = -0.5;
              }
              if (snlay > 0.0) {
                theta = 0.5;
              } else {
                theta = -0.5;
              }
              pair_re = (ar * re + rough * theta) / brm;
              pair_im = (rough * re - ar * theta) / brm;
            } else {
              re = theta / snlay;
              theta = snlay + re * theta;
              pair_re = (re * ar + rough) / theta;
              pair_im = (re * rough - ar) / theta;
            }
          }
          re = pair_re * rij_re - pair_im * rij_im;
          snlay = pair_re * rij_im + pair_im * rij_re;
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
          } else if (muDoubleScalarIsInf(pair_im) &&
                     muDoubleScalarIsInf(pair_re) && (pair_re < 0.0)) {
            pair_re = 0.0;
            pair_im = 0.0;
          } else {
            theta = muDoubleScalarExp(pair_re / 2.0);
            pair_re = theta * (theta * muDoubleScalarCos(pair_im));
            pair_im = theta * (theta * muDoubleScalarSin(pair_im));
          }
          brm = re * pair_re - snlay * pair_im;
          rij_im = re * pair_im + snlay * pair_re;
          ar = pair_re;
          d = pair_im;
          d1 = re * x_re - snlay * x_im;
          theta = re * x_im + snlay * x_re;
          pair_re = pimag.re;
          pair_im = pimag.im;
          blast_re = 4.0799904592075231 * slds[b_i].f1[ilow] * pimag.re;
          blast_im = 4.0799904592075231 * slds[b_i].f1[ilow] * pimag.im;
          for (i4 = 0; i4 < 2; i4++) {
            snlay = MI[i4].re;
            rough = MI[i4].im;
            rij_re = MI[i4 + 2].re;
            re = MI[i4 + 2].im;
            b_MI[i4].re =
                (snlay * x_re - rough * x_im) + (rij_re * brm - re * rij_im);
            b_MI[i4].im =
                (snlay * x_im + rough * x_re) + (rij_re * rij_im + re * brm);
            b_MI[i4 + 2].re =
                (snlay * d1 - rough * theta) + (rij_re * ar - re * d);
            b_MI[i4 + 2].im =
                (snlay * theta + rough * d1) + (rij_re * d + re * ar);
          }
          std::copy(&b_MI[0], &b_MI[4], &MI[0]);
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(&st);
          }
        }
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      re = -78.956835208714864 * pair_re;
      snlay = -78.956835208714864 * pair_im;
      ar = (re * psub.re - snlay * psub.im) * ar_tmp;
      rough = (re * psub.im + snlay * psub.re) * ar_tmp;
      if (rough == 0.0) {
        rij_re = ar / 2.3716;
        rij_im = 0.0;
      } else if (ar == 0.0) {
        rij_re = 0.0;
        rij_im = rough / 2.3716;
      } else {
        rij_re = ar / 2.3716;
        rij_im = rough / 2.3716;
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
      rough = pair_im - psub.im;
      theta = pair_re + psub.re;
      snlay = pair_im + psub.im;
      if (snlay == 0.0) {
        if (rough == 0.0) {
          pair_re = ar / theta;
          pair_im = 0.0;
        } else if (ar == 0.0) {
          pair_re = 0.0;
          pair_im = rough / theta;
        } else {
          pair_re = ar / theta;
          pair_im = rough / theta;
        }
      } else if (theta == 0.0) {
        if (ar == 0.0) {
          pair_re = rough / snlay;
          pair_im = 0.0;
        } else if (rough == 0.0) {
          pair_re = 0.0;
          pair_im = -(ar / snlay);
        } else {
          pair_re = rough / snlay;
          pair_im = -(ar / snlay);
        }
      } else {
        brm = muDoubleScalarAbs(theta);
        re = muDoubleScalarAbs(snlay);
        if (brm > re) {
          re = snlay / theta;
          theta += re * snlay;
          pair_re = (ar + re * rough) / theta;
          pair_im = (rough - re * ar) / theta;
        } else if (re == brm) {
          if (theta > 0.0) {
            re = 0.5;
          } else {
            re = -0.5;
          }
          if (snlay > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }
          pair_re = (ar * re + rough * theta) / brm;
          pair_im = (rough * re - ar * theta) / brm;
        } else {
          re = theta / snlay;
          theta = snlay + re * theta;
          pair_re = (re * ar + rough) / theta;
          pair_im = (re * rough - ar) / theta;
        }
      }
      re = pair_re * rij_re - pair_im * rij_im;
      snlay = pair_re * rij_im + pair_im * rij_re;
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
      brm = re * pair_re - snlay * pair_im;
      rij_im = re * pair_im + snlay * pair_re;
      ar = re * x_re - snlay * x_im;
      d = re * x_im + snlay * x_re;
      for (i3 = 0; i3 < 2; i3++) {
        d1 = MI[i3].re;
        theta = MI[i3].im;
        snlay = MI[i3 + 2].re;
        rough = MI[i3 + 2].im;
        b_MI[i3].re =
            (d1 * x_re - theta * x_im) + (snlay * brm - rough * rij_im);
        b_MI[i3].im =
            (d1 * x_im + theta * x_re) + (snlay * rij_im + rough * brm);
        b_MI[i3 + 2].re =
            (d1 * ar - theta * d) + (snlay * pair_re - rough * pair_im);
        b_MI[i3 + 2].im =
            (d1 * d + theta * ar) + (snlay * pair_im + rough * pair_re);
      }
      rough = b_MI[1].re * b_MI[1].re - b_MI[1].im * -b_MI[1].im;
      rij_re = b_MI[1].re * -b_MI[1].im + b_MI[1].im * b_MI[1].re;
      theta = b_MI[0].re * b_MI[0].re - b_MI[0].im * -b_MI[0].im;
      snlay = b_MI[0].re * -b_MI[0].im + b_MI[0].im * b_MI[0].re;
      if (snlay == 0.0) {
        if (rij_re == 0.0) {
          pair_re = rough / theta;
          pair_im = 0.0;
        } else if (rough == 0.0) {
          pair_re = 0.0;
          pair_im = rij_re / theta;
        } else {
          pair_re = rough / theta;
          pair_im = rij_re / theta;
        }
      } else if (theta == 0.0) {
        if (rough == 0.0) {
          pair_re = rij_re / snlay;
          pair_im = 0.0;
        } else if (rij_re == 0.0) {
          pair_re = 0.0;
          pair_im = -(rough / snlay);
        } else {
          pair_re = rij_re / snlay;
          pair_im = -(rough / snlay);
        }
      } else {
        brm = muDoubleScalarAbs(theta);
        re = muDoubleScalarAbs(snlay);
        if (brm > re) {
          re = snlay / theta;
          theta += re * snlay;
          pair_re = (rough + re * rij_re) / theta;
          pair_im = (rij_re - re * rough) / theta;
        } else if (re == brm) {
          if (theta > 0.0) {
            re = 0.5;
          } else {
            re = -0.5;
          }
          if (snlay > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }
          pair_re = (rough * re + rij_re * theta) / brm;
          pair_im = (rij_re * re - rough * theta) / brm;
        } else {
          re = theta / snlay;
          theta = snlay + re * theta;
          pair_re = (re * rough + rij_re) / theta;
          pair_im = (re * rij_re - rough) / theta;
        }
      }
      if (loop + 1 > ref.size(0)) {
        emlrtDynamicBoundsCheckR2012b(loop + 1, 1, ref.size(0), &w_emlrtBCI,
                                      &st);
      }
      ref[loop] = muDoubleScalarHypot(pair_re, pair_im);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    st.site = &b_emlrtRSI;
    //  Apply resolution correction
    dummydata.set_size(&g_emlrtRTEI, &st, simXdata[b_i].f1.size(0));
    loop = simXdata[b_i].f1.size(0);
    for (i1 = 0; i1 < loop; i1++) {
      dummydata[i1] = 0.0;
    }
    i1 = simXdata[b_i].f1.size(0);
    for (int32_T j{0}; j < i1; j++) {
      theta = 0.0;
      if (j + 1 > dummydata.size(0)) {
        emlrtDynamicBoundsCheckR2012b(j + 1, 1, dummydata.size(0), &n_emlrtBCI,
                                      &st);
      }
      dummydata[j] = 0.0;
      if (j + 1 > 10) {
        ilow = -10;
      } else {
        ilow = -j;
      }
      if (j + 1 < points) {
        ihi = 1;
      } else {
        ihi = points - j;
      }
      //     try
      i3 = (ihi - ilow) + 9;
      emlrtForLoopVectorCheckR2021a(static_cast<real_T>(ilow), 1.0,
                                    static_cast<real_T>(ihi + 9),
                                    mxDOUBLE_CLASS, i3 + 1, &b_emlrtRTEI, &st);
      for (ihi = 0; ihi <= i3; ihi++) {
        b_st.site = &h_emlrtRSI;
        i4 = simXdata[b_i].f1.size(0);
        loop = ((j + ilow) + ihi) + 1;
        if ((loop < 1) || (loop > i4)) {
          emlrtDynamicBoundsCheckR2012b(loop, 1, i4, &p_emlrtBCI, &b_st);
        }
        i4 = simXdata[b_i].f1.size(0);
        if (j + 1 > i4) {
          emlrtDynamicBoundsCheckR2012b(j + 1, 1, i4, &q_emlrtBCI, &b_st);
        }
        i4 = simXdata[b_i].f1.size(0);
        if (j + 1 > i4) {
          emlrtDynamicBoundsCheckR2012b(j + 1, 1, i4, &r_emlrtBCI, &b_st);
        }
        snlay = (simXdata[b_i].f1[loop - 1] - simXdata[b_i].f1[j]) /
                ((resolutions[b_i] + 0.0001) * simXdata[b_i].f1[j]);
        snlay = muDoubleScalarExp(-(snlay * snlay));
        theta += snlay;
        if (j + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(j + 1, 1, dummydata.size(0),
                                        &s_emlrtBCI, &st);
        }
        if (loop > ref.size(0)) {
          emlrtDynamicBoundsCheckR2012b(loop, 1, ref.size(0), &t_emlrtBCI, &st);
        }
        if (j + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(j + 1, 1, dummydata.size(0),
                                        &u_emlrtBCI, &st);
        }
        dummydata[j] = dummydata[j] + ref[loop - 1] * snlay;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      if (theta != 0.0) {
        if (j + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(j + 1, 1, dummydata.size(0),
                                        &o_emlrtBCI, &st);
        }
        dummydata[j] = dummydata[j] / theta;
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    ihi = simRef.size(0) - 1;
    if (b_i > simRef.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(b_i, 0, simRef.size(0) - 1, &m_emlrtBCI,
                                    &st);
    }
    simRef[b_i].f1.set_size(&h_emlrtRTEI, &st, dummydata.size(0));
    loop = dummydata.size(0);
    for (i1 = 0; i1 < loop; i1++) {
      if (b_i > ihi) {
        emlrtDynamicBoundsCheckR2012b(b_i, 0, ihi, &m_emlrtBCI, &st);
      }
      simRef[b_i].f1[i1] = dummydata[i1];
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtCTX)sp);
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

// End of code generation (abeles_loop_new.cpp)
