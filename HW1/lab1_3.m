%% Part 1
clc
clear
close all

data = load('Lab1_data/EOG_sig.mat'); % Load Data

left = data.Sig(1,:);
right = data.Sig(2,:);
Fs = data.fs;
t = 0 : 1 / Fs : (length(right) - 1) / Fs;

% Plot
figure;
subplot(2,1,1)
plot(t,left)
title("Left Eye")

subplot(2,1,2)
plot(t,right)
title("Right Eye")

%% Part 2
L = length(right);
f = linspace(-Fs/2, Fs/2, L);

fft_right = fft(right) ;
fft_shifted_right = fftshift(fft_right);

fft_left = fft(right) ;
fft_shifted_left = fftshift(fft_left);


figure;
subplot(2,1,1)
plot(f, abs(fft_shifted_left))
title("fft Left Eye")

subplot(2,1,2)
plot(f, abs(fft_shifted_right))
title("fft Right Eye")

figure;
subplot(2,1,1) ;
spectrogram(left,hamming(128),64,128,Fs,'yaxis');
title('Spectogram of left eye signal');

subplot(2,1,2) ;
spectrogram(right,hamming(128),64,128,Fs,'yaxis');
title('Spectogram of right eye signal');
