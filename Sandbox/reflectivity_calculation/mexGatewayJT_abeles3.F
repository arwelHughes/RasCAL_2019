
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
     +    %VAL(pr_in_resol),%VAL(pr_in_sLast),l,m,i,numberOfContrasts) 
          call mxSetCell(plhs(1),i,calcOutpArray)
10    continue
      
c      pr_exp = mxGetPr(outputArray)
c      plhs(1) = mxCreateCellMatrix(
      
      return
      end 
    
C   -----------------------------------------------------------
c     subroutine abeles(outArray,inXArray,inSldArray,
c     + inNbaArray,inNbsArray,inRepArray,inResArray,
c     + inSLastArray,p,i,l,c)
      
      subroutine abeles(out,x,sld,nbairs,nbsubs,nrepeatss,resols,ssubs,
     +   layers,points,thisCont,numCont)

      integer size, i, numCont, thisCont
	  integer layers,points,j,reploop, loop, nl
	  double complex c0 , c1 , ci , beta , rij , N , M , MI , rimaj
	  double complex blast , num , den , quo
	  double complex pimag , pair , psub , plast
	  real*8 pi , twopi , lam , nrepeats, ilow, ihi
	  real*8 thick , q , theta, rho, rough, resol
	  real*8 preal , snair , snsub , snlay, rfac, resType
	  real*8 out(points,1),x(points,1),sld(layers,3),nbair,nbsub,ssub
	  real*8 dummydata(points,1), g(points,1)
      real*8 nbairs(numCont,1), nbsubs(numCont,1),ssubs(numCont,1)
      real*8 nrepeatss(numCont,1),resols(numCont,1)
	  dimension N(2,2) , M(2,2) , MI(2,2)
	
 	  nbair = nbairs(thisCont,1)
      nbsub = nbsubs(thisCont,1)
      ssub = ssubs(thisCont,1)
      nrepeats = nrepeatss(thisCont,1)
      resol = resols(thisCont,1)
 
c      nbair = 6.3e-6
c      nbsub = 2.073e-6
c      ssub = 1
c      nrepeats = 1
c      resol = 0.01
      
	c0 = Dcmplx(0 , 0)
	c1 = Dcmplx(1 , 0)
	ci = Dcmplx(0 , 1)
	lam = 4.5
	pi = 3.141592653589
	rfac = ((4*pi)*(4*pi))/2
	twopi = 2*pi
	snair = (1.0 - dble(nbair*((lam*lam) / twopi)))
	snsub = (1.0 - dble(nbsub*((lam*lam) / twopi)))
	do loop = 1 , points
	    q = x(loop,1)
	    theta = asin(q*lam / (4*pi))
	    preal = ((snsub)*(snsub)) - ((snair)*(snair))*(cos(theta)**2)
	    psub = cdsqrt(preal*c1)
	    pair = snair*sin(theta)*c1
	    plast = pair
	    blast = 0.0
		rlast = sld(1,3)
	    MI(1 , 1) = c1
	    MI(2 , 2) = c1
	    MI(1 , 2) = c0
	    MI(2 , 1) = c0
		do reploop = 1, nrepeats
	    do nl = 1 , layers
			thick = sld(nl,1)
			rho = sld(nl,2)
			rough = sld(nl,3)
			snlay = (1 - dble(rho*((lam*lam) / twopi)))
			preal = (snlay*snlay) - (snair*snair) *cos(theta)**2
			pimag = cdsqrt(preal*c1)
			beta = (twopi / lam)*thick*pimag
			rij = dcmplx(plast - pimag) / dcmplx(plast + pimag)
			rij = rij * cdexp(-rfac*plast*pimag*(rough*rough)/(lam*lam)) 
			N(1 , 1) = cdexp(blast*ci)
			N(2 , 1) = rij * cdexp( - blast*ci)
			N(2 , 2) = cdexp( - blast*ci)
			N(1 , 2) = rij * cdexp(blast*ci)
			plast = pimag
			blast = beta
			rlast = rough
			call mcopy(MI , M)
			call mmult(M , N , MI)
	    end do
		end do
	    rij = (dcmplx(plast - psub)) / (dcmplx(plast + psub))
		rij = rij * cdexp(-rfac*plast*psub*(ssub*ssub)/(lam*lam)) 
	    N(1 , 1) = cdexp(blast*ci)
	    N(2 , 1) = rij*cdexp( - blast*ci)
	    N(2 , 2) = cdexp( - blast*ci)
	    N(1 , 2) = rij*cdexp(blast*ci)
	    call mcopy(MI , M)
	    call mmult(M , N , MI)
	    num = MI(2 , 1)*dconjg(MI(2 , 1))
	    den = MI(1 , 1)*dconjg(MI(1 , 1))
	    call cdiv(num , den , quo)
	    out(loop,1) = real(quo)
	end do

C	Do the resolution smearing


      call resolution_polly(out,x,out,out,resol,points)
			
	return
	end subroutine

c============================================================
c
c		Subroutine for resolution smearing..mulf version
c
c
c===========================================================
	subroutine resolution_mulf(out,xdata,ydata,dummyref,res,points)

	real*8 res,width,pi,numer,denom,Kval
	integer points,j,res_int,ilow,ihi,i,k
	real*8 xdata(points,1)
	real*8 ydata(points,1)
	real*8 out(points,1)
	real*8 dQbyQ,dQk,thisSumNumer,thisSumDenom
		

	pi = 3.141592653589793
	dQbyQ = res
	


	do k = 1 , points-1
		dQk = dQbyQ * xdata(k,1)
		width = dQk/2.35

		thisSumNumer = 0.0
		thisSumDenom = 0.0

		do j = 1,points-1
			numer = 1/(width * (sqrt(2*pi)))
			e_part = (xdata(k,1)-xdata(j,1))*(xdata(k,1)-xdata(j,1))
			e_part = e_part /(width*width)
			Kval = numer * exp(-(0.5*e_part))
			thisSumNumer = thisSumNumer + Kval * ydata(j,1)
			thisSumDenom = thisSumDenom + Kval
		end do
		out(k,1) = thisSumNumer / thisSumDenom
	end do

	out(points,1) = ydata(points,1)

	end subroutine

c============================================================
c
c		Subroutine for resolution smearing..polly version
c
c
c===========================================================


	subroutine resolution_polly(out,xdata,ydata,dummyref,res,points)

	real*8 res
	integer points,j,res_int,ilow,ihi,i
	real*8 xdata(points,1)
	real*8 ydata(points,1)
	real*8 dummyref(points,1)
	real*8 dummyydata(points,1)
	real*8 out(points,1)
	real*8 g,sumg

	res = res + 0.0001
	res_int = 10
	
	do j = 1,points
		sumg = 0
		dummyydata(j,1) = 0

		if (j .gt. 10) then
			ilow = -10
		else
			ilow = -j + 1
		endif

		if (j .lt. (points - 10)) then
			ihi = 10
		else
			ihi = points - j
		endif
		
		do i = ilow,ihi
		  g = exp(-1*((xdata(j+i,1)-xdata(j,1))/(res*xdata(j,1)))**2)
		  sumg = sumg + g
		  dummyydata(j,1) = dummyydata(j,1) + dummyref(i+j,1) * g
		end do
		if (sumg .ne. 0) then
			dummyydata(j,1) = dummyydata(j,1) / sumg
		endif
	end do

	out = dummyydata

	end subroutine



	! ----- -----------------------------
	SUBROUTINE CDIV(NUM , DEN , QUO)
	! SUBROUTINE TO DIVIDE COMPLEX NUMBERS
	! AND TRAP DIVIDE CHECKS
	double COMPLEX NUM , DEN , QUO , C1 , C0
	C1 = DCMPLX(1.0 , 0.0)
	C0 = DCMPLX(0.0 , 0.0)
	IF(DEN.EQ.NUM)THEN
	    QUO = C1
	    RETURN
	ENDIF
	IF(DEN.EQ.C0 )THEN
	    QUO = C0
	    RETURN
	ENDIF
	QUO = NUM / DEN
	RETURN
	END SUBROUTINE
	! ----- -------------------------------------------
	SUBROUTINE MMULT(A1 , A2 , A3)
	! SUBROUTINE FOR MATRIX MUTIPLICATION
	DOUBLE COMPLEX A1(2 , 2) , A2(2 , 2) , A3(2 , 2)
	A3(1 , 1) = A1(1 , 1)*A2(1 , 1) + A1(1 , 2)*A2(2 , 1)
	A3(1 , 2) = A1(1 , 1)*A2(1 , 2) + A1(1 , 2)*A2(2 , 2)
	A3(2 , 1) = A1(2 , 1)*A2(1 , 1) + A1(2 , 2)*A2(2 , 1)
	A3(2 , 2) = A1(2 , 1)*A2(1 , 2) + A1(2 , 2)*A2(2 , 2)
	RETURN
	END
	SUBROUTINE MCOPY(A1 , A2)
	! SUBROUTINE TO COPY A MATRIX
	DOUBLE COMPLEX A1(2 , 2) , A2(2 , 2)
	A2(1 , 1) = A1(1 , 1)
	A2(1 , 2) = A1(1 , 2)
	A2(2 , 1) = A1(2 , 1)
	A2(2 , 2) = A1(2 , 2)
	RETURN
	END	SUBROUTINE
   
      
    
    
    
    
    
    
    
    
    