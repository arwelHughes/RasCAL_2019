//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
// File: abeles_loop_new.cpp
//
// MATLAB Coder version            : 5.0
// C/C++ source code generated on  : 23-Oct-2021 10:24:46
//

// Include Files
#include "abeles_loop_new.h"
#include "sqrt.h"
#include <cmath>

// Function Definitions

//
// Arguments    : const coder::array<cell_wrap_0, 2U> *simXdata
//                const coder::array<cell_wrap_1, 2U> *slds
//                const coder::array<double, 2U> *nbairs
//                const coder::array<double, 2U> *nbsubs
//                const coder::array<double, 2U> *repeats
//                const coder::array<double, 2U> *resolutions
//                const coder::array<double, 2U> *ssubs
//                coder::array<cell_wrap_0, 1U> *simRef
// Return Type  : void
//
void abeles_loop_new(const coder::array<cell_wrap_0, 2U> &simXdata, const coder::
                     array<cell_wrap_1, 2U> &slds, const coder::array<double, 2U>
                     &nbairs, const coder::array<double, 2U> &nbsubs, const
                     coder::array<double, 2U> &repeats, const coder::array<
                     double, 2U> &resolutions, const coder::array<double, 2U>
                     &ssubs, coder::array<cell_wrap_0, 1U> &simRef)
{
  int i;
  coder::array<double, 1U> ref;
  int i2;
  double ar_tmp;
  creal_T MI[2][2];
  coder::array<double, 1U> dummydata;
  double theta;
  creal_T psub;
  creal_T pimag;
  creal_T b_MI[2][2];
  i = simXdata.size(1);
  simRef.set_size(simXdata.size(1));
  for (int b_i = 0; b_i < i; b_i++) {
    int i1;
    int varargin_2;
    double r;
    double snair;
    double snsub;
    int ilow;
    int nl;
    int reploop;
    int i3;
    int c_i;
    i1 = simXdata[b_i].f1.size(0);
    varargin_2 = simXdata[b_i].f1.size(0) - 10;
    r = ssubs[b_i];
    ref.set_size(simXdata[simXdata.size(0) * b_i].f1.size(0));
    snair = 1.0 - nbairs[b_i] * 0.377451863036739;
    snsub = 1.0 - nbsubs[b_i] * 0.377451863036739;
    if (0 <= i1 - 1) {
      i2 = static_cast<int>(repeats[b_i]);
      ar_tmp = r * r;
    }

    for (ilow = 0; ilow < i1; ilow++) {
      double psub_tmp_tmp;
      double pair_re;
      double pair_im;
      double blast_re;
      double blast_im;
      double re;
      double im;
      double ar;
      double MI_im;
      double rij_re;
      double rij_im;
      double MI_re;
      double brm;
      double bim;
      MI[0][0].re = 1.0;
      MI[0][0].im = 0.0;
      MI[0][1].re = 0.0;
      MI[0][1].im = 0.0;
      MI[1][0].re = 0.0;
      MI[1][0].im = 0.0;
      MI[1][1].re = 1.0;
      MI[1][1].im = 0.0;
      theta = std::asin(simXdata[b_i].f1[ilow] * 1.54 / 12.566370614359172);
      r = std::cos(theta);
      psub_tmp_tmp = snair * snair * (r * r);
      r = snsub * snsub - psub_tmp_tmp;
      psub.re = r;
      psub.im = r * 0.0;
      b_sqrt(&psub);
      pair_re = snair * std::sin(theta);
      pair_im = pair_re * 0.0;
      blast_re = 0.0;
      blast_im = 0.0;
      for (reploop = 0; reploop < i2; reploop++) {
        i3 = slds[b_i].f1.size(0);
        for (nl = 0; nl < i3; nl++) {
          theta = slds[b_i].f1[nl + slds[b_i].f1.size(0) * 2];
          r = 1.0 - slds[b_i].f1[nl + slds[b_i].f1.size(0)] * 0.377451863036739;
          r = r * r - psub_tmp_tmp;
          pimag.re = r;
          pimag.im = r * 0.0;
          b_sqrt(&pimag);
          re = -78.956835208714864 * pair_re;
          im = -78.956835208714864 * pair_im;
          r = theta * theta;
          ar = (re * pimag.re - im * pimag.im) * r;
          MI_im = (re * pimag.im + im * pimag.re) * r;
          if (MI_im == 0.0) {
            rij_re = ar / 2.3716;
            rij_im = 0.0;
          } else if (ar == 0.0) {
            rij_re = 0.0;
            rij_im = MI_im / 2.3716;
          } else {
            rij_re = ar / 2.3716;
            rij_im = MI_im / 2.3716;
          }

          if (rij_im == 0.0) {
            rij_re = std::exp(rij_re);
            rij_im = 0.0;
          } else if (std::isinf(rij_im) && std::isinf(rij_re) && (rij_re < 0.0))
          {
            rij_re = 0.0;
            rij_im = 0.0;
          } else {
            r = std::exp(rij_re / 2.0);
            rij_re = r * (r * std::cos(rij_im));
            rij_im = r * (r * std::sin(rij_im));
          }

          ar = pair_re - pimag.re;
          MI_im = pair_im - pimag.im;
          theta = pair_re + pimag.re;
          MI_re = pair_im + pimag.im;
          if (MI_re == 0.0) {
            if (MI_im == 0.0) {
              pair_re = ar / theta;
              pair_im = 0.0;
            } else if (ar == 0.0) {
              pair_re = 0.0;
              pair_im = MI_im / theta;
            } else {
              pair_re = ar / theta;
              pair_im = MI_im / theta;
            }
          } else if (theta == 0.0) {
            if (ar == 0.0) {
              pair_re = MI_im / MI_re;
              pair_im = 0.0;
            } else if (MI_im == 0.0) {
              pair_re = 0.0;
              pair_im = -(ar / MI_re);
            } else {
              pair_re = MI_im / MI_re;
              pair_im = -(ar / MI_re);
            }
          } else {
            brm = std::abs(theta);
            bim = std::abs(MI_re);
            if (brm > bim) {
              bim = MI_re / theta;
              theta += bim * MI_re;
              pair_re = (ar + bim * MI_im) / theta;
              pair_im = (MI_im - bim * ar) / theta;
            } else if (bim == brm) {
              if (theta > 0.0) {
                r = 0.5;
              } else {
                r = -0.5;
              }

              if (MI_re > 0.0) {
                theta = 0.5;
              } else {
                theta = -0.5;
              }

              pair_re = (ar * r + MI_im * theta) / brm;
              pair_im = (MI_im * r - ar * theta) / brm;
            } else {
              bim = theta / MI_re;
              theta = MI_re + bim * theta;
              pair_re = (bim * ar + MI_im) / theta;
              pair_im = (bim * MI_im - ar) / theta;
            }
          }

          re = pair_re * rij_re - pair_im * rij_im;
          im = pair_re * rij_im + pair_im * rij_re;
          rij_re = blast_re * 0.0 - blast_im;
          rij_im = blast_re + blast_im * 0.0;
          if (rij_im == 0.0) {
            rij_re = std::exp(rij_re);
            rij_im = 0.0;
          } else if (std::isinf(rij_im) && std::isinf(rij_re) && (rij_re < 0.0))
          {
            rij_re = 0.0;
            rij_im = 0.0;
          } else {
            r = std::exp(rij_re / 2.0);
            rij_re = r * (r * std::cos(rij_im));
            rij_im = r * (r * std::sin(rij_im));
          }

          pair_re = -blast_re * 0.0 - (-blast_im);
          pair_im = -blast_re + -blast_im * 0.0;
          if (pair_im == 0.0) {
            pair_re = std::exp(pair_re);
            pair_im = 0.0;
          } else if (std::isinf(pair_im) && std::isinf(pair_re) && (pair_re <
                      0.0)) {
            pair_re = 0.0;
            pair_im = 0.0;
          } else {
            r = std::exp(pair_re / 2.0);
            pair_re = r * (r * std::cos(pair_im));
            pair_im = r * (r * std::sin(pair_im));
          }

          MI_re = re * pair_re - im * pair_im;
          MI_im = re * pair_im + im * pair_re;
          r = pair_re;
          bim = pair_im;
          brm = re * rij_re - im * rij_im;
          theta = re * rij_im + im * rij_re;
          pair_re = pimag.re;
          pair_im = pimag.im;
          blast_re = 4.0799904592075231 * slds[b_i].f1[nl] * pimag.re;
          blast_im = 4.0799904592075231 * slds[b_i].f1[nl] * pimag.im;
          for (c_i = 0; c_i < 2; c_i++) {
            b_MI[0][c_i].re = (MI[0][c_i].re * rij_re - MI[0][c_i].im * rij_im)
              + (MI[1][c_i].re * MI_re - MI[1][c_i].im * MI_im);
            b_MI[0][c_i].im = (MI[0][c_i].re * rij_im + MI[0][c_i].im * rij_re)
              + (MI[1][c_i].re * MI_im + MI[1][c_i].im * MI_re);
            b_MI[1][c_i].re = (MI[0][c_i].re * brm - MI[0][c_i].im * theta) +
              (MI[1][c_i].re * r - MI[1][c_i].im * bim);
            b_MI[1][c_i].im = (MI[0][c_i].re * theta + MI[0][c_i].im * brm) +
              (MI[1][c_i].re * bim + MI[1][c_i].im * r);
          }

          MI[0][0] = b_MI[0][0];
          MI[0][1] = b_MI[0][1];
          MI[1][0] = b_MI[1][0];
          MI[1][1] = b_MI[1][1];
        }
      }

      re = -78.956835208714864 * pair_re;
      im = -78.956835208714864 * pair_im;
      ar = (re * psub.re - im * psub.im) * ar_tmp;
      MI_im = (re * psub.im + im * psub.re) * ar_tmp;
      if (MI_im == 0.0) {
        rij_re = ar / 2.3716;
        rij_im = 0.0;
      } else if (ar == 0.0) {
        rij_re = 0.0;
        rij_im = MI_im / 2.3716;
      } else {
        rij_re = ar / 2.3716;
        rij_im = MI_im / 2.3716;
      }

      if (rij_im == 0.0) {
        rij_re = std::exp(rij_re);
        rij_im = 0.0;
      } else if (std::isinf(rij_im) && std::isinf(rij_re) && (rij_re < 0.0)) {
        rij_re = 0.0;
        rij_im = 0.0;
      } else {
        r = std::exp(rij_re / 2.0);
        rij_re = r * (r * std::cos(rij_im));
        rij_im = r * (r * std::sin(rij_im));
      }

      ar = pair_re - psub.re;
      MI_im = pair_im - psub.im;
      theta = pair_re + psub.re;
      MI_re = pair_im + psub.im;
      if (MI_re == 0.0) {
        if (MI_im == 0.0) {
          pair_re = ar / theta;
          pair_im = 0.0;
        } else if (ar == 0.0) {
          pair_re = 0.0;
          pair_im = MI_im / theta;
        } else {
          pair_re = ar / theta;
          pair_im = MI_im / theta;
        }
      } else if (theta == 0.0) {
        if (ar == 0.0) {
          pair_re = MI_im / MI_re;
          pair_im = 0.0;
        } else if (MI_im == 0.0) {
          pair_re = 0.0;
          pair_im = -(ar / MI_re);
        } else {
          pair_re = MI_im / MI_re;
          pair_im = -(ar / MI_re);
        }
      } else {
        brm = std::abs(theta);
        bim = std::abs(MI_re);
        if (brm > bim) {
          bim = MI_re / theta;
          theta += bim * MI_re;
          pair_re = (ar + bim * MI_im) / theta;
          pair_im = (MI_im - bim * ar) / theta;
        } else if (bim == brm) {
          if (theta > 0.0) {
            r = 0.5;
          } else {
            r = -0.5;
          }

          if (MI_re > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }

          pair_re = (ar * r + MI_im * theta) / brm;
          pair_im = (MI_im * r - ar * theta) / brm;
        } else {
          bim = theta / MI_re;
          theta = MI_re + bim * theta;
          pair_re = (bim * ar + MI_im) / theta;
          pair_im = (bim * MI_im - ar) / theta;
        }
      }

      re = pair_re * rij_re - pair_im * rij_im;
      im = pair_re * rij_im + pair_im * rij_re;
      rij_re = blast_re * 0.0 - blast_im;
      rij_im = blast_re + blast_im * 0.0;
      if (rij_im == 0.0) {
        rij_re = std::exp(rij_re);
        rij_im = 0.0;
      } else if (std::isinf(rij_im) && std::isinf(rij_re) && (rij_re < 0.0)) {
        rij_re = 0.0;
        rij_im = 0.0;
      } else {
        r = std::exp(rij_re / 2.0);
        rij_re = r * (r * std::cos(rij_im));
        rij_im = r * (r * std::sin(rij_im));
      }

      pair_re = -blast_re * 0.0 - (-blast_im);
      pair_im = -blast_re + -blast_im * 0.0;
      if (pair_im == 0.0) {
        pair_re = std::exp(pair_re);
        pair_im = 0.0;
      } else if (std::isinf(pair_im) && std::isinf(pair_re) && (pair_re < 0.0))
      {
        pair_re = 0.0;
        pair_im = 0.0;
      } else {
        r = std::exp(pair_re / 2.0);
        pair_re = r * (r * std::cos(pair_im));
        pair_im = r * (r * std::sin(pair_im));
      }

      MI_re = re * pair_re - im * pair_im;
      MI_im = re * pair_im + im * pair_re;
      r = re * rij_re - im * rij_im;
      bim = re * rij_im + im * rij_re;
      for (i3 = 0; i3 < 2; i3++) {
        b_MI[0][i3].re = (MI[0][i3].re * rij_re - MI[0][i3].im * rij_im) + (MI[1]
          [i3].re * MI_re - MI[1][i3].im * MI_im);
        b_MI[0][i3].im = (MI[0][i3].re * rij_im + MI[0][i3].im * rij_re) + (MI[1]
          [i3].re * MI_im + MI[1][i3].im * MI_re);
        b_MI[1][i3].re = (MI[0][i3].re * r - MI[0][i3].im * bim) + (MI[1][i3].re
          * pair_re - MI[1][i3].im * pair_im);
        b_MI[1][i3].im = (MI[0][i3].re * bim + MI[0][i3].im * r) + (MI[1][i3].re
          * pair_im + MI[1][i3].im * pair_re);
      }

      MI_re = b_MI[0][1].re * b_MI[0][1].re - b_MI[0][1].im * -b_MI[0][1].im;
      MI_im = b_MI[0][1].re * -b_MI[0][1].im + b_MI[0][1].im * b_MI[0][1].re;
      r = b_MI[0][0].re * b_MI[0][0].re - b_MI[0][0].im * -b_MI[0][0].im;
      theta = b_MI[0][0].re * -b_MI[0][0].im + b_MI[0][0].im * b_MI[0][0].re;
      if (theta == 0.0) {
        if (MI_im == 0.0) {
          pair_re = MI_re / r;
          pair_im = 0.0;
        } else if (MI_re == 0.0) {
          pair_re = 0.0;
          pair_im = MI_im / r;
        } else {
          pair_re = MI_re / r;
          pair_im = MI_im / r;
        }
      } else if (r == 0.0) {
        if (MI_re == 0.0) {
          pair_re = MI_im / theta;
          pair_im = 0.0;
        } else if (MI_im == 0.0) {
          pair_re = 0.0;
          pair_im = -(MI_re / theta);
        } else {
          pair_re = MI_im / theta;
          pair_im = -(MI_re / theta);
        }
      } else {
        brm = std::abs(r);
        bim = std::abs(theta);
        if (brm > bim) {
          bim = theta / r;
          theta = r + bim * theta;
          pair_re = (MI_re + bim * MI_im) / theta;
          pair_im = (MI_im - bim * MI_re) / theta;
        } else if (bim == brm) {
          if (r > 0.0) {
            r = 0.5;
          } else {
            r = -0.5;
          }

          if (theta > 0.0) {
            theta = 0.5;
          } else {
            theta = -0.5;
          }

          pair_re = (MI_re * r + MI_im * theta) / brm;
          pair_im = (MI_im * r - MI_re * theta) / brm;
        } else {
          bim = r / theta;
          theta += bim * r;
          pair_re = (bim * MI_re + MI_im) / theta;
          pair_im = (bim * MI_im - MI_re) / theta;
        }
      }

      ref[ilow] = pair_re * pair_re - pair_im * pair_im;
    }

    //  Apply resolution correction
    dummydata.set_size(simXdata[simXdata.size(0) * b_i].f1.size(0));
    ilow = simXdata[b_i].f1.size(0);
    for (i1 = 0; i1 < ilow; i1++) {
      dummydata[i1] = 0.0;
    }

    i1 = simXdata[b_i].f1.size(0);
    for (nl = 0; nl < i1; nl++) {
      theta = 0.0;
      dummydata[nl] = 0.0;
      if (nl + 1 > 10) {
        ilow = -10;
      } else {
        ilow = -nl;
      }

      //     try
      if (nl + 1 < varargin_2) {
        reploop = 1;
      } else {
        reploop = varargin_2 - nl;
      }

      i3 = (reploop - ilow) + 9;
      for (c_i = 0; c_i <= i3; c_i++) {
        reploop = static_cast<int>((static_cast<double>(nl) + 1.0) +
          static_cast<double>(ilow + c_i)) - 1;
        r = (simXdata[b_i].f1[reploop] - simXdata[b_i].f1[nl]) /
          ((resolutions[b_i] + 0.0001) * simXdata[b_i].f1[nl]);
        r = std::exp(-(r * r));
        theta += r;
        dummydata[nl] = dummydata[nl] + ref[reploop] * r;
      }

      if (theta != 0.0) {
        dummydata[nl] = dummydata[nl] / theta;
      }
    }

    simRef[b_i].f1.set_size(dummydata.size(0));
    ilow = dummydata.size(0);
    for (i1 = 0; i1 < ilow; i1++) {
      simRef[b_i].f1[i1] = dummydata[i1];
    }
  }
}

//
// File trailer for abeles_loop_new.cpp
//
// [EOF]
//
