function [ ranges ] = LoadPredefinedRanges( preset, technology )
% LoadPredefinedRanges takes in a tolerance preset and the technology
% (PBF/ME). It returns a cell array of the range arrays. Both the designer
% and measurement system will have these predefined ranges.

if strcmp(technology,'PBF') == 1
    if preset == 1
        ranges{1} = 1:2:301;            %ambient temperature
        ranges{2} = 1:2:201;            %feed temperature
        ranges{3} = 0.5:1:100.5;        %laser power
        ranges{4} = 0.5:1:20.5;         %scan speed
    elseif preset == 2
        ranges{1} = 0.5:1:300.5;        %ambient temperature
        ranges{2} = 0.5:1:200.5;        %feed temperature
        ranges{3} = 0.25:0.5:100.25;    %laser power
        ranges{4} = 0.25:0.5:20.25;     %scan speed
    elseif preset == 3
        ranges{1} = 0.25:0.5:300.25;    %ambient temperature
        ranges{2} = 0.25:0.5:200.25;    %feed temperature
        ranges{3} = 0.125:0.25:100.125; %laser power
        ranges{4} = 0.125:0.25:20.125;  %scan speed
    else
        error('Invalid tolerance preset. Enter a value from 1 (lowest) to 3 (highest).');
    end
elseif strcmp(technology,'ME') == 1
    if preset == 1
        ranges{1} = 0:15:300; %extruder temperature
        ranges{2} = 1:3:3001; %layer print time
    elseif preset == 2
        ranges{1} = 0:10:300; %extruder temperature
        ranges{2} = 1:2:3001; %layer print time
    elseif preset == 3
        ranges{1} = 0:5:300;  %extruder temperature
        ranges{2} = 1:1:3000; %layer print time
    else
        error('Invalid tolerance preset. Enter a value from 1 (lowest) to 3 (highest).');
    end
else
    error('Invalid AM technology. Enter either ''PBF'' or ''ME''.');
end

end