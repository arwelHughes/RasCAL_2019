function varargout = adaptive(input_func, initialDomain, varargin)
%% adaptive: evaluates a matlab function on a given range
%
% 'adaptive.m' allows to sample a function using a reduced number of
% points. It works iteratively adding new points where needed.
% It is especially useful for functions which are computationally intensive
% (e.g. involve solving a differential equation).
%
% Usage:
% XY = adaptive(func, [xstart, xend])
%  evaluates 'func' in the range [xstart, xend]. Key-value arguments are
%  used to control the function evaluation. If the function 'func' returns
%  multiple output values, only the first one is used for the refinement
%  process, but all of them are calculated and returned as additional
%  columns in the output matrix. The output matrix XY contains the new
%  domain points in the first column and the output values in the other
%  columns.
% [x,yy] = adaptive(func, [xstart, xend])
%   as before but separately returns the array with the domain points and
%   the array/matrix with the function output values.
% [x,yy] = adaptive(func, xarray, ...)
%   as before but explicitly provide an initial array of domain points.
%
% Methods:
%   'adaptive' provides three methods for refining the function evaluation:
%   1) add more points near the sharp corners, which are found by
%    considering the triangles formed by three successive points and
%    measuring the central angle.
%   2) measure the area of the same triangles and add more points when the
%    area is bigger than a threshold.
%   3) measure the length of the segments formed by pairs of successive
%    and split the segments which are longer than a threshold.
%   If no methods is explicitly specified, the 'angle' method is used.
%
%% Input parameters
%  - func: input function (function handle)
%  - initialDomain: initial domain points (1D array)
%
%% Optional key-value input parameters
%  - 'nPoints': (default 20)
%       initial number of domain points, only used if an initial domain
%       array is not excplitely provided.
%  - 'maxRefinements': (default 10)
%       Specifies the maximum number of refinement steps.
%  - 'minAngle': (default 0.8*pi)
%       Refine near the  points which forms, together with their left and right
%       neighbours, a triangle with central angle smaller than a given value.
%  - 'maxArea': (default 5e-4)
%       Refine near the points which forms, together with their left and right
%       neighbours, a triangle with area larger than a threshold. The threshold
%       in normalized to the area enclosing th graph:
%       threshold==maxArea*(max(x)-min(x))*(max(f(x))-min(f(x)))
%  - 'maxLength': (default Inf)
%       Refine all the sements which are longer than a given threshold. The
%       threshold is relative to the input and output ranges. Specifically,
%       before applying the threshold, the data are normalized so that
%       max(x)-min(x)==1 and max(f(x))-min(f(x))==1.
%  - 'minLength': (default 0)
%       Exclude from the refinement process the segments which are shorter
%       than a given threshold. The threshold is relative to the input and
%       output ranges. Specifically, before applying the threshold, the
%       data are normalized so that max(x)-min(x)==1 and max(f(x))-min(f(x))==1.
%  - 'minSignal': (default 0.2)
%       Exclude from the refinement process the points where the function is
%       below a threshold. The threshold is relative to the output range: In
%       this example threshold == 0.01*(max(f(x))-min(f(x))).
%  - 'vectorizable': (default false)
%       Specifies whether the input function accepts arrays as input
%       (e.g. f(x)==x.^2).
%  - 'waitbar': (default false)
%       Display a waitbar.
%
% Output parameters
%  - a NxM array where N is the number of domain points and M is the number
%    of output parameters of the input function.
%
%
%% Examples:
%
%   % Refine a function near sharp corners. The option 'minAngle' is useful
%   % for having more points near the peaks of the function.
%   f = @(x) exp(-x.^2/4).*sin(3*x);
%   % for test-purpose also evaluate the function directly
%   x2 = -10:0.01:10;
%   y2 = f(x2);
%   y = adaptive(f, [-5,5], 'minAngle',0.8*pi);
%   figure(1); plot(x2,f(x2),'k--',y(:,1),y(:,2),'o-');
%   legend('high sampling','adaptive')
%   title('y = adaptive(f, [xstart, xend], ''minAngle'',0.8*pi)')
%   % as before but starting with an inital array of domain points
%   x = -5:5;
%   y = adaptive(f, x, 'minAngle',0.8*pi);
%   figure(2); plot(x,f(x),'s-',x2,f(x2),'k--',y(:,1),y(:,2),'o-');
%   legend('initial sampling','high sampling','adaptive')
%   title('y = adaptive(f, x, ''minAngle'',0.8*pi)')
%
%   % Refine a function near sharp corners, but do not split segments which
%   % are already shorter than 'minLength'.
%   y = adaptive(f, x, 'minAngle',0.8*pi, 'minLength',0.05);
%   figure(3); plot(x,f(x),'s-',x2,f(x2),'k--',y(:,1),y(:,2),'o-');
%   legend('initial sampling','high sampling','adaptive')
%   title('y = adaptive(f, x, ''minAngle'',0.8*pi, ''minLength'',0.05)');
%
%   % Refine a function until the areas of the triangles formed by
%   % triplets of successive points are smaller than 'maxArea'.
%   y = adaptive(f, x, 'maxArea',1e-3);
%   figure(4); plot(x,f(x),'s-',x2,f(x2),'k--',y(:,1),y(:,2),'o-');
%   legend('initial sampling','high sampling','adaptive')
%   title('y = adaptive(f, x, ''maxArea'',1e-3)')
%
%   % Refine a function until the segments formed by pairs of successive
%   % points are shorter than 'maxLength'.
%   y = adaptive(f, x, 'maxLength',0.1);
%   figure(5); plot(x,f(x),'s-',x2,f(x2),'k--',y(:,1),y(:,2),'o-');
%   legend('initial sampling','high sampling','adaptive')
%   title('y = adaptive(f, x, ''maxLength'',0.1)');


%% Copyright
% 2017, Alberto Comin -  LMU Muenchen

% Version changes:
%
% 24/01/2017: 1) new default: when no optional argument is given, use the
%  'angle' method as default 2) it is now possible to provide just the
%  start and the end of the function domain, instead of having to
%  explicitly provide an initial array 3) a new key-word argument
%  'nPoints' controls the number of initial domain points in the cases when
%  the initial array is not explicitly provided. 4) it is now possible to
%  return the domain points and the function values either as a single 2D
%  array or as two separate arrays.
% 25/01/2017: fixed defaults for the case when no method is specified

%% Default settings
vectorizable = false;
thresholdingSignal = false;
thresholdingLength = false;
thresholdingArea = false;
thresholdingAngles = false;
displayWaitbar = false;
maxRefinements = 10;
nPoints = 20;
minAngle = 0.8*pi;
minSignal = 0.2; % units normalized to data range
minLength = 0; % units normalized to data range
maxLength = Inf; % units normalized to data range
maxArea = 5e-4; % units normalized to data range

%% Test-mode
% The test mode is activated by calling 'adaptive.m' with no input.

if nargin==0
  initialDomain =  -10:10;
  input_func = @(x) 100*exp(-(x+5.2).^2) + 50*exp(-5*(x-0.5).^2)+ 20*exp(-10*(x-5.8).^2);
  thresholdingAngles = true;
  minAngle = 0.8*pi;
  thresholdingLength = true;
  minLength = 0.02;
  disp('Running adaptive.m in test mode');
  fprintf('input function: %s\n',func2str(input_func));
  disp('Plotting the function on a initial set of points');
  testFigureHandle = figure();
  plot(initialDomain, input_func(initialDomain),'bs-','LineWidth',1.5);
  grid on; xlabel('x'); ylabel('y'); title('adaptive.m example');
end


%% Processing input arguments
assert(isa(input_func,'function_handle'),'adaptiveFunctionEvaluation:ArgChk',...
  'the first argument must be a function handle');
assert(isnumeric(initialDomain) && isvector(initialDomain),...
  'adaptiveFunctionEvaluation:ArgChk','initial points must be specified as a numeric vector');

nExtraArgIn = numel(varargin);
if mod(nExtraArgIn,2)==1
  error('adaptiveFunctionEvaluation:ArgChk', ...
    'At least a key or a value is missing in the key-value arguments list.');
end

usingDefaultMethod = true;
n = 1;
while n < nExtraArgIn
  switch lower(varargin{n})  
    case 'minangle'
      minAngle = varargin{n+1};
      thresholdingAngles = true;
      usingDefaultMethod = false;
      n = n+2;
    case 'maxarea'
      maxArea = varargin{n+1};
      thresholdingArea = true;
      usingDefaultMethod = false;
      n = n+2;
    case 'maxlength'
      maxLength = varargin{n+1};
      thresholdingLength = true;
      usingDefaultMethod = false;
      n = n+2;
    case 'minlength'
      minLength = varargin{n+1};
      thresholdingLength = true;
      n = n+2;
    case 'minsignal'
      minSignal = varargin{n+1};
      thresholdingSignal = true;
      n = n+2;
    case 'npoints'
      nPoints = varargin{n+1};
      n = n+2;
    case 'vectorize'
      vectorizable = varargin{n+1};
      n = n+2;
    case 'maxrefinements'
      maxRefinements = varargin{n+1};
      n = n+2;
    case 'waitbar'
      displayWaitbar = varargin{n+1};
      n = n+2;
    otherwise
      error('adaptiveFunctionEvaluation:ArgChk',...
        ['unknown keyword argument: ', varargin{n}]);
  end
end

% if no method is specified use the 'angle' method as default
if usingDefaultMethod
  thresholdingAngles = true;
end

%% Initial function evaluation

% if initialDomain only contains the start and the end points, create a new
% array with 'nPoints' points.
if numel(initialDomain) == 2
  initialDomain = linspace(initialDomain(1),initialDomain(end),nPoints).';
end
% Normalize the input function: This step allows to use the same syntax for
% functions with single or multiple output parameters.
func = @(x) normalizeFunction(x,input_func,vectorizable);
% Evaluate the input function on the initial set of points.
dataPoints = [initialDomain(:), func(initialDomain(:))];


%% Iterative function refinement
% if displayWaitbar
%   refinementWaitbar = waitbar(0,['Evaluating function ',func2str(func)],...
%     'CreateCancelBtn','setappdata(gcbf,''canceling'',true)');
%   setappdata(refinementWaitbar,'canceling',false)
% end

for nRefinements = 1:maxRefinements
  % calculate the box which encloses the current data points:
  dataBoxSize = max(dataPoints(:,1:2)) - min(dataPoints(:,1:2));
  dataBoxArea = prod(dataBoxSize);
  
  % Each point is considered as the central corner of the triangle formed
  % with its left and right hand side neighbours. The first and the last
  % points are not the central corner of any triangle, so for N points
  % there are only N-2 triangles.
  trianglesToRefine = [false(size(dataPoints,1)-2 ,1)];
  if thresholdingArea
    triangleArea = calculateTrianglesArea(dataPoints(:,1:2));
    bigTriangles = triangleArea > (maxArea * dataBoxArea);
    trianglesToRefine = trianglesToRefine | bigTriangles;
  end
  if thresholdingAngles
    cornerAngle = calculateCentralAngles(dataPoints(:,1:2), dataBoxSize);
    sharpCorners = (cornerAngle<minAngle);
    trianglesToRefine = trianglesToRefine | sharpCorners;
  end
  
  % For N points there are N-2 triangles and N-1 triangle sides. Each
  % triangle side is a segment, which can be split or not depending on the
  % refinement parameters.
  segmentsToSplit = [trianglesToRefine; false] | [false; trianglesToRefine];
  if thresholdingLength
    dataSegments = diff(dataPoints(:,1:2));
    normalizedSegments = bsxfun(@rdivide, dataSegments, dataBoxSize);
    segmentsLengthNormalized = hypot(normalizedSegments(:,1), normalizedSegments(:,2));
    tooLongSegments = segmentsLengthNormalized > maxLength;
    longEnoughSegments = segmentsLengthNormalized > minLength;
    segmentsToSplit = (segmentsToSplit | tooLongSegments) & longEnoughSegments;
  end
  if thresholdingSignal
    segmentsCenters = (dataPoints(1:end-1,2)+dataPoints(2:end,2))/2;
    centerAboveThreshold = segmentsCenters > minSignal * max(abs(dataPoints(:,2)));
    segmentsToSplit = segmentsToSplit & centerAboveThreshold;
  end
  
  if any(segmentsToSplit)
    dataPoints = increaseSampling(func, dataPoints, segmentsToSplit);
  else
    break;
  end
  if displayWaitbar
    if getappdata(refinementWaitbar,'canceling'), break; end
    waitbar(nRefinements/maxRefinements,refinementWaitbar);
  end
end

if displayWaitbar
  delete(refinementWaitbar);
end

%% Plotting refined function
if nargin==0 % test mode
  figure(testFigureHandle);
  hold on;
  plot(dataPoints(:,1), dataPoints(:,2),'ro-');
  legend('initial', 'refiniment');
end

if nargout==1
  varargout{1} = dataPoints;
elseif nargout>1
  varargout{1} = dataPoints(:,1);
  varargout{2} = dataPoints(:,2:end);
end
end

%% Subfunctions

function y = normalizeFunction(x, func, vectorizable)
% NORMALIZEFUNCTION evaluates a function and returns a NxM array, where N
% is the number of elements of x and M is the number of outputs of func.
% All the outputs of func must be scalar.
% The optional parameter 'vectorizable' (default false) allows to specify
% that the input function can be vectorized.

if (~exist('vectorizable','var') || isempty(vectorizable))
  vectorizable=false;
end
no_elements = numel(x);
no_outputs = abs(nargout(func)); %for anonymous functions nargout<0
y = zeros(no_elements, no_outputs);
newValues = cell(1, no_outputs);
if vectorizable
  % For uniformity reasons, transform the 'x' array into a column vector.
  % In this way it does not matter if it is given as a column or a row
  % vector.
  [newValues{:}] = func(x(:));
  y = cell2mat(newValues);
else
  for i=1:no_elements
    [newValues{:}] = func(x(i));
    y(i,:) = cell2mat(newValues);
  end
end
end

function [firstStep,secondStep,longStep] = calculateTrianglesSides(XYdata)
% Return the sides (deltaX, deltaY) of the triangles formed by data points.
% For input size NxM, the output size is (N-2)xN, because the first and the
% last point are not the central corner of any triangle.

firstStep = XYdata(2:end-1,:) - XYdata(1:end-2,:);
secondStep = XYdata(3:end  ,:) - XYdata(2:end-1,:);
longStep  = XYdata(3:end  ,:) - XYdata(1:end-2,:);
end

function cornerAngle = calculateCentralAngles(XYdata, dataBoxSize)
% Calculate the central angle of the triangles formed by data points.
% For input size NxM, the output size is (N-2)xN, because the first and the
% last point are not the central corner of any triangle.

% Normalize data, because angles depend on scaling.
normalizedData = ...
  XYdata ./ repmat(dataBoxSize, size(XYdata,1), 1) - ...
  repmat(min(XYdata), size(XYdata,1), 1);
% calculate cosine of central angles
[firstStep,secondStep,longStep] = calculateTrianglesSides(normalizedData);
% calculate area of squares of length of triangle sides
firstStepSquared  = firstStep(:,1).^2  + firstStep(:,2).^2;
secondStepSquared = secondStep(:,1).^2 + secondStep(:,2).^2;
longStepSquared   = longStep(:,1).^2   + longStep(:,2).^2;
cosCornerAngle = ...
  (firstStepSquared + secondStepSquared - longStepSquared) / 2 ./ ...
  sqrt(firstStepSquared .* secondStepSquared);
cornerAngle = real(acos(cosCornerAngle));
end

function triangleArea = calculateTrianglesArea(XYdata)
% CalculateTrianglesArea of triangles formed by data points using shoelace
% formula.
% For input size NxM, the output size is (N-2)xN, because the first and the
% last point are not the central corner of any triangle.

[firstStep, ~, longStep] = calculateTrianglesSides(XYdata);
triangleArea = 0.5 * abs(-longStep(:,1).*firstStep(:,2) + firstStep(:,1).*longStep(:,2));
end

function dataPoints = increaseSampling(func, dataPoints, segmentsToSplit)
% increaseSampling increase the sampling of an input function

noPointsToAdd = numel(segmentsToSplit(segmentsToSplit==true));
newDataPoints = zeros(noPointsToAdd, size(dataPoints,2));
newDataPoints(:,1) = 0.5 * (dataPoints([segmentsToSplit;false],1) + ...
  dataPoints([false;segmentsToSplit],1));
newDataPoints(:,2:end) = func(newDataPoints(:,1));
% For simplicity append the new points at the end and then sort.
dataPoints = sortrows( [ dataPoints; newDataPoints ]);
end
