function out = octave_struct2xml_2( in, rootName, indent )

out = [indent '<' rootName];

% process attributes
if isstruct( in )
	fnames = fieldnames( in );
	for n=1:numel(fnames)
		current_field = fnames{n};
		if strcmp( current_field, 'ATTRIBUTE' )
			attributes = fieldnames( in.ATTRIBUTE );
			for m=1:numel( attributes )
				temp = in.ATTRIBUTE.(attributes{m});
				if ~ischar( temp )
					temp = num2str( temp );
				end
				out = [out ' ' attributes{m} '="' temp '"'];
			end
			break
		end
	end
end

out = [out '>'];


% process content
if ~isstruct( in )
	if ~ischar( in )
		temp = num2str(in(1));
		for a=2:numel(in)
			temp = [temp ', ' num2str(in(a))];
		end
		in = temp;
	end
	out = [out in '</' rootName '>\n'];
	return
end

out = [out '\n'];

fnames = fieldnames( in );
for n=1:numel(fnames)
	current_field = fnames{n};
	if strcmp( current_field, 'ATTRIBUTE' )
		continue
	end
	if iscell( in.(current_field) )
		for m=1:numel( in.(current_field) )
			out = [out octave_struct2xml_2( in.(current_field){m}, current_field, [indent '  '] )];
		end
	else
		out = [out octave_struct2xml_2( in.(current_field), current_field, [indent '  '] )];
	end
end

out = [out indent '</' rootName '>\n'];