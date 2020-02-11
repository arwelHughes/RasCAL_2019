clear

inp = load('indat.mat');
inp = inp.indat;

simXdata = inp.simXdata;
slds = inp.slds;
nbairs = inp.nbairs;
nbsubs = inp.nbsubs;
repeats = inp.repeats;
resolutions = inp.resolutions;
ssubs = inp.ssubs;

simRef = abeles_loop_2(simXdata(:),slds(:),nbairs(:),nbsubs(:), repeats(:), resolutions(:), ssubs(:));


for i = 1:7
    thisX = simXdata(1:i);
    thisSld = slds(1:i);
    thisNbair = nbairs(1:i);
    thisNbsub = nbsubs(1:i);
    thisRepeats = repeats(1:i);
    thisResol = resolutions(1:i);
    thisSsubs = ssubs(1:i);
    
    tic
    for n = 1:1000
        simRef = abeles_loop_2(thisX(:),thisSld(:),thisNbair(:),thisNbsub(:), thisRepeats(:), thisResol(:), thisSsubs(:));
    end
    tim = toc;
    timMult(i,:) = [i tim];
    
    for n = 1:1000
        simRef = abeles_single_2(thisX(:),thisSld(:),thisNbair(:),thisNbsub(:), thisRepeats(:), thisResol(:), thisSsubs(:));
    end
    tim = toc;
    timSingle(i,:) = [i tim];
end


figure(1); clf
plot(timMult(:,1),timMult(:,2),'ro');
hold on
plot(timSingle(:,1),timSingle(:,2),'bo');



    


