% RunMe_MeasurementSystem_ME is the main executable that the measurement
% system would run for a material extrusion system. They are prompted to
% enter a tolerance preset. The output of the method is a 'success' or
% 'failure' message to the command window if an attack has been detected or
% not. For this method to work with your data, you must modify:
% -extrusion_temperature_data on line 22
% -layer_time_data on line 25
% -qr_img on line 42

%% Initialize
clear all
close all
clc

%% Get tolerance preset.
preset = input('Enter tolerance preset (1, 2, or 3): ');

%% Create range sets (buckets) for each process parameter.
ranges = LoadPredefinedRanges(preset,'ME');

%% Measure actual parameters.
extrusion_temperature_data = load('extrusion_temperature_data_1.mat');
PP{1} = mean(extrusion_temperature_data.data(:,2)); %extrusion temperature

layer_time_data = load('layer_time_data_1.mat');
num_layers = layer_time_data.data(end,1);
for layer=2:num_layers+1 %layer print time
    PP{layer} = layer_time_data.data(layer-1,2);
end 

%% Generate plaintext for measured parameters
plaintext = GenerateParameterPlaintext(PP,ranges,'ME')

%% Generate hash
opt.Method = 'MD5';
opt.Format = 'hex';
opt.Input = 'ascii';
hash = DataHash(plaintext,opt) %https://www.mathworks.com/matlabcentral/fileexchange/31272-datahash

%% Process and interpret QR code
%Read in image of build tray
qr_img = imread('qr_rectified_me.jpg');
qr_processed = GridLayer(qr_img,'ME',25);

%Read QR code
imwrite(imresize(qr_processed,10,'method','nearest'),'qr_processed.jpg');
hash_qr = DecodeQR('qr_processed.jpg')

%% Compare hashes
if strcmp(hash,hash_qr) == 1
    disp('Success! Hashes match.')
else
    disp('Failure. Hashes do not match.')
end