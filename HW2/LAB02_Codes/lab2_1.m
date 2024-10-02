%% LAB02 - Amirmohammad Marshalpirgheybi - Parnian Taheri - Amirali Razi
close all
clear
clc
addpath(genpath('.'))
%%% Section 1
%% Part 1
% Reading the data
load('Lab2_1/X_org.mat');
load('Lab2_1/Electrodes.mat')
offset = max(max(abs(X_org)))/2 ;
feq = 256 ;
ElecName = Electrodes.labels ;
disp_eeg(X_org,offset,feq,ElecName) ;
title("The Main Signal")
%% Part 2
% Plotting the noise
load('Lab2_1/X_noise.mat');
offset = max(max(abs(X_noise)))/2 ;
feq = 256 ;
ElecName = Electrodes.labels ;
disp_eeg(X_noise,offset,feq,ElecName) ;
title("The Noise Signal")
%% Part 3
SNR_vec5 = -5; % SNR in dB
SNR_vec15 = -15; % SNR in dB
P_signal = sum(sum(X_org.^2,2),1);
P_noise = sum(sum(X_noise.^2,2),1);
sigma5 = (P_signal/P_noise)* (10 ^ (-SNR_vec5/10));
sigma15 = (P_signal/P_noise)* (10 ^ (-SNR_vec15/10));
new_signal5 = X_org + sqrt(sigma5) * X_noise;
new_signal15 = X_org + sqrt(sigma15) * X_noise;
offset5 = max(max(abs(new_signal5)))/2 ;
offset15 = max(max(abs(new_signal15)))/2 ;

feq = 256 ;
ElecName = Electrodes.labels ;
disp_eeg(new_signal5,offset5,feq,ElecName);
title("The Signal with Added -5dB Noise")

disp_eeg(new_signal15,offset15,feq,ElecName);
title("The Signal with Added -15dB Noise")
%% Part 4
num_channel = 32;
[F,W,K] = COM2R(new_signal5,num_channel);
[F2,W2,K2] = COM2R(new_signal15,num_channel);

componenet_signal = W * new_signal5;
componenet_signal15 = W2 * new_signal15;
offset = max(max(abs(componenet_signal)))/2;
offset15 = max(max(abs(componenet_signal15)))/2;
feq = 256 ;
% ElecName = Electrodes.labels;
disp_eeg(componenet_signal15,offset15,feq);
title("The Components")
%% Part 5 and 6
idx = [4,12,18];
selected_signal = componenet_signal(idx,:);
reconstructed_signal = F(:,idx) * selected_signal;

idx15 = [15,19,20,30];
selected_signal15 = componenet_signal15(idx15,:);
reconstructed_signal15 = F(:,idx15) * selected_signal15;


offset = max(max(abs(reconstructed_signal)))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(reconstructed_signal,offset,feq,ElecName);
title("The Denoised Signal")
%% Part 7
channel_13 = [reconstructed_signal(13,:);X_org(13,:);X_noise(13,:)];
channel_24 = [reconstructed_signal(24,:);X_org(24,:);X_noise(24,:)];
% Plotting the signal and the corresponding channels

% Channel 13
offset = max(max(abs(channel_13(1,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_13(1,:),offset,feq,ElecName);
title("The Denoised Signal - channel 13")


offset = max(max(abs(channel_13(2,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_13(2,:),offset,feq,ElecName);
title("The Original Signal - channel 13")


offset = max(max(abs(channel_13(3,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_13(3,:),offset,feq,ElecName);
title("The Noise Signal - channel 13")

% Channel 24
offset = max(max(abs(channel_24(1,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_24(1,:),offset,feq,ElecName);
title("The Denoised Signal - channel 24")


offset = max(max(abs(channel_24(2,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_24(2,:),offset,feq,ElecName);
title("The Original Signal - channel 24")


offset = max(max(abs(channel_24(3,:))))/2;
feq = 256 ;
ElecName = Electrodes.labels;
disp_eeg(channel_24(3,:),offset,feq,ElecName);
title("The Noise Signal - channel 24")


%% Part 8
RRMSE = sqrt(sum(sum((X_org-reconstructed_signal).^2,1),2)) / sqrt(sum(sum((X_org).^2,1),2));
disp("RRMSE of -5dB SNR")
disp(RRMSE)

RRMSE = sqrt(sum(sum((X_org-reconstructed_signal15).^2,1),2)) / sqrt(sum(sum((X_org).^2,1),2));
disp("RRMSE of -15dB SNR")
disp(RRMSE)




