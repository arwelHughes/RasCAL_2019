function chi2 = chi_squared(fit,y,P,eb,roiMask)
%chi_squared(func,data,numparams,errors)


% returns *reduced* chi^2 value for use in data modelling
% "y" is a vector of data, "fit" is a vector of model values (size(fit)=size(y)), P is the number of
% parameters fit in the model, and eb is a vector of error bars (1-to-1 correspondnce with y)
% Ref: John R. Taylor, "An Introduction to Error Analysis", (2nd ed., 1997)
% 11/11/01 Mike Scarpulla.  Please direct questions or comments to scarps@uclink.berkeley.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<3
    error('Wrong number of arguments passed to "chi_squared"')
end

% if error bars are not availible, evaluate chi^2 by normalizing deviation^2 by magnitude of data.
% This assumes that the STDEV of a value scales as SQRT(value).  USE WITH THIS CAVEAT IN MIND
if nargin==3 | ~all(eb)
    N = max(size(y));
    terms = ((y-fit).^2)./abs(y);
    terms(isinf(terms)) = 0;
    terms(isnan(terms)) = 0;
    chi2 = 1/(N-P)*sum(terms);
%if error bars are availible, normalize the deviation to the expectred error
else
   N = max(size(y));
   if N <= P
      N = (P + 1);
   end
  	 terms = ((y-fit)./eb).^2;
     n = find(terms == Inf);
     terms(n) = 0;
     %debug
%      try
%         terms = terms .* roiMask;
%      catch
%          disp('Oops! Whats this??');
%      end
     chi2 = 1/(N-P)*sum(terms);
end
