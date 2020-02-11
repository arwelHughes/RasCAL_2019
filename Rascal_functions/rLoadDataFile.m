function problem = rLoadDataFile(problem)


dataTypes = problem.contrastTypes();

number_of_contrasts = problem.numberOfContrasts;

for i = 1:number_of_contrasts;
    switch dataTypes{i};
        case 'Ascii File'
            [problem,out] = loadAsciiData(problem,i);
            if strcmp(out{1},'ok') 
                problem.dataPresent(i) = 1;
            else
                problem = setupSimulation(problem,i);
                problem.dataPresent(i) = 0;
            end
        case 'Simulation'
            problem = setupSimulation(problem,i);
            problem.dataPresent(i) = 0;
        case 'OpenGenie Script'
            [out,problem] = loadOpengenieData(problem,i);
            if strcmp(out{1},'ok')
                problem.dataPresent(i) = 1; 
            else
                problem = setupSimulation(problem,i);
                problem.dataPresent(i) = 0;
                problem.contrastTypes{i} = 'Simulation';
            end
    end
end

%Remove Zeros....
for i = 1:number_of_contrasts
    if problem.dataPresent(i);
        thisData = problem.data{i};
        counter = 1;
        newData = [];
        for n = 1:size(thisData,1);
            if (thisData(n,2) ~= 0)
                newData(counter,:) = thisData(n,:);
                counter = counter +1;
            end
        end
        problem.data{i} = newData;
    end
end

        



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

