function createNewCustomXYProfileFile(path,name)


file = fopen([path name '.m'],'wt');

string = makeString(name);

fprintf(file,'%s\n',string{:});
fclose(file)


function out = makeString(func)

		tmpl={ ...
			'function output = $filename(params,bulk_in,bulk_out,contrast)'
			'%$FILENAME  RASCAL Custom XY Profile File.'
			'%'
			'%'
            '% This file accepts 3 vectors containing the values for'
            '% Params, bulk in and bulk out'
            '% The m-file should cacluate an x/y SLD profile based on the'
            '% input parameters. The output should be the calculated profile'
            '% in the form...'
            '%        output = [x(1) y(1)'
            '%                  x{2} y(2)'
            '%                  ....'
            '%                  x(n) y(n)];'
            '%      '};

		repstr={...
			'$filename'
			'$FILENAME'};

		repwithstr={...
			func
			upper(func)};

		for k = 1:numel(repstr)
			tmpl = strrep(tmpl,repstr{k},repwithstr{k});
		end
		out = tmpl;

