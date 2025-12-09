//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// hypot.cpp
//
// Code generation for function 'hypot'
//

// Include files
#include "hypot.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
namespace coder {
namespace internal {
namespace scalar {
double b_hypot(double x, double y)
{
  double b;
  double z;
  z = std::abs(x);
  b = std::abs(y);
  if (z < b) {
    z /= b;
    z = b * std::sqrt(z * z + 1.0);
  } else if (z > b) {
    b /= z;
    z *= std::sqrt(b * b + 1.0);
  } else if (std::isnan(b)) {
    z = rtNaN;
  } else {
    z *= 1.4142135623730951;
  }
  return z;
}

} // namespace scalar
} // namespace internal
} // namespace coder

// End of code generation (hypot.cpp)
