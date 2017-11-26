function [ plaintext ] = GenerateParameterPlaintext( PP, ranges, technology )
% GenerateParameterPlaintext takes the parameters, ranges, and technology
% (PBF/ME) as input and outputs the string of plaintext ranges. It does
% this by finding the first location in the relevant range array where the
% measured value is smaller. It then appends the range around that value to
% the plaintext string.

plaintext = '';

if strcmp(technology,'PBF') == 1
    for i=1:length(PP)
        ind = find(PP{i} < ranges{i},1,'first') - 1;
        plaintext = [plaintext, '[', num2str(ranges{i}(ind)),...
            ',', num2str(ranges{i}(ind+1)), '],'];
    end
elseif strcmp(technology,'ME') == 1
    %process parameters
    ind = find(PP{1} < ranges{1},1,'first') - 1;
    plaintext = [plaintext, '[', num2str(ranges{1}(ind)),...
        ',', num2str(ranges{1}(ind+1)), '],'];
    
    %layer times
    for i=2:length(PP)
        ind = find(PP{i} < ranges{2},1,'first') - 1;
        plaintext = [plaintext, '[', num2str(ranges{2}(ind)),...
            ',', num2str(ranges{2}(ind+1)), '],'];
    end
else
    error('Invalid AM technology. Enter either ''PBF'' or ''ME''.');
end

plaintext(end) = '';

end