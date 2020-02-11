
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
      mwPointer mxGetM
      mwSize i, m, n, l
      integer*4 :: ComplexFlag = 0
      
C     Pointers Arrays and vars
      mwPointer numberOfContrasts
      mwPointer outputArray
      mwPointer xDataCellArray
      mwPointer sldCellArray
      mwPointer nbairsArray
      mwPointer nbsubsArray
      mwPointer repeatsArray
      mwPointer resolArray
      mwPointer sLastArray
      mwPointer thisXdata
      mwPointer thisSLD
      mwPointer thisValue
      mwPointer calcOutpArray
      mwPointer thisArray, thisArray2
      mwPointer size
      mwPointer pr_out, pr_in_xdata, pr_in_sld, pr_in_nbairs, pr_exp
      mwPointer pr_in_nbsubs, pr_in_repeats, pr_in_resol, pr_in_sLast
      
C     Get the size of the input arrays..
      xDataCellArray = prhs(1)
      numberOfContrasts = mxGetNumberOfElements(xDataCellArray)
      
      sldCellArray = prhs(2)
    
      nbairsArray = prhs(3)
      nbsubsArray = prhs(4)
      repeatsArray = prhs(5)
      resolArray = prhs(6)
      sLastArray = prhs(7)
      
C     input checking to be added here..        

      
C     Output cell array will have the same dimensions
      m = numberOfContrasts
      n = 1
c      outputArray = mxCreateCellMatrix(m,n)
      plhs(1) = mxCreateCellMatrix(m,n)
      
c     Loop over all the elements in the input array and call comp...     
      
      do 10 i=1,numberOfContrasts
          thisXData = mxGetCell(XDataCellArray,i)
          m = mxGetM(thisXData)
          n = 1
          calcOutpArray = mxCreateDoubleMatrix(m,n,ComplexFlag)
          pr_out = mxGetPr(calcOutpArray)
          
          thisSLD = mxGetCell(sldCellArray,i)
          l = mxGetM(thisSLD)
        
          pr_in_xdata = mxGetPr(thisXData)
          pr_in_sld = mxGetPr(thisSLD)
          pr_in_nbairs = mxGetPr(nbairsArray)
          pr_in_nbsubs = mxGetPr(nbsubsarray)
          pr_in_repeats = mxGetPr(repeatsArray)
          pr_in_resol = mxGetPr(resolArray)
          pr_in_sLast = mxGetPr(sLastArray)

c         m = points; l = layers; i = whichContrast; 

          call abeles(%VAL(pr_out),%VAL(pr_in_xdata),%VAL(pr_in_sld),
     +    %VAL(pr_in_nbairs),%VAL(pr_in_nbsubs),%VAL(pr_in_repeats),
     +    %VAL(pr_in_resol),%VAL(pr_in_sLast),m,i,l,numberOfContrasts) 
          call mxSetCell(plhs(1),i,calcOutpArray)
10    continue
      
c      pr_exp = mxGetPr(outputArray)
c      plhs(1) = mxCreateCellMatrix(
      
      return
      end 
    
C   -----------------------------------------------------------
      subroutine abeles(outArray,inXArray,inSldArray,
     + inNbaArray,inNbsArray,inRepArray,inResArray,
     + inSLastArray,p,i,l,c)
      



      mwSize p, i, l, c
      real*8 outArray(p,1), inXArray(p,1), inSldArray(l,3)
      real*8 inNbsArray(c,1), inNbaArray(c,1), inRepArray(c,1)
      real*8 inResArray(c,1), inSLastArray(c,1)

      integer*8 n
    
      do 20 n=1,p
        outArray(n,1) = inXArray(n,1)*c
20    continue
    
      return
      end 
    
    
    
    
    
    
    
    