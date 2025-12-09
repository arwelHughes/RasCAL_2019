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
#include "hypot.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
namespace coder {
void b_sqrt(creal_T &x)
{
  double xi;
  double xr;
  double yi;
  double yr;
  xr = x.re;
  xi = x.im;
  if (xi == 0.0) {
    if (xr < 0.0) {
      yr = 0.0;
      yi = std::sqrt(-xr);
    } else {
      yr = std::sqrt(xr);
      yi = 0.0;
    }
  } else if (xr == 0.0) {
    if (xi < 0.0) {
      yr = std::sqrt(-xi / 2.0);
      yi = -yr;
    } else {
      yr = std::sqrt(xi / 2.0);
      yi = yr;
    }
  } else if (std::isnan(xr)) {
    yr = rtNaN;
    yi = rtNaN;
  } else if (std::isnan(xi)) {
    yr = rtNaN;
    yi = rtNaN;
  } else if (std::isinf(xi)) {
    yr = std::abs(xi);
    yi = xi;
  } else if (std::isinf(xr)) {
    if (xr < 0.0) {
      yr = 0.0;
      yi = xi * -xr;
    } else {
      yr = xr;
      yi = 0.0;
    }
  } else {
    yr = std::abs(xr);
    yi = std::abs(xi);
    if ((yr > 4.4942328371557893E+307) || (yi > 4.4942328371557893E+307)) {
      yr *= 0.5;
      yi *= 0.5;
      yi = internal::scalar::b_hypot(yr, yi);
      if (yi > yr) {
        yr = std::sqrt(yi) * std::sqrt(yr / yi + 1.0);
      } else {
        yr = std::sqrt(yi) * 1.4142135623730951;
      }
    } else {
      yr = std::sqrt((internal::scalar::b_hypot(yr, yi) + yr) * 0.5);
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
