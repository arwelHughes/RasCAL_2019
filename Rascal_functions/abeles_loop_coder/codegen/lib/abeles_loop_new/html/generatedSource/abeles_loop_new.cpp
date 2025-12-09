//
// Non-Degree Granting Education License -- for use at non-degree
// granting, nonprofit, education, and research organizations only. Not
// for commercial or industrial use.
//
// abeles_loop_new.cpp
//
// Code generation for function 'abeles_loop_new'
//

// Include files
#include "abeles_loop_new.h"
#include "abeles_loop_new_types.h"
#include "abeles_single.h"
#include "resolution_polly.h"
#include "rt_nonfinite.h"
#include "coder_array.h"

// Function Definitions
void abeles_loop_new(const coder::array<cell_wrap_0, 1U> &simXdata,
                     const coder::array<cell_wrap_1, 1U> &slds,
                     const coder::array<double, 1U> &nbairs,
                     const coder::array<double, 1U> &nbsubs,
                     const coder::array<double, 1U> &repeats,
                     const coder::array<double, 1U> &resolutions,
                     const coder::array<double, 1U> &ssubs,
                     coder::array<cell_wrap_0, 1U> &simRef)
{
  coder::array<double, 1U> ref;
  int i;
  i = simXdata.size(0);
  simRef.set_size(simXdata.size(0));
  for (int b_i{0}; b_i < i; b_i++) {
    int ref_tmp;
    ref_tmp = simXdata[b_i].f1.size(0);
    abeles_single(simXdata[b_i].f1, slds[b_i].f1, nbairs[b_i], nbsubs[b_i],
                  repeats[b_i], ssubs[b_i],
                  static_cast<double>(slds[b_i].f1.size(0)),
                  static_cast<double>(ref_tmp), ref);
    resolution_polly(simXdata[b_i].f1, ref, resolutions[b_i],
                     static_cast<double>(ref_tmp), simRef[b_i].f1);
  }
}

// End of code generation (abeles_loop_new.cpp)
