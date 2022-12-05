function allPredInts = refPrctileConfInts(bayesOutputs,problemDef,parConfInts)

CIFn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));
chain = bayesOutputs.chain;

% Calc the ref and SLD for the first row of the chain. This 'sticks' the x
% values of each that we then interpolate the values from the rest of the
% cain onto....
firstRow = chain(1,:); 
problemDef.fitpars = firstRow;
problemDef = unpackparams(problemDef);

% Calc the reflectivities....
%[calcProblem,calcResult] = reflectivity_calculation_wrapper(problemDef,problemDef_cells,problemDef_limits,controlsStruct);
problemDef = reflectivity_calculation(problemDef);

% 'result' is currently a cell array. Convert this to a struct because it's
% easier to work with fieldnames...
%calcResult = parseResultToStruct(calcProblem,calcResult);

% thisRef = calcResult.reflectivity;
% thisSld = calcResult.sldProfiles;
thisRef = problemDef.calculations.reflectivity;
thisSld = problemDef.calculations.slds;


% so each is a {3 x 1} cell array, because of 3 contrasts. 
% Prepare some arrays to hold the SLD's and Refs for all the chain, keeping only the Y vales.
% We'll save x values in a separate array
numberOfContrasts = size(thisRef,2);

for i = 1:numberOfContrasts
    ref_xVals{i} = thisRef{i}(:,1)';        % Transpose these into rows for storage
    ref_yVals{i} = thisRef{i}(:,2)';
    
    sld_xVals{i} = thisSld{i}(:,1)';
    sld_yVals{i} = thisSld{i}(:,2)';
end

% Loop over the whole chain, collecting the Sld's and Refs together into
% one array for each contrast.
numberOfSims = size(chain,1);   %will be = nsimu

% To speed things up, we'll take a random sample of the chain, rather than
% calculating 20000 reflectivities or whateve...
nsample = 1000;
isample = ceil(rand(nsample,1)*numberOfSims);


for i = 2:nsample

    thisChain= chain(isample(i),:);

    problemDef.fitpars = thisChain;
    problemDef = unpackparams(problemDef);

    % Calc the reflectivities....
    %[calcProblem,calcResult] = reflectivity_calculation_wrapper(problemDef,problemDef_cells,problemDef_limits,controlsStruct);
    problemDef = reflectivity_calculation(problemDef);

    % 'result' is currently a cell array. Convert this to a struct because it's
    % easier to work with fieldnames...
    %calcResult = parseResultToStruct(calcProblem,calcResult);
    
%     thisRef = calcResult.reflectivity;
%     thisSld = calcResult.sldProfiles;
%     sampleChi(i) = calcResult.calculationResults.sum_chi;

    thisRef = problemDef.calculations.reflectivity;
    thisSld = problemDef.calculations.slds;

    for n = 1:numberOfContrasts

        thisXval = ref_xVals{n};
        thisYval = interp1(thisRef{n}(:,1),thisRef{n}(:,2),thisXval);
        ref_yVals{n}(i,:) = thisYval';

        this_sldXVal = sld_xVals{n};
        thisSLDYval = interp1(thisSld{n}(:,1),thisSld{n}(:,2),this_sldXVal);
        sld_yVals{n}(i,:) = thisSLDYval';
    end
end
    

ref_Errors = cell(numberOfContrasts(1),1);
for i = 1:numberOfContrasts
    thisXval = ref_xVals{i};
    thisYvals = ref_yVals{i};
    
    cols = size(thisYvals,2);
    refArray = zeros(7,cols);
    
    % We could possibly use CIFn in one shot here (rather than loop over
    % points....)
    for points = 1:cols
        thisCol = thisYvals(:,points);
        CI_95 = CIFn(thisCol,95);
        CI_65 = CIFn(thisCol,65);
        CI_25 = CIFn(thisCol,25);
        meanRef = mean(thisCol);
        refArray(:,points) = [CI_95(1) CI_65(1) CI_25(1) meanRef CI_25(2) CI_65(2) CI_95(2)]';
    end
    ref_Errors{i} = refArray;
end

sld_Errors = cell(numberOfContrasts(1),1);
for i = 1:numberOfContrasts
    thisSldXval = sld_xVals{i};
    thisSldYvals = sld_yVals{i};
    
    cols = size(thisSldYvals,2);
    sldArray = zeros(7,cols);
    for points = 1:cols
        thisCol = thisSldYvals(:,points);
        CI_95 = CIFn(thisCol,95);
        CI_65 = CIFn(thisCol,65);
        CI_25 = CIFn(thisCol,25);
        meanSld = mean(thisCol);
        sldArray(:,points) = [CI_95(1) CI_65(1) CI_25(1) meanSld CI_25(2) CI_65(2) CI_95(2)]';
    end
    sld_Errors{i} = sldArray;
end

allPredInts.refPredInts = ref_Errors;
allPredInts.sldPredInts = sld_Errors;
allPredInts.refXdata = ref_xVals;
allPredInts.sldXdata = sld_xVals;
%allPredInts.sampleChi = sampleChi;

end