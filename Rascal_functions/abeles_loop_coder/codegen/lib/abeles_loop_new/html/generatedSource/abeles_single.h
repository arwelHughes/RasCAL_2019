//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// abeles_single.h
//
// Code generation for function 'abeles_single'
//

#ifndef ABELES_SINGLE_H
#define ABELES_SINGLE_H

// Include files
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
void abeles_single(const coder::array<double, 1U> &x,
                   const coder::array<double, 2U> &sld, double nbair,
                   double nbsub, double nrepeats, double rsub, double layers,
                   double points, coder::array<double, 1U> &out);

#endif
// End of code generation (abeles_single.h)
