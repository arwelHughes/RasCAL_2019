/*
 * Non-Degree Granting Education License -- for use at non-degree
 * granting, nonprofit, educational organizations only. Not for
 * government, commercial, or other organizational use.
 *
 * rtGetInf.c
 *
 * Code generation for function 'callParatt'
 *
 */

/*
 * Abstract:
 *       MATLAB for code generation function to initialize non-finite, Inf and MinusInf
 */
#include "rtGetInf.h"

/* Function: rtGetInf ==================================================
 * Abstract:
 * Initialize rtInf needed by the generated code.
 */
real_T rtGetInf(void)
{
  return rtInf;
}

/* Function: rtGetInfF ==================================================
 * Abstract:
 * Initialize rtInfF needed by the generated code.
 */
real32_T rtGetInfF(void)
{
  return rtInfF;
}

/* Function: rtGetMinusInf ==================================================
 * Abstract:
 * Initialize rtMinusInf needed by the generated code.
 */
real_T rtGetMinusInf(void)
{
  return rtMinusInf;
}

/* Function: rtGetMinusInfF ==================================================
 * Abstract:
 * Initialize rtMinusInfF needed by the generated code.
 */
real32_T rtGetMinusInfF(void)
{
  return rtMinusInfF;
}

/* End of code generation (rtGetInf.c) */