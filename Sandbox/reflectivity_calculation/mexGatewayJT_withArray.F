
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
      
C     Function Declarations      
      mwPointer mxCreateCellMatrix
      mwPointer mxGetCell
C      mwPointer mxSetCell
      mwPointer mxGetData
      mwPointer mxGetPr
      mwPointer mxGetNumberOfElements
      mwPointer mxCreateDoubleMatrix
      mwSize i, m, n
      integer*4 :: ComplexFlag = 0
      

C     Pointers Arrays and vars
      mwPointer numberOfCells
      mwPointer outputArray
      mwPointer inputArray
      mwPointer inputArray2
      mwPointer thisCell
      mwPointer thisValue
      mwPointer calcOutpArray
      mwPointer thisArray, thisArray2
      mwPointer size
      mwPointer pr_out, pr_in, pr_in2, pr_exp

    
      
C     Get the size of the input arrays..
      inputArray = prhs(1)
      numberOfCells = mxGetNumberOfElements(inputArray)
      inputArray2 = prhs(2)
      
C     input checking to be added here..        

      
C     Output cell array will have the same dimensions
      m = numberOfCells
      n = 1
c      outputArray = mxCreateCellMatrix(m,n)
      plhs(1) = mxCreateCellMatrix(m,n)
      
c     Loop over all the elements in the input array and call comp...     
      
      do 10 i=1,numberOfCells
          thisCell = mxGetCell(inputArray,i)
          m = mxGetNumberOfElements(thisCell)
          n = 1
          calcOutpArray = mxCreateDoubleMatrix(m,n,ComplexFlag)
          pr_in = mxGetPr(thisCell)
          pr_in2 = mxGetPr(inputArray2)
          pr_out = mxGetPr(calcOutpArray)
          call compute(%VAL(pr_out),%VAL(pr_in),%VAL(pr_in2),m,i) 
          call mxSetCell(plhs(1),i,calcOutpArray)
10    continue
      
c      pr_exp = mxGetPr(outputArray)
c      plhs(1) = mxCreateCellMatrix(
      
      return
      end 
    
    
    
C   -----------------------------------------------------------
      subroutine compute(outArray,inArray,inArray2,l,i)

      real*8 outArray(l,1), inArray(l,1), inArray2(l,1)
      real*8 n
    
      do 20 n=1,l
        outArray(n,1) = inArray(n,1)*inArray(n,1)
20    continue
    
      return
      end 
    
    
    
    
    
    
    
    