function [out,problem] = loadOpengenieData(problem,contrast);

try

    amIAtISIS = getappdata(0,'ImAtISIS');

    ogDetails = problem.ogDetails{contrast};
    ogDataPath = '';
    rascalPath = getappdata(0,'rascalPath');
    slashes = findstr(rascalPath,'\');
    rascalPath(slashes) = '/';

    %Initialise the Genie session.
    instrument = ogDetails.instrument;
    transmission = char(ogDetails.transmission);
    switch instrument
        case 'Surf'
            out = setUpOpenGenieForSurf(rascalPath,ogDataPath);
            if strcmp(out{1},'fail');
                return
            end
        case 'Crisp'
            addInfoText('Crisp not set up yet!');
            out{1} = 'fail';
            return
        case 'Inter'
            out = SetUpOpenGenieForInter(rascalPath,ogDataPath);
            if strcmp(out{1},'fail');
                return
            end
    end


    numberOfAngles = ogDetails.numberOfAngles;
    type = ogDetails.type;
    runs = ogDetails.runs;

    for i = 1:numberOfAngles
        switch type
            case 'Air / Liquid (or solid)';
                thisRun = runs{i,1};
                if (str2num(thisRun) == 0 && ~strcmp(amIAtISIS,'true'))
                    addInfoText('Calls to DAE (run #0) not allowed outside ISIS');
                    out{1} = 'fail';
                    return
                end
                thisAngle = runs{i,2};
                callString = ['quick ' thisRun ' ' thisAngle];
                addInfoText(['Calling "' callString '"']);
                w=gm_assign_handle(callString,' ');
                callString = (['w' num2str(i) '=wrq']);
                w=gm_assign_handle(callString,' ');
            case 'Solid / Liquid'
                thisRun = runs{i,1};
                if (str2num(thisRun) == 0 && ~strcmp(amIAtISIS,'true'))
                    addInfoText('Calls to DAE (run #0) not allowed outside ISIS');
                    out{1} = 'fail';
                    return
                end
                thisAngle = runs{i,2};
                callString = ['w' num2str(i) ' = sol_straight:mi(' thisRun ',' transmission ',' thisAngle ')'];
                addInfoText(['Calling "' callString '"']);
                w=gm_assign_handle(callString,' ');
                callString = (['w' num2str(i) '=wrq']);
                w=gm_assign_handle(callString,' ');
        end
    end

    switch numberOfAngles
        case 1
            angle = str2num(runs{1,2});
            maxAngle = 0.7;%num2str(angle/10);
            callString = ['reb w1 w1.x[1] ' num2str(maxAngle)];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            [stat,x]=gm_transfer('w1.x','-->','FLOAT32[]');
            [stat,y]=gm_transfer('w1.y','-->','FLOAT32[]');
            [stat,e]=gm_transfer('w1.e','-->','FLOAT32[]');
        case 2
            angle = str2num(runs{1,2});
            maxAngle = num2str(angle/10);
            callString = ['reb w1 w1.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{2,2});
            maxAngle = '1.5';%num2str(angle/10);
            callString = ['reb w2 w2.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            w = gm_assign_handle('wcomb=stitch:l(w1,w2)',' ');
            addInfoText('Splicing runs');
            [stat,x]=gm_transfer('wcomb.x','-->','FLOAT32[]');
            [stat,y]=gm_transfer('wcomb.y','-->','FLOAT32[]');
            [stat,e]=gm_transfer('wcomb.e','-->','FLOAT32[]');
        case 4
            angle = str2num(runs{1,2});
            maxAngle = num2str(angle/10);
            callString = ['reb w1 w1.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{2,2});
            maxAngle = num2str(angle/10);
            callString = ['reb w2 w2.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{3,2});
            maxAngle = num2str(angle/10);
            callString = ['reb w3 w3.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{4,2});
            callString = ['reb w4 w4.x[1] ' 0.9];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            w = gm_assign_handle('wcomb=stitch:l(w1,w2,w3,w4)',' ');
            addInfoText('Splicing runs');
            [stat,x]=gm_transfer('wcomb.x','-->','FLOAT32[]');
            [stat,y]=gm_transfer('wcomb.y','-->','FLOAT32[]');
            [stat,e]=gm_transfer('wcomb.e','-->','FLOAT32[]');
        case 3
            angle = str2num(runs{1,2});
            maxAngle = num2str((angle+0.1)/10);
            callString = ['reb w1 w1.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{2,2});
            maxAngle = num2str((angle+0.1)/10);
            callString = ['reb w2 w2.x[1] ' maxAngle];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            angle = str2num(runs{3,2});


            maxAngle = num2str(1);
            callString = ['reb w3 w3.x[1] 0.7'];
            addInfoText(['Calling "' callString '"']);
            w=gm_assign_handle(callString,' ');

            w = gm_assign_handle('wcomb=stitch:l(w1,w2,w3)',' ');
            addInfoText('Splicing runs');
            [stat,x]=gm_transfer('wcomb.x','-->','FLOAT32[]');
            [stat,y]=gm_transfer('wcomb.y','-->','FLOAT32[]');
            [stat,e]=gm_transfer('wcomb.e','-->','FLOAT32[]');
    end


    data = hist2xy(double(x),double(y),double(e));
        

    problem.data{contrast} = data;
    problem.include_data(contrast) = 1;
    problem.dataPresent(contrast) = 1;
    if problem.dataLimits{contrast}(1) < data(1,1)
        problem.dataLimits{contrast}(1) = data(1,1);
    end
    if problem.dataLimits{contrast}(2) > data(end,1);
        problem.dataLimits{contrast}(2) = data(end,1);
    end
    if problem.simLimits{contrast}(1) > data(1,1);
        problem.simLimits{contrast}(1) = data(1,1);
    end
    if problem.simLimits{contrast}(2) < data(end,1);
        problem.simLimits{contrast}(2) = data(end,1);
    end
    out{1} = 'ok';

catch
    addInfoText('Problem with openGenie link');
    addInfoText('Changing to "simulation"')
    out{1} = 'fail';
end

