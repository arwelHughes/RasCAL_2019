//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
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
#include <cstring>

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

static emlrtRSInfo d_emlrtRSI{
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
    "/Applications/MATLAB_R2025a.app/toolbox/eml/lib/matlab/elfun/asin.m" // pName
};

static emlrtBCInfo i_emlrtBCI{
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

static emlrtBCInfo j_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    11,                // lineNo
    27,                // colNo
    "repeats",         // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo k_emlrtBCI{
    -1,                // iFirst
    -1,                // iLast
    13,                // lineNo
    23,                // colNo
    "ssubs",           // aName
    "abeles_loop_new", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/abeles_loop_new.m", // pName
    0                                      // checkKind
};

static emlrtBCInfo l_emlrtBCI{
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

static emlrtBCInfo m_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    13,                 // lineNo
    15,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo n_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    34,                 // lineNo
    34,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo o_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    29,                 // lineNo
    28,                 // colNo
    "xdata",            // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo p_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    29,                 // lineNo
    39,                 // colNo
    "xdata",            // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo q_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    34,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo r_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    48,                 // colNo
    "dummyref",         // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo s_emlrtBCI{
    -1,                 // iFirst
    -1,                 // iLast
    31,                 // lineNo
    19,                 // colNo
    "dummydata",        // aName
    "resolution_polly", // fName
    "/Users/arwel/Documents/coding/RasCAL_2019/Rascal_functions/"
    "abeles_loop_coder/resolution_polly.m", // pName
    0                                       // checkKind
};

static emlrtBCInfo t_emlrtBCI{
    -1,              // iFirst
    -1,              // iLast
    72,              // lineNo
    9,               // colNo
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
  creal_T N[4];
  creal_T pimag;
  creal_T psub;
  int32_T unnamed_idx_0;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtConstCTX)sp);
  unnamed_idx_0 = simXdata.size(0);
  simRef.set_size(&d_emlrtRTEI, sp, simXdata.size(0));
  for (int32_T reploop{0}; reploop < unnamed_idx_0; reploop++) {
    if (reploop > simRef.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(reploop, 0, simRef.size(0) - 1, &i_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    simRef[reploop].f1.set_size(&d_emlrtRTEI, sp, 0);
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  simRef.set_size(&d_emlrtRTEI, sp, simXdata.size(0));
  for (int32_T i{0}; i < unnamed_idx_0; i++) {
    real_T nrepeats;
    real_T rsub;
    real_T snair;
    real_T snlay;
    real_T snsub;
    real_T theta;
    int32_T b_i;
    int32_T i1;
    int32_T ihi;
    int32_T ilow;
    int32_T points_tmp;
    b_i = simXdata.size(0) - 1;
    if (i > simXdata.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(i, 0, simXdata.size(0) - 1, &d_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (i > slds.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(i, 0, slds.size(0) - 1, &e_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (i + 1 > nbairs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, nbairs.size(0), &emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (i + 1 > nbsubs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, nbsubs.size(0), &b_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (i + 1 > repeats.size(0)) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, repeats.size(0), &j_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    nrepeats = repeats[i];
    if (i + 1 > resolutions.size(0)) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, resolutions.size(0), &c_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    if (i + 1 > ssubs.size(0)) {
      emlrtDynamicBoundsCheckR2012b(i + 1, 1, ssubs.size(0), &k_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    rsub = ssubs[i];
    points_tmp = simXdata[i].f1.size(0);
    st.site = &emlrtRSI;
    //  nbair = nbairs(thisCont);
    //  nbsub = nbsubs(thisCont);
    //  ssub = ssubs(thisCont);
    //  nrepeats = nrepeatss(thisCont);
    //  resol = resols(thisCont);
    ref.set_size(&d_emlrtRTEI, &st, points_tmp);
    // pi = 3.141592653589;
    snair = 1.0 - nbairs[i] * 0.377451863036739;
    snsub = 1.0 - nbsubs[i] * 0.377451863036739;
    for (int32_T loop{0}; loop < points_tmp; loop++) {
      real_T ai;
      real_T ar;
      real_T b_ai;
      real_T b_ar;
      real_T b_pair_re;
      real_T blast_im;
      real_T blast_re;
      real_T d;
      real_T im;
      real_T pair_im;
      real_T pair_re;
      real_T psub_tmp_tmp;
      real_T rij_im;
      real_T rij_re;
      real_T rough;
      if (loop + 1 > points_tmp) {
        emlrtDynamicBoundsCheckR2012b(loop + 1, 1, points_tmp, &f_emlrtBCI,
                                      &st);
      }
      b_st.site = &c_emlrtRSI;
      theta = simXdata[i].f1[loop] * 1.54 / 12.566370614359172;
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
      coder::b_sqrt(psub);
      pair_re = snair * muDoubleScalarSin(theta);
      pair_im = pair_re * 0.0;
      blast_re = 0.0;
      blast_im = 0.0;
      ihi = slds[i].f1.size(0);
      if (ihi < 1) {
        emlrtDynamicBoundsCheckR2012b(1, 1, ihi, &g_emlrtBCI, &st);
      }
      MI[0].re = 1.0;
      MI[0].im = 0.0;
      MI[3].re = 1.0;
      MI[3].im = 0.0;
      MI[2].re = 0.0;
      MI[2].im = 0.0;
      MI[1].re = 0.0;
      MI[1].im = 0.0;
      ilow = static_cast<int32_T>(nrepeats);
      emlrtForLoopVectorCheckR2021a(1.0, 1.0, nrepeats, mxDOUBLE_CLASS,
                                    static_cast<int32_T>(nrepeats), &emlrtRTEI,
                                    &st);
      for (int32_T reploop{0}; reploop < ilow; reploop++) {
        for (int32_T nl{0}; nl < ihi; nl++) {
          if (nl + 1 > ihi) {
            emlrtDynamicBoundsCheckR2012b(nl + 1, 1, ihi, &h_emlrtBCI, &st);
          }
          rough = slds[i].f1[nl + slds[i].f1.size(0) * 2];
          snlay = 1.0 - slds[i].f1[nl + slds[i].f1.size(0)] * 0.377451863036739;
          theta = snlay * snlay - psub_tmp_tmp;
          pimag.re = theta;
          pimag.im = theta * 0.0;
          coder::b_sqrt(pimag);
          snlay = -78.956835208714864 * pair_re;
          im = -78.956835208714864 * pair_im;
          theta = rough * rough;
          b_ar = (snlay * pimag.re - im * pimag.im) * theta;
          theta *= snlay * pimag.im + im * pimag.re;
          if (theta == 0.0) {
            rij_re = b_ar / 2.3716;
            rij_im = 0.0;
          } else if (b_ar == 0.0) {
            rij_re = 0.0;
            rij_im = theta / 2.3716;
          } else {
            rij_re = b_ar / 2.3716;
            rij_im = theta / 2.3716;
          }
          if (rij_re == 0.0) {
            rij_re = muDoubleScalarCos(rij_im);
            rij_im = muDoubleScalarSin(rij_im);
          } else if (rij_im == 0.0) {
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
          b_ai = pair_im - pimag.im;
          rough = pair_re + pimag.re;
          im = pair_im + pimag.im;
          if (im == 0.0) {
            if (b_ai == 0.0) {
              b_pair_re = ar / rough;
              theta = 0.0;
            } else if (ar == 0.0) {
              b_pair_re = 0.0;
              theta = b_ai / rough;
            } else {
              b_pair_re = ar / rough;
              theta = b_ai / rough;
            }
          } else if (rough == 0.0) {
            if (ar == 0.0) {
              b_pair_re = b_ai / im;
              theta = 0.0;
            } else if (b_ai == 0.0) {
              b_pair_re = 0.0;
              theta = -(ar / im);
            } else {
              b_pair_re = b_ai / im;
              theta = -(ar / im);
            }
          } else {
            b_ar = muDoubleScalarAbs(rough);
            theta = muDoubleScalarAbs(im);
            if (b_ar > theta) {
              snlay = im / rough;
              theta = rough + snlay * im;
              b_pair_re = (ar + snlay * b_ai) / theta;
              theta = (b_ai - snlay * ar) / theta;
            } else if (theta == b_ar) {
              if (rough > 0.0) {
                snlay = 0.5;
              } else {
                snlay = -0.5;
              }
              if (im > 0.0) {
                theta = 0.5;
              } else {
                theta = -0.5;
              }
              b_pair_re = (ar * snlay + b_ai * theta) / b_ar;
              theta = (b_ai * snlay - ar * theta) / b_ar;
            } else {
              snlay = rough / im;
              theta = im + snlay * rough;
              b_pair_re = (snlay * ar + b_ai) / theta;
              theta = (snlay * b_ai - ar) / theta;
            }
          }
          rough = b_pair_re * rij_re - theta * rij_im;
          snlay = b_pair_re * rij_im + theta * rij_re;
          im = blast_re * 0.0 - blast_im;
          b_ar = blast_re + blast_im * 0.0;
          if (im == 0.0) {
            im = muDoubleScalarCos(b_ar);
            b_ar = muDoubleScalarSin(b_ar);
          } else if (b_ar == 0.0) {
            im = muDoubleScalarExp(im);
            b_ar = 0.0;
          } else if (muDoubleScalarIsInf(b_ar) && muDoubleScalarIsInf(im) &&
                     (im < 0.0)) {
            im = 0.0;
            b_ar = 0.0;
          } else {
            theta = muDoubleScalarExp(im / 2.0);
            im = theta * (theta * muDoubleScalarCos(b_ar));
            b_ar = theta * (theta * muDoubleScalarSin(b_ar));
          }
          N[0].re = im;
          N[0].im = b_ar;
          pair_re = -blast_re * 0.0 - (-blast_im);
          pair_im = -blast_re + -blast_im * 0.0;
          if (pair_re == 0.0) {
            pair_re = muDoubleScalarCos(pair_im);
            pair_im = muDoubleScalarSin(pair_im);
          } else if (pair_im == 0.0) {
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
          N[1].re = rough * pair_re - snlay * pair_im;
          N[1].im = rough * pair_im + snlay * pair_re;
          N[3].re = pair_re;
          N[3].im = pair_im;
          N[2].re = rough * im - snlay * b_ar;
          N[2].im = rough * b_ar + snlay * im;
          pair_re = pimag.re;
          pair_im = pimag.im;
          snlay = 4.0799904592075231 * slds[i].f1[nl];
          blast_re = snlay * pimag.re;
          blast_im = snlay * pimag.im;
          theta = MI[0].re;
          snlay = MI[0].im;
          rough = MI[1].re;
          im = MI[1].im;
          b_ar = MI[2].re;
          ai = MI[2].im;
          b_ai = MI[3].re;
          rij_im = MI[3].im;
          for (int32_T i2{0}; i2 < 2; i2++) {
            i1 = i2 << 1;
            pimag = N[i1];
            rij_re = theta * pimag.re - snlay * pimag.im;
            d = theta * pimag.im + snlay * pimag.re;
            ar = rough * pimag.re - im * pimag.im;
            b_pair_re = rough * pimag.im + im * pimag.re;
            pimag = N[i1 + 1];
            rij_re += b_ar * pimag.re - ai * pimag.im;
            MI[i1].re = rij_re;
            d += b_ar * pimag.im + ai * pimag.re;
            MI[i1].im = d;
            ar += b_ai * pimag.re - rij_im * pimag.im;
            MI[i1 + 1].re = ar;
            b_pair_re += b_ai * pimag.im + rij_im * pimag.re;
            MI[i1 + 1].im = b_pair_re;
          }
          if (*emlrtBreakCheckR2012bFlagVar != 0) {
            emlrtBreakCheckR2012b(&st);
          }
        }
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      theta = -78.956835208714864 * pair_re;
      snlay = -78.956835208714864 * pair_im;
      rough = rsub * rsub;
      im = (theta * psub.re - snlay * psub.im) * rough;
      theta = (theta * psub.im + snlay * psub.re) * rough;
      if (theta == 0.0) {
        rij_re = im / 2.3716;
        rij_im = 0.0;
      } else if (im == 0.0) {
        rij_re = 0.0;
        rij_im = theta / 2.3716;
      } else {
        rij_re = im / 2.3716;
        rij_im = theta / 2.3716;
      }
      if (rij_re == 0.0) {
        rij_re = muDoubleScalarCos(rij_im);
        rij_im = muDoubleScalarSin(rij_im);
      } else if (rij_im == 0.0) {
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
      b_pair_re = pair_re - psub.re;
      ai = pair_im - psub.im;
      rough = pair_re + psub.re;
      im = pair_im + psub.im;
      if (im == 0.0) {
        if (ai == 0.0) {
          ar = b_pair_re / rough;
          theta = 0.0;
        } else if (b_pair_re == 0.0) {
          ar = 0.0;
          theta = ai / rough;
        } else {
          ar = b_pair_re / rough;
          theta = ai / rough;
        }
      } else if (rough == 0.0) {
        if (b_pair_re == 0.0) {
          ar = ai / im;
          theta = 0.0;
        } else if (ai == 0.0) {
          ar = 0.0;
          theta = -(b_pair_re / im);
        } else {
          ar = ai / im;
          theta = -(b_pair_re / im);
        }
      } else {
        b_ar = muDoubleScalarAbs(rough);
        theta = muDoubleScalarAbs(im);
        if (b_ar > theta) {
          snlay = im / rough;
          theta = rough + snlay * im;
          ar = (b_pair_re + snlay * ai) / theta;
          theta = (ai - snlay * b_pair_re) / theta;
        } else if (theta == b_ar) {
          if (rough > 0.0) {
            snlay = 0.5;
          } else {
            snlay = -0.5;
          }
          if (im > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }
          ar = (b_pair_re * snlay + ai * theta) / b_ar;
          theta = (ai * snlay - b_pair_re * theta) / b_ar;
        } else {
          snlay = rough / im;
          theta = im + snlay * rough;
          ar = (snlay * b_pair_re + ai) / theta;
          theta = (snlay * ai - b_pair_re) / theta;
        }
      }
      rough = ar * rij_re - theta * rij_im;
      snlay = ar * rij_im + theta * rij_re;
      im = blast_re * 0.0 - blast_im;
      b_ar = blast_re + blast_im * 0.0;
      if (im == 0.0) {
        im = muDoubleScalarCos(b_ar);
        b_ar = muDoubleScalarSin(b_ar);
      } else if (b_ar == 0.0) {
        im = muDoubleScalarExp(im);
        b_ar = 0.0;
      } else if (muDoubleScalarIsInf(b_ar) && muDoubleScalarIsInf(im) &&
                 (im < 0.0)) {
        im = 0.0;
        b_ar = 0.0;
      } else {
        theta = muDoubleScalarExp(im / 2.0);
        im = theta * (theta * muDoubleScalarCos(b_ar));
        b_ar = theta * (theta * muDoubleScalarSin(b_ar));
      }
      N[0].re = im;
      N[0].im = b_ar;
      pair_re = -blast_re * 0.0 - (-blast_im);
      pair_im = -blast_re + -blast_im * 0.0;
      if (pair_re == 0.0) {
        pair_re = muDoubleScalarCos(pair_im);
        pair_im = muDoubleScalarSin(pair_im);
      } else if (pair_im == 0.0) {
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
      N[1].re = rough * pair_re - snlay * pair_im;
      N[1].im = rough * pair_im + snlay * pair_re;
      N[3].re = pair_re;
      N[3].im = pair_im;
      N[2].re = rough * im - snlay * b_ar;
      N[2].im = rough * b_ar + snlay * im;
      theta = MI[0].re;
      snlay = MI[0].im;
      rough = MI[1].re;
      im = MI[1].im;
      b_ar = MI[2].re;
      ar = MI[2].im;
      b_pair_re = MI[3].re;
      ai = MI[3].im;
      for (int32_T reploop{0}; reploop < 2; reploop++) {
        ihi = reploop << 1;
        pimag = N[ihi];
        b_ai = theta * pimag.re - snlay * pimag.im;
        rij_im = theta * pimag.im + snlay * pimag.re;
        rij_re = rough * pimag.re - im * pimag.im;
        d = rough * pimag.im + im * pimag.re;
        pimag = N[ihi + 1];
        b_ai += b_ar * pimag.re - ar * pimag.im;
        MI[ihi].re = b_ai;
        rij_im += b_ar * pimag.im + ar * pimag.re;
        MI[ihi].im = rij_im;
        rij_re += b_pair_re * pimag.re - ai * pimag.im;
        MI[ihi + 1].re = rij_re;
        d += b_pair_re * pimag.im + ai * pimag.re;
        MI[ihi + 1].im = d;
      }
      ar = MI[1].re * MI[1].re - MI[1].im * -MI[1].im;
      b_pair_re = MI[1].re * -MI[1].im + MI[1].im * MI[1].re;
      rough = MI[0].re * MI[0].re - MI[0].im * -MI[0].im;
      im = MI[0].re * -MI[0].im + MI[0].im * MI[0].re;
      if (im == 0.0) {
        if (b_pair_re == 0.0) {
          pair_re = ar / rough;
          pair_im = 0.0;
        } else if (ar == 0.0) {
          pair_re = 0.0;
          pair_im = b_pair_re / rough;
        } else {
          pair_re = ar / rough;
          pair_im = b_pair_re / rough;
        }
      } else if (rough == 0.0) {
        if (ar == 0.0) {
          pair_re = b_pair_re / im;
          pair_im = 0.0;
        } else if (b_pair_re == 0.0) {
          pair_re = 0.0;
          pair_im = -(ar / im);
        } else {
          pair_re = b_pair_re / im;
          pair_im = -(ar / im);
        }
      } else {
        b_ar = muDoubleScalarAbs(rough);
        snlay = muDoubleScalarAbs(im);
        if (b_ar > snlay) {
          theta = im / rough;
          snlay = rough + theta * im;
          pair_re = (ar + theta * b_pair_re) / snlay;
          pair_im = (b_pair_re - theta * ar) / snlay;
        } else if (snlay == b_ar) {
          if (rough > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }
          if (im > 0.0) {
            snlay = 0.5;
          } else {
            snlay = -0.5;
          }
          pair_re = (ar * theta + b_pair_re * snlay) / b_ar;
          pair_im = (b_pair_re * theta - ar * snlay) / b_ar;
        } else {
          theta = rough / im;
          snlay = im + theta * rough;
          pair_re = (theta * ar + b_pair_re) / snlay;
          pair_im = (theta * b_pair_re - ar) / snlay;
        }
      }
      if (loop + 1 > ref.size(0)) {
        emlrtDynamicBoundsCheckR2012b(loop + 1, 1, ref.size(0), &t_emlrtBCI,
                                      &st);
      }
      ref[loop] = muDoubleScalarHypot(pair_re, pair_im);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    st.site = &b_emlrtRSI;
    //  Apply resolution correction
    dummydata.set_size(&d_emlrtRTEI, &st, points_tmp);
    if (points_tmp - 1 >= 0) {
      std::memset(&dummydata[0], 0,
                  static_cast<uint32_T>(points_tmp) * sizeof(real_T));
    }
    for (int32_T nl{0}; nl < points_tmp; nl++) {
      theta = 0.0;
      if (nl + 1 > dummydata.size(0)) {
        emlrtDynamicBoundsCheckR2012b(nl + 1, 1, dummydata.size(0), &m_emlrtBCI,
                                      &st);
      }
      dummydata[nl] = 0.0;
      if (nl + 1 > 10) {
        ilow = -10;
      } else {
        ilow = -nl;
      }
      if (nl + 1 < points_tmp - 10) {
        ihi = 1;
      } else {
        ihi = (points_tmp - nl) - 10;
      }
      //     try
      i1 = (ihi - ilow) + 9;
      emlrtForLoopVectorCheckR2021a(static_cast<real_T>(ilow), 1.0,
                                    static_cast<real_T>(ihi + 9),
                                    mxDOUBLE_CLASS, i1 + 1, &b_emlrtRTEI, &st);
      for (int32_T reploop{0}; reploop <= i1; reploop++) {
        b_st.site = &d_emlrtRSI;
        ihi = ((nl + ilow) + reploop) + 1;
        if ((ihi < 1) || (ihi > points_tmp)) {
          emlrtDynamicBoundsCheckR2012b(ihi, 1, points_tmp, &o_emlrtBCI, &b_st);
        }
        if (nl + 1 > points_tmp) {
          emlrtDynamicBoundsCheckR2012b(nl + 1, 1, points_tmp, &p_emlrtBCI,
                                        &b_st);
        }
        snlay = simXdata[i].f1[nl];
        snlay = (simXdata[i].f1[ihi - 1] - snlay) /
                ((resolutions[i] + 0.0001) * snlay);
        snlay = muDoubleScalarExp(-(snlay * snlay));
        theta += snlay;
        if (nl + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(nl + 1, 1, dummydata.size(0),
                                        &q_emlrtBCI, &st);
        }
        if (ihi > ref.size(0)) {
          emlrtDynamicBoundsCheckR2012b(ihi, 1, ref.size(0), &r_emlrtBCI, &st);
        }
        if (nl + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(nl + 1, 1, dummydata.size(0),
                                        &s_emlrtBCI, &st);
        }
        dummydata[nl] = dummydata[nl] + ref[ihi - 1] * snlay;
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b(&st);
        }
      }
      if (theta != 0.0) {
        if (nl + 1 > dummydata.size(0)) {
          emlrtDynamicBoundsCheckR2012b(nl + 1, 1, dummydata.size(0),
                                        &n_emlrtBCI, &st);
        }
        dummydata[nl] = dummydata[nl] / theta;
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    if (i > simXdata.size(0) - 1) {
      emlrtDynamicBoundsCheckR2012b(i, 0, simXdata.size(0) - 1, &l_emlrtBCI,
                                    &st);
    }
    ihi = dummydata.size(0);
    simRef[i].f1.set_size(&d_emlrtRTEI, &st, dummydata.size(0));
    for (int32_T reploop{0}; reploop < ihi; reploop++) {
      if (i > b_i) {
        emlrtDynamicBoundsCheckR2012b(i, 0, b_i, &l_emlrtBCI, &st);
      }
      simRef[i].f1[reploop] = dummydata[reploop];
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtConstCTX)sp);
}

// End of code generation (abeles_loop_new.cpp)
