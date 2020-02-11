inps = getappdata(0,'inps');

chain = inps.chain;
bestFit = inps.bestFit;
bestSld = inps.bestSld;
intervals = inps.intervals;
predInt = inps.predInt;

[ref, sld, outMess] = refPredInterval_2(chain, bestFit, bestSld, intervals, predInt);

