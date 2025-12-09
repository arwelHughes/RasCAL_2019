//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// abs.cpp
//
// Code generation for function 'abs'
//

// Include files
#include "abs.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
namespace coder {
double b_abs(const creal_T x)
{
  double b;
  double y;
  y = std::abs(x.re);
  b = std::abs(x.im);
  if (y < b) {
    y /= b;
    y = b * std::sqrt(y * y + 1.0);
  } else if (y > b) {
    b /= y;
    y *= std::sqrt(b * b + 1.0);
  } else if (std::isnan(b)) {
    y = rtNaN;
  } else {
    y *= 1.4142135623730951;
  }
  return y;
}

} // namespace coder

// End of code generation (abs.cpp)
