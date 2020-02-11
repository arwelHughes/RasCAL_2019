function tableTest(output)


%f = figure('Position',[100 100 400 150]);
figure(1)

% Column names and column format
columnname = {'Rate','Amount','Available','Fixed/Adj'};
columnformat = {'numeric','bank','logical',{'Fixed' 'Adjustable'}};

% Define the data
d =    {6.125678  456.3457  true   'Fixed';...
        6.75   510.2342  false  'Adjustable';...   
        7      658.2     false  'Fixed';};

% Create the uitable
t = uitable('Data', d,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', [false false true true],...
            'RowName',[]);

% Set width and height
t.Position(3) = t.Extent(3);
t.Position(4) = t.Extent(4);        







end



