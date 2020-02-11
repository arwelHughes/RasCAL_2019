
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
      mwPointer numberOfContrasts
      mwPointer outputArray
      mwPointer xDataCellArray
      mwPointer sldCellArray
      mwPointer nbairsArray
      mwPointer nbsubsArray
      mwPointer thisXdata
      mwPointer thisSLD
      mwPointer thisValue
      mwPointer calcOutpArray
      mwPointer thisArray, thisArray2
      mwPointer size
      mwPointer pr_out, pr_in_xdata, pr_in_sld, pr_in_nbairs, pr_exp
      mwPointer pr_in_nbsubs
      
C     Get the size of the input arrays..
      xDataCellArray = prhs(1)
      numberOfContrasts = mxGetNumberOfElements(xDataCellArray)
      
      sldCellArray = prhs(2)
    
      nbairsArray = prhs(3)
      nbsubsArray = prhs(4)
      
C     input checking to be added here..        

      
C     Output cell array will have the same dimensions
      m = numberOfContrasts
      n = 1
c      outputArray = mxCreateCellMatrix(m,n)
      plhs(1) = mxCreateCellMatrix(m,n)
      
c     Loop over all the elements in the input array and call comp...     
      
      do 10 i=1,numberOfContrasts
          thisXData = mxGetCell(XDataCellArray,i)
          m = mxGetNumberOfElements(thisXData)
          n = 1
          calcOutpArray = mxCreateDoubleMatrix(m,n,ComplexFlag)
          pr_out = mxGetPr(calcOutpArray)
          
          thisSLD = mxGetCell(sldCellArray,i)
        
          pr_in_xdata = mxGetPr(thisXData)
          pr_in_sld = mxGetPr(thisSLD)
          pr_in_nbairs = mxGetPr(nbairsArray)
          pr_in_nbsubs = mxGetPr(nbsubsarray);

          call compute(%VAL(pr_out),%VAL(pr_in_xdata),%VAL(pr_in_sld),
     +    %VAL(pr_in_nbairs),m,i) 
          call mxSetCell(plhs(1),i,calcOutpArray)
10    continue
      
c      pr_exp = mxGetPr(outputArray)
c      plhs(1) = mxCreateCellMatrix(
      
      return
      end 
    
    
    
C   -----------------------------------------------------------
      subroutine compute(outArray,inArray,inArray2,inArray3,l,i)

      real*8 outArray(l,1), inArray(l,1), inArray2(l,3), inArray3(l,1)
      integer*8 n
    
      do 20 n=1,l
        outArray(n,1) = inArray(n,1)*inArray(n,1)
20    continue
    
      return
      end 
    
    
    
    
    
    
    
    