//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, educational organizations only. Not for
// government, commercial, or other organizational use.
//
// abeles_loop_new.h
//
// Code generation for function 'abeles_loop_new'
//

#ifndef ABELES_LOOP_NEW_H
#define ABELES_LOOP_NEW_H

// Include files
#include "abeles_loop_new_types.h"
#include "rtwtypes.h"
#include "coder_array.h"
#include <cstddef>
#include <cstdlib>

// Function Declarations
extern void abeles_loop_new(const coder::array<cell_wrap_0, 1U> &simXdata,
                            const coder::array<cell_wrap_1, 1U> &slds,
                            const coder::array<double, 1U> &nbairs,
                            const coder::array<double, 1U> &nbsubs,
                            const coder::array<double, 1U> &repeats,
                            const coder::array<double, 1U> &resolutions,
                            const coder::array<double, 1U> &ssubs,
                            coder::array<cell_wrap_0, 1U> &simRef);

#endif
// End of code generation (abeles_loop_new.h)
