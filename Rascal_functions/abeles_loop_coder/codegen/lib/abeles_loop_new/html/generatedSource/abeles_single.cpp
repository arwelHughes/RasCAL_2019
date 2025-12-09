//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// abeles_single.cpp
//
// Code generation for function 'abeles_single'
//

// Include files
#include "abeles_single.h"
#include "abs.h"
#include "exp.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include "coder_array.h"
#include <cmath>

// Function Definitions
void abeles_single(const coder::array<double, 1U> &x,
                   const coder::array<double, 2U> &sld, double nbair,
                   double nbsub, double nrepeats, double rsub, double layers,
                   double points, coder::array<double, 1U> &out)
{
  creal_T MI[4];
  creal_T N[4];
  creal_T N_tmp;
  creal_T pimag;
  creal_T psub;
  double snair;
  double snsub;
  int i;
  //  nbair = nbairs(thisCont);
  //  nbsub = nbsubs(thisCont);
  //  ssub = ssubs(thisCont);
  //  nrepeats = nrepeatss(thisCont);
  //  resol = resols(thisCont);
  i = static_cast<int>(points);
  out.set_size(static_cast<int>(points));
  // pi = 3.141592653589;
  snair = 1.0 - nbair * 0.377451863036739;
  snsub = 1.0 - nbsub * 0.377451863036739;
  for (int loop{0}; loop < i; loop++) {
    double ai;
    double ar;
    double b_ai;
    double b_ar;
    double b_plast_re;
    double blast_im;
    double blast_re;
    double c_plast_re;
    double d;
    double plast_im;
    double plast_re;
    double psub_tmp_tmp;
    double rij_im;
    double rij_re;
    double rough;
    double snlay;
    double theta;
    int i1;
    theta = std::asin(x[loop] * 1.54 / 12.566370614359172);
    rij_im = std::cos(theta);
    psub_tmp_tmp = snair * snair * (rij_im * rij_im);
    rij_im = snsub * snsub - psub_tmp_tmp;
    psub.re = rij_im;
    psub.im = rij_im * 0.0;
    coder::b_sqrt(psub);
    plast_re = snair * std::sin(theta);
    plast_im = plast_re * 0.0;
    blast_re = 0.0;
    blast_im = 0.0;
    MI[0].re = 1.0;
    MI[0].im = 0.0;
    MI[3].re = 1.0;
    MI[3].im = 0.0;
    MI[2].re = 0.0;
    MI[2].im = 0.0;
    MI[1].re = 0.0;
    MI[1].im = 0.0;
    i1 = static_cast<int>(nrepeats);
    for (int reploop{0}; reploop < i1; reploop++) {
      int i2;
      i2 = static_cast<int>(layers);
      for (int nl{0}; nl < i2; nl++) {
        rough = sld[nl + sld.size(0) * 2];
        snlay = 1.0 - sld[nl + sld.size(0)] * 0.377451863036739;
        theta = snlay * snlay - psub_tmp_tmp;
        pimag.re = theta;
        pimag.im = theta * 0.0;
        coder::b_sqrt(pimag);
        rij_im = -78.956835208714864 * plast_re;
        snlay = -78.956835208714864 * plast_im;
        theta = rough * rough;
        rij_re = (rij_im * pimag.re - snlay * pimag.im) * theta;
        theta *= rij_im * pimag.im + snlay * pimag.re;
        if (theta == 0.0) {
          N[3].re = rij_re / 2.3716;
          N[3].im = 0.0;
        } else if (rij_re == 0.0) {
          N[3].re = 0.0;
          N[3].im = theta / 2.3716;
        } else {
          N[3].re = rij_re / 2.3716;
          N[3].im = theta / 2.3716;
        }
        coder::b_exp(N[3]);
        b_ar = plast_re - pimag.re;
        b_ai = plast_im - pimag.im;
        snlay = plast_re + pimag.re;
        rij_re = plast_im + pimag.im;
        if (rij_re == 0.0) {
          if (b_ai == 0.0) {
            c_plast_re = b_ar / snlay;
            theta = 0.0;
          } else if (b_ar == 0.0) {
            c_plast_re = 0.0;
            theta = b_ai / snlay;
          } else {
            c_plast_re = b_ar / snlay;
            theta = b_ai / snlay;
          }
        } else if (snlay == 0.0) {
          if (b_ar == 0.0) {
            c_plast_re = b_ai / rij_re;
            theta = 0.0;
          } else if (b_ai == 0.0) {
            c_plast_re = 0.0;
            theta = -(b_ar / rij_re);
          } else {
            c_plast_re = b_ai / rij_re;
            theta = -(b_ar / rij_re);
          }
        } else {
          rough = std::abs(snlay);
          theta = std::abs(rij_re);
          if (rough > theta) {
            rij_im = rij_re / snlay;
            theta = snlay + rij_im * rij_re;
            c_plast_re = (b_ar + rij_im * b_ai) / theta;
            theta = (b_ai - rij_im * b_ar) / theta;
          } else if (theta == rough) {
            if (snlay > 0.0) {
              rij_im = 0.5;
            } else {
              rij_im = -0.5;
            }
            if (rij_re > 0.0) {
              theta = 0.5;
            } else {
              theta = -0.5;
            }
            c_plast_re = (b_ar * rij_im + b_ai * theta) / rough;
            theta = (b_ai * rij_im - b_ar * theta) / rough;
          } else {
            rij_im = snlay / rij_re;
            theta = rij_re + rij_im * snlay;
            c_plast_re = (rij_im * b_ar + b_ai) / theta;
            theta = (rij_im * b_ai - b_ar) / theta;
          }
        }
        rij_re = c_plast_re * N[3].re - theta * N[3].im;
        rij_im = c_plast_re * N[3].im + theta * N[3].re;
        N_tmp.re = blast_re * 0.0 - blast_im;
        N_tmp.im = blast_re + blast_im * 0.0;
        coder::b_exp(N_tmp);
        N[0] = N_tmp;
        N[3].re = -blast_re * 0.0 - (-blast_im);
        N[3].im = -blast_re + -blast_im * 0.0;
        coder::b_exp(N[3]);
        N[1].re = rij_re * N[3].re - rij_im * N[3].im;
        N[1].im = rij_re * N[3].im + rij_im * N[3].re;
        N[2].re = rij_re * N_tmp.re - rij_im * N_tmp.im;
        N[2].im = rij_re * N_tmp.im + rij_im * N_tmp.re;
        plast_re = pimag.re;
        plast_im = pimag.im;
        theta = 4.0799904592075231 * sld[nl];
        blast_re = theta * pimag.re;
        blast_im = theta * pimag.im;
        theta = MI[0].re;
        rij_im = MI[0].im;
        snlay = MI[1].re;
        rij_re = MI[1].im;
        rough = MI[2].re;
        d = MI[2].im;
        b_plast_re = MI[3].re;
        c_plast_re = MI[3].im;
        for (int i3{0}; i3 < 2; i3++) {
          int i4;
          i4 = i3 << 1;
          N_tmp = N[i4];
          ar = theta * N_tmp.re - rij_im * N_tmp.im;
          ai = theta * N_tmp.im + rij_im * N_tmp.re;
          b_ar = snlay * N_tmp.re - rij_re * N_tmp.im;
          b_ai = snlay * N_tmp.im + rij_re * N_tmp.re;
          N_tmp = N[i4 + 1];
          ar += rough * N_tmp.re - d * N_tmp.im;
          MI[i4].re = ar;
          ai += rough * N_tmp.im + d * N_tmp.re;
          MI[i4].im = ai;
          b_ar += b_plast_re * N_tmp.re - c_plast_re * N_tmp.im;
          MI[i4 + 1].re = b_ar;
          b_ai += b_plast_re * N_tmp.im + c_plast_re * N_tmp.re;
          MI[i4 + 1].im = b_ai;
        }
      }
    }
    theta = -78.956835208714864 * plast_re;
    rij_im = -78.956835208714864 * plast_im;
    snlay = rsub * rsub;
    rij_re = (theta * psub.re - rij_im * psub.im) * snlay;
    theta = (theta * psub.im + rij_im * psub.re) * snlay;
    if (theta == 0.0) {
      N[3].re = rij_re / 2.3716;
      N[3].im = 0.0;
    } else if (rij_re == 0.0) {
      N[3].re = 0.0;
      N[3].im = theta / 2.3716;
    } else {
      N[3].re = rij_re / 2.3716;
      N[3].im = theta / 2.3716;
    }
    coder::b_exp(N[3]);
    ar = plast_re - psub.re;
    ai = plast_im - psub.im;
    snlay = plast_re + psub.re;
    rij_re = plast_im + psub.im;
    if (rij_re == 0.0) {
      if (ai == 0.0) {
        b_plast_re = ar / snlay;
        theta = 0.0;
      } else if (ar == 0.0) {
        b_plast_re = 0.0;
        theta = ai / snlay;
      } else {
        b_plast_re = ar / snlay;
        theta = ai / snlay;
      }
    } else if (snlay == 0.0) {
      if (ar == 0.0) {
        b_plast_re = ai / rij_re;
        theta = 0.0;
      } else if (ai == 0.0) {
        b_plast_re = 0.0;
        theta = -(ar / rij_re);
      } else {
        b_plast_re = ai / rij_re;
        theta = -(ar / rij_re);
      }
    } else {
      rough = std::abs(snlay);
      theta = std::abs(rij_re);
      if (rough > theta) {
        rij_im = rij_re / snlay;
        theta = snlay + rij_im * rij_re;
        b_plast_re = (ar + rij_im * ai) / theta;
        theta = (ai - rij_im * ar) / theta;
      } else if (theta == rough) {
        if (snlay > 0.0) {
          rij_im = 0.5;
        } else {
          rij_im = -0.5;
        }
        if (rij_re > 0.0) {
          theta = 0.5;
        } else {
          theta = -0.5;
        }
        b_plast_re = (ar * rij_im + ai * theta) / rough;
        theta = (ai * rij_im - ar * theta) / rough;
      } else {
        rij_im = snlay / rij_re;
        theta = rij_re + rij_im * snlay;
        b_plast_re = (rij_im * ar + ai) / theta;
        theta = (rij_im * ai - ar) / theta;
      }
    }
    rij_re = b_plast_re * N[3].re - theta * N[3].im;
    rij_im = b_plast_re * N[3].im + theta * N[3].re;
    N_tmp.re = blast_re * 0.0 - blast_im;
    N_tmp.im = blast_re + blast_im * 0.0;
    coder::b_exp(N_tmp);
    N[0] = N_tmp;
    N[3].re = -blast_re * 0.0 - (-blast_im);
    N[3].im = -blast_re + -blast_im * 0.0;
    coder::b_exp(N[3]);
    N[1].re = rij_re * N[3].re - rij_im * N[3].im;
    N[1].im = rij_re * N[3].im + rij_im * N[3].re;
    N[2].re = rij_re * N_tmp.re - rij_im * N_tmp.im;
    N[2].im = rij_re * N_tmp.im + rij_im * N_tmp.re;
    theta = MI[0].re;
    rij_im = MI[0].im;
    snlay = MI[1].re;
    rij_re = MI[1].im;
    rough = MI[2].re;
    b_plast_re = MI[2].im;
    c_plast_re = MI[3].re;
    ar = MI[3].im;
    for (int reploop{0}; reploop < 2; reploop++) {
      i1 = reploop << 1;
      N_tmp = N[i1];
      ai = theta * N_tmp.re - rij_im * N_tmp.im;
      b_ar = theta * N_tmp.im + rij_im * N_tmp.re;
      b_ai = snlay * N_tmp.re - rij_re * N_tmp.im;
      d = snlay * N_tmp.im + rij_re * N_tmp.re;
      N_tmp = N[i1 + 1];
      ai += rough * N_tmp.re - b_plast_re * N_tmp.im;
      MI[i1].re = ai;
      b_ar += rough * N_tmp.im + b_plast_re * N_tmp.re;
      MI[i1].im = b_ar;
      b_ai += c_plast_re * N_tmp.re - ar * N_tmp.im;
      MI[i1 + 1].re = b_ai;
      d += c_plast_re * N_tmp.im + ar * N_tmp.re;
      MI[i1 + 1].im = d;
    }
    rough = MI[1].re * MI[1].re - MI[1].im * -MI[1].im;
    b_plast_re = MI[1].re * -MI[1].im + MI[1].im * MI[1].re;
    rij_im = MI[0].re * MI[0].re - MI[0].im * -MI[0].im;
    snlay = MI[0].re * -MI[0].im + MI[0].im * MI[0].re;
    if (snlay == 0.0) {
      if (b_plast_re == 0.0) {
        psub.re = rough / rij_im;
        psub.im = 0.0;
      } else if (rough == 0.0) {
        psub.re = 0.0;
        psub.im = b_plast_re / rij_im;
      } else {
        psub.re = rough / rij_im;
        psub.im = b_plast_re / rij_im;
      }
    } else if (rij_im == 0.0) {
      if (rough == 0.0) {
        psub.re = b_plast_re / snlay;
        psub.im = 0.0;
      } else if (b_plast_re == 0.0) {
        psub.re = 0.0;
        psub.im = -(rough / snlay);
      } else {
        psub.re = b_plast_re / snlay;
        psub.im = -(rough / snlay);
      }
    } else {
      rij_re = std::abs(rij_im);
      theta = std::abs(snlay);
      if (rij_re > theta) {
        theta = snlay / rij_im;
        rij_im += theta * snlay;
        psub.re = (rough + theta * b_plast_re) / rij_im;
        psub.im = (b_plast_re - theta * rough) / rij_im;
      } else if (theta == rij_re) {
        if (rij_im > 0.0) {
          rij_im = 0.5;
        } else {
          rij_im = -0.5;
        }
        if (snlay > 0.0) {
          theta = 0.5;
        } else {
          theta = -0.5;
        }
        psub.re = (rough * rij_im + b_plast_re * theta) / rij_re;
        psub.im = (b_plast_re * rij_im - rough * theta) / rij_re;
      } else {
        theta = rij_im / snlay;
        rij_im = snlay + theta * rij_im;
        psub.re = (theta * rough + b_plast_re) / rij_im;
        psub.im = (theta * b_plast_re - rough) / rij_im;
      }
    }
    out[loop] = coder::b_abs(psub);
  }
}

// End of code generation (abeles_single.cpp)
