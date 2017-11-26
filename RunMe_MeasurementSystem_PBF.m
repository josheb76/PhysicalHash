% RunMe_MeasurementSystem_PBF is the main executable that the measurement
% system would run for a powder bed fusion system. They are prompted to
% enter a tolerance preset. The output of the method is a 'success' or
% 'failure' message to the command window if an attack has been detected or
% not. For this method to work with your data, you must modify:
% -ambient_temperature_data on line 21
% -qr_img on line 40

%% Initialize
clear all
close all
clc

%% Get tolerance preset.
preset = input('Enter tolerance preset (1, 2, or 3): ');

%% Create range sets (buckets) for each process parameter.
ranges = LoadPredefinedRanges(preset,'PBF');

%% Measure actual parameters.
ambient_temperature_data = load('ambient_temperature_data.mat');
PP{1} = mean(ambient_temperature_data.data(:,2)); %ambient temperature

%theoretical measured values
PP{2} = 130; %feed temperature
PP{3} = 12; %laser power
PP{4} = 3; %scan speed

%% Generate plaintext for measured parameters
plaintext = GenerateParameterPlaintext(PP,ranges,'PBF')

%% Generate hash
opt.Method = 'MD5';
opt.Format = 'hex';
opt.Input = 'ascii';
hash = DataHash(plaintext,opt) %https://www.mathworks.com/matlabcentral/fileexchange/31272-datahash

%% Process and interpret QR code
%Read in image of build tray and convert to grayscale
qr_img = imread('qr_rectified_pbf.jpg');
qr_img_small = imresize(qr_img,[360,360]);
qr_img_gray = rgb2gray(qr_img_small);

%Normalize image to account for variable lighting and binarize to grid
qr_bw = sauvola(qr_img_gray, [45,45], 0.01); %https://www.mathworks.com/matlabcentral/fileexchange/40266-sauvola-local-image-thresholding
qr_processed = GridLayer(qr_bw,'PBF',29);

%Read QR code
imwrite(imresize(qr_processed,10,'method','nearest'),'qr_processed.jpg');
hash_qr = DecodeQR('qr_processed.jpg')

%% Compare hashes
if strcmp(hash,hash_qr) == 1
    disp('Success! Hashes match.')
else
    disp('Failure. Hashes do not match.')
end