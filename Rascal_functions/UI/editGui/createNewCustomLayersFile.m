function fileCopyTest(path,name)


file = fopen([path name '.m'],'wt');

string = makeString(name);

fprintf(file,'%s\n',string{:});
fclose(file)


function out = makeString(func)

		tmpl={ ...
			'function [output,sub_rough] = $filename(params,bulk_in,bulk_out,contrast)'
			'%$FILENAME  RASCAL Custom Layer Model File.'
			'%'
			'%'
            '% This file accepts 3 vectors containing the values for'
            '% Params, bulk in and bulk out'
            '% The final parameter is an index of the contrast being calculated'
            '% The m-file should output a matrix of layer values, in the form..'
            '% Output = [thick 1, SLD 1, Rough 1, Percent Hydration 1, Hydrate how 1'
            '%           ....'
            '%           thick n, SLD n, Rough n, Percent Hydration n, Hydration how n]'
            '% The "hydrate how" parameter decides if the layer is hydrated with'
            '% Bulk out or Bulk in phases. Set to 1 for Bulk out, zero for Bulk in.'
            '% Alternatively, leave out hydration and just return..'
            '% Output = [thick 1, SLD 1, Rough 1,' 
            '%           ....'
            '%           thick n, SLD n, Rough n] };'
            '% The second output parameter should be the substrate roughness'
            };

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

