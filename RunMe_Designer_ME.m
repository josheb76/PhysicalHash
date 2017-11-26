% RunMe_Designer_ME is the main executable that the designer would run
% for a material extrusion system. They are prompted to enter a tolerance
% preset and the relevant parameters. Instructions for exporting the QR
% code STL from OpenSCAD are written to the command window after execution.

%% Initialize
clear all
close all
clc

%% Get tolerance preset.
preset = input('Enter tolerance preset (1, 2, or 3): ');

%% Create range sets (buckets) for each process parameter.
ranges = LoadPredefinedRanges(preset,'ME');

%% Get nominal parameters.
PP{1} = input('Enter the nominal extrusion temperature (°C): '); %extrusion temp

num_layers = input('Enter number of layers with associated build times: ');
for layer=1:num_layers %layer print time
    PP{layer+1} = input(['Enter the nominal build time for layer ',num2str(layer,'%02d'),' (frames): ']);
end

%% Generate plaintext for nominal parameters
plaintext = GenerateParameterPlaintext(PP,ranges,'ME')

%% Generate hash
opt.Method = 'MD5';
opt.Format = 'hex';
opt.Input = 'ascii';
hash = DataHash(plaintext,opt) %https://www.mathworks.com/matlabcentral/fileexchange/31272-datahash

%% Create QR code stl
GenerateQR_2D(hash,25);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
disp('1) Open GenerateQR_3D.scad')
disp('2) Press F6 and wait to compile')
disp('3) File > Export > Export as STL > Save')
disp('4) Repeat for GenerateQR_3D_negative.scad')
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')