#include "fintrf.h"
C-------------------------------------------------------------------------------
C     Test program that inputs cell array of double arrays, squares each element
C     then outputs the results in a new cell array
C--------------------------------------------------------------------------------
        subroutine mexFunction(nlhs, plhs, nrhs, prhs)


C     Declarations
      implicit none

C     Mex function arguments      
      mwPointer plhs(*), prhs(*), dat
      integer nlhs, nrhs
      integer*4 :: complexFlag = 0

C     Function Declarations      
      mwPointer mxCreateCellMatrix
      mwPointer mxCreateDoubleMatrix
      mwPointer mxGetCell
      mwPointer mxSetCell
      mwPointer mxGetData
      mwPointer mxGetPr
      mwPointer mxGetNumberOfElements


C     Pointers Arrays and vars
      mwPointer numberOfCells
      mwPointer outputArray
      mwPointer inputArray
      mwPointer thisCell
      mwPointer calcOutpArray
      mwPointer size      
      mwPointer pr_in
      mwPointer pr_out
      mwSize i, m, n

C     input checking to be added..      

C     Get the size of the input array..
      inputArray = prhs(1)
      numberOfCells = mxGetNumberOfElements(inputArray)

C     Output cell array will have the same dimensions
      m = numberOfCells
      n = 1
      outputArray = mxCreateCellMatrix(m,n)

c     Loop over all the elements in the input array and call comp...     
        do i=1,numberOfCells
            thisCell = mxGetCell(inputArray,i)
            m = mxGetNumberOfElements(thisCell)
            n = 1
            calcOutpArray = mxCreateDoubleMatrix(m,n,ComplexFlag)
            pr_in = mxGetPr(thisCell)
            pr_out = mxGetPr(calcOutpArray)
            call compute(%VAL(pr_out),%VAL(pr_in),m)
            call mxSetCell(outputArray,i,calcOutpArray)
        enddo

        plhs(1) = outputArray
        return
        end 
C   -----------------------------------------------------------
      subroutine compute(outArray,inArray,l)
        real*8 outArray(l,1), inArray(l,1)
        integer*8 n
        do 20 n=1,l
          outArray(n,1) = inArray(n,1)*inArray(n,1)
  20    continue
        return
        end