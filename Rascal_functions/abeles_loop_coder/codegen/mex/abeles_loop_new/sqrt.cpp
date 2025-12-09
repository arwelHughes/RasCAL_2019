//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// sqrt.cpp
//
// Code generation for function 'sqrt'
//

// Include files
#include "sqrt.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

// Function Definitions
namespace coder {
void b_sqrt(creal_T &x)
{
  real_T xi;
  real_T xr;
  real_T yi;
  real_T yr;
  xr = x.re;
  xi = x.im;
  if (xi == 0.0) {
    if (xr < 0.0) {
      yr = 0.0;
      yi = muDoubleScalarSqrt(-xr);
    } else {
      yr = muDoubleScalarSqrt(xr);
      yi = 0.0;
    }
  } else if (xr == 0.0) {
    if (xi < 0.0) {
      yr = muDoubleScalarSqrt(-xi / 2.0);
      yi = -yr;
    } else {
      yr = muDoubleScalarSqrt(xi / 2.0);
      yi = yr;
    }
  } else if (muDoubleScalarIsNaN(xr)) {
    yr = rtNaN;
    yi = rtNaN;
  } else if (muDoubleScalarIsNaN(xi)) {
    yr = rtNaN;
    yi = rtNaN;
  } else if (muDoubleScalarIsInf(xi)) {
    yr = muDoubleScalarAbs(xi);
    yi = xi;
  } else if (muDoubleScalarIsInf(xr)) {
    if (xr < 0.0) {
      yr = 0.0;
      yi = xi * -xr;
    } else {
      yr = xr;
      yi = 0.0;
    }
  } else {
    yr = muDoubleScalarAbs(xr);
    yi = muDoubleScalarAbs(xi);
    if ((yr > 4.4942328371557893E+307) || (yi > 4.4942328371557893E+307)) {
      yr *= 0.5;
      yi = muDoubleScalarHypot(yr, yi * 0.5);
      if (yi > yr) {
        yr = muDoubleScalarSqrt(yi) * muDoubleScalarSqrt(yr / yi + 1.0);
      } else {
        yr = muDoubleScalarSqrt(yi) * 1.4142135623730951;
      }
    } else {
      yr = muDoubleScalarSqrt((muDoubleScalarHypot(yr, yi) + yr) * 0.5);
    }
    if (xr > 0.0) {
      yi = 0.5 * (xi / yr);
    } else {
      if (xi < 0.0) {
        yi = -yr;
      } else {
        yi = yr;
      }
      yr = 0.5 * (xi / yi);
    }
  }
  x.re = yr;
  x.im = yi;
}

} // namespace coder

// End of code generation (sqrt.cpp)
