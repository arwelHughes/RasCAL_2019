//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// exp.cpp
//
// Code generation for function 'exp'
//

// Include files
#include "exp.h"
#include "rt_nonfinite.h"
#include <cmath>

// Function Definitions
namespace coder {
void b_exp(creal_T &x)
{
  if (x.re == 0.0) {
    double r;
    r = x.im;
    x.re = std::cos(r);
    x.im = std::sin(r);
  } else if (x.im == 0.0) {
    x.re = std::exp(x.re);
    x.im = 0.0;
  } else if (std::isinf(x.im) && std::isinf(x.re) && (x.re < 0.0)) {
    x.re = 0.0;
    x.im = 0.0;
  } else {
    double d;
    double r;
    r = std::exp(x.re / 2.0);
    d = x.im;
    x.re = r * (r * std::cos(d));
    x.im = r * (r * std::sin(d));
  }
}

} // namespace coder

// End of code generation (exp.cpp)
