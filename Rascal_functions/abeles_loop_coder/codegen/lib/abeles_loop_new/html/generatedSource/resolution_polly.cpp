//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// resolution_polly.cpp
//
// Code generation for function 'resolution_polly'
//

// Include files
#include "resolution_polly.h"
#include "rt_nonfinite.h"
#include "coder_array.h"
#include <cmath>

// Function Definitions
void resolution_polly(const coder::array<double, 1U> &xdata,
                      const coder::array<double, 1U> &ydata, double res,
                      double points, coder::array<double, 1U> &out)
{
  int loop_ub;
  //  Apply resolution correction
  res += 0.0001;
  loop_ub = static_cast<int>(points);
  out.set_size(static_cast<int>(points));
  for (int j{0}; j < loop_ub; j++) {
    out[j] = 0.0;
  }
  for (int j{0}; j < loop_ub; j++) {
    double g;
    double sumg;
    int i;
    int ilow;
    sumg = 0.0;
    out[j] = 0.0;
    if (static_cast<unsigned int>(j) + 1U > 10U) {
      ilow = -10;
    } else {
      ilow = -j;
    }
    //     try
    if (static_cast<double>(j) + 1.0 < points - 10.0) {
      g = 10.0;
    } else {
      g = points - (static_cast<double>(j) + 1.0);
    }
    i = static_cast<int>(g + (1.0 - static_cast<double>(ilow)));
    for (int b_i{0}; b_i < i; b_i++) {
      int a_tmp;
      a_tmp = (j + ilow) + b_i;
      g = (xdata[a_tmp] - xdata[j]) / (res * xdata[j]);
      g = std::exp(-(g * g));
      sumg += g;
      out[j] = out[j] + ydata[a_tmp] * g;
    }
    if (sumg != 0.0) {
      out[j] = out[j] / sumg;
    }
  }
}

// End of code generation (resolution_polly.cpp)
