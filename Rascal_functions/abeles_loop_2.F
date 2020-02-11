
#include "fintrf.h"

C-------------------------------------------------------------------------------
C     
C         Abeles Calculation for Rascal 2.0
C     
C--------------------------------------------------------------------------------

      subroutine mexFunction(nlhs, plhs, nrhs, prhs)
      
      use omp_lib
      
C     Declarations
      implicit none
      
      
C     Mex function arguments      
      mwPointer plhs(*), prhs(*), dat
      integer nlhs, nrhs 
      
C     Function Declarations      
      mwPointer mxCreateCellMatrix
      mwPointer mxGetCell
      mwPointer mxGetData
      mwPointer mxGetPr
      mwPointer mxGetNumberOfElements
      mwPointer mxCreateDoubleMatrix
      mwPointer mxGetM, mxGetN
      mwPointer mxDuplicatearray
      mwSize i, m, n
      integer*4 :: ComplexFlag = 0
      integer*4 :: layers, points
      real*8 :: test(1,1)

C     Pointers Arrays and vars
      mwPointer numberOfContrasts
      mwPointer outputArray
      mwPointer inputArray_xdat, inputArray_sld, inputArray_nbair
      mwPointer inputArray_nbsub, inputArray_ssub, inputArray_rep
      mwPointer inputarray_resol
      mwPointer thisCell_xdat, thisCell_sld
      mwPointer calcOutpArray
      mwPointer thisArray, thisArray2
      mwPointer size
      mwPointer pr_out, pr_in_xdata
      mwPointer pr_in_sld, pr_in_nbair, pr_in_nbsub
      mwPointer pr_in_rep, pr_in_resol, pr_in_ssub
      
      
C     input checking...
      if(nrhs .lt. 7) then
         call mexErrMsgTxt('7 inputs required to Abeles.')
      endif
      if(nlhs .gt. 1) then
         call mexErrMsgTxt('One output required from Abeles.')
      endif
      
C     Get the number of conts from size of the xdata cell array..
      inputArray_xdat = prhs(1)
      numberOfContrasts = mxGetNumberOfElements(inputArray_xdat)
      inputArray_sld = prhs(2)
      inputArray_nbair = prhs(3)
      inputArray_nbsub = prhs(4)
      inputArray_rep = prhs(5)
      inputArray_resol = prhs(6)
      inputArray_ssub = prhs(7)
      
      pr_in_nbair = mxGetPr(inputArray_nbair)
      pr_in_nbsub = mxGetPr(inputArray_nbsub)
      pr_in_rep = mxGetPr(inputArray_rep)
      pr_in_resol = mxGetPr(inputArray_resol)
      pr_in_ssub = mxGetPr(inputArray_ssub)
      
C     Output cell array will have the same number of contrasts
      m = numberOfContrasts
      n = 1
      plhs(1) = mxCreateCellMatrix(m,n)
      outputArray = mxCreateCellMatrix(m,n)
      
c     Fill the output array with double arrays of correct size
      n = 1
      do i=1,numberOfContrasts
          thisCell_xdat = mxGetCell(inputArray_xdat,i)
          points = mxGetN(thisCell_xdat)
          calcOutpArray = mxCreateDoubleMatrix(points,n,ComplexFlag)
          call mxSetCell(outputArray,i,calcOutpArray)    
      end do
      
c     Loop over all the elements in the input array and call comp...  
      !$OMP PARALLEL 
      !$OMP DO      
      do i=1,numberOfContrasts
          
c         Pointers for input variables          
          thisCell_xdat = mxGetCell(inputArray_xdat,i)
          points = mxGetN(thisCell_xdat)
          pr_in_xdata = mxGetPr(thisCell_xdat)
          
          thisCell_sld = mxGetCell(inputArray_sld,i)
          layers = mxGetM(thisCell_sld)
          pr_in_sld = mxGetPr(thisCell_sld)
          
c         Get the array for output from calcfn          
          calcOutpArray = mxGetCell(outputArray,i)
          pr_out = mxGetPr(calcOutpArray)    
          
          call abeles(%VAL(pr_out),%VAL(pr_in_xdata),%VAL(pr_in_sld),
     +    %VAL(pr_in_nbair),%VAL(pr_in_nbsub),%VAL(pr_in_rep),
     +     %VAL(pr_in_resol),%VAL(pr_in_ssub),
     +    layers,points,i,numberOfContrasts)        
          
c          call mxSetCell(outputArray,i,calcOutpArray)
10    end do
      !$OMP END DO
      !$OMP END PARALLEL
      
      plhs(1) = mxDuplicatearray(outputArray)
      
      return
      end 
    
    
    
      
C=========================================================================
c
C				computational routine.....
C
C=========================================================================

c     subroutine abeles(out,x,sld,nbairs,nbsubs,nrepeatss,
c     + resols,ssubs,numCont,points,layers,thisCont)
      
      subroutine abeles(out,x,sld,nbairs,nbsubs,nrepeatss,resols,ssubs,
     +   layers,points,thisCont,numCont)

      integer size, i, numCont, thisCont
	integer layers,points,j,reploop
	double complex c0 , c1 , ci , beta , rij , N , M , MI , rimaj
	double complex blast , num , den , quo
	double complex pimag , pair , psub , plast
	real*8 pi , twopi , loop , nl , lam , nrepeats, ilow, ihi
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
	integer points,j,res_int,ilow,ihi,i
	real*8 xdata(points,1)
	real*8 ydata(points,1)
	real*8 out(points,1)
	real*8 dQbyQ,dQk,k,thisSumNumer,thisSumDenom
		

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
   
      
    
    