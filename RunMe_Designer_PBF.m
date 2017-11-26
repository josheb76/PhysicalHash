% RunMe_Designer_PBF is the main executable that the designer would run
% for a powder bed fusion system. They are prompted to enter a tolerance
% preset and the relevant parameters. Instructions for exporting the QR
% code STL from OpenSCAD are written to the command window after execution.

%% Initialize
clear all
close all
clc

%% Get tolerance preset.
preset = input('Enter tolerance preset (1, 2, or 3): ');

%% Create range sets (buckets) for each process parameter.
ranges = LoadPredefinedRanges(preset,'PBF');

%% Get nominal parameters.
PP{1} = input('Enter the nominal ambient temperature (°C): '); %ambient temp
PP{2} = input('Enter the nominal feed temperature (°C): '); %feed temp
PP{3} = input('Enter the nominal laser power (W): '); %laser power
PP{4} = input('Enter the nominal scan speed (m/s): '); %scan speed

%% Generate plaintext for nominal parameters
plaintext = GenerateParameterPlaintext(PP,ranges,'PBF')

%% Generate hash
opt.Method = 'MD5';
opt.Format = 'hex';
opt.Input = 'ascii';
hash = DataHash(plaintext,opt) %https://www.mathworks.com/matlabcentral/fileexchange/31272-datahash

%% Create QR code stl
GenerateQR_2D(hash,29);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
disp('1) Open GenerateQR_3D.scad')
disp('2) Press F6 and wait to compile')
disp('3) File > Export > Export as STL > Save')
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')