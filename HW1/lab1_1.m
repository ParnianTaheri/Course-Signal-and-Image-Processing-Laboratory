close all
clear
clc
addpath(genpath('.'))

%% Part 1
load("Lab1_data/EEG_sig.mat")
N = size(Z,2);  
Fs = des.samplingfreq;
time_vec = (0:N-1) / Fs;
% Plotting the 5th channel VS time
figure;
plot(time_vec,Z(5,:));
grid on
xlabel('time(s)')
ylabel("x(t)")
title("The 5th Channel Data VS Time")
xlim([0, max(time_vec)])
legend("5th Channel")

%% Part 2
signal_vec_1 = Z(5,time_vec < 15);
signal_vec_2 = Z(5,time_vec > 18 & time_vec < 40);
signal_vec_3 = Z(5,time_vec > 45 & time_vec < 50);
signal_vec_4 = Z(5,time_vec > 50);
time_vec_1 = (0:length(signal_vec_1)-1) / Fs;
time_vec_2 = (0:length(signal_vec_2)-1) / Fs + 18;
time_vec_3 = (0:length(signal_vec_3)-1) / Fs + 45;
time_vec_4 = (0:length(signal_vec_4)-1) / Fs + 50;

figure;
plot(time_vec_1,signal_vec_1);
grid on;
xlabel('time(s)')
ylabel('x(t)')
title("signal from 0 to 15 seconds")
figure;
plot(time_vec_2,signal_vec_2);
grid on;
xlabel('time(s)')
ylabel('x(t)')
title("signal from 18 to 40 seconds")
figure;
plot(time_vec_3,signal_vec_3);
grid on;
xlabel('time(s)')
ylabel('x(t)')
title("signal from 45 to 50 seconds")
figure;
plot(time_vec_4,signal_vec_4);
grid on;
xlabel('time(s)')
ylabel('x(t)')
title("signal from 50 to the end")

%% Part 3
% Plotting the 8th channel vs the 5th channel
figure;
plot(time_vec,Z(8,:));
% hold all
% plot(time_vec,Z(5,:));
grid on
xlabel('time(s)')
ylabel("x(t)")
title("The 8th Channel Data VS Time")
xlim([0, max(time_vec)]);
legend("8th Channel");
%% Part 4
% Using the disp_eeg to display the channel data in all channels
offset = max(max(abs(Z)))/5 ;
feq = 256 ;
ElecName = des.channelnames ;
disp_eeg(Z,offset,feq,ElecName) ;
xlim([0,max(time_vec)]);

%% Part 6 
% Seperating the different part of the signal every 5 seconds
vec_1 = Z(5, time_vec > 2 & time_vec < 7);
vec_2 = Z(5, time_vec > 30 & time_vec < 35);
vec_3 = Z(5, time_vec > 42 & time_vec < 47);
vec_4 = Z(5, time_vec > 50 & time_vec < 55);
fft_vec_1 = fftshift(fft(vec_1));
fft_vec_2 = fftshift(fft(vec_2));
fft_vec_3 = fftshift(fft(vec_3));
fft_vec_4 = fftshift(fft(vec_4));
freq_vec_1 = linspace(-Fs/2,Fs/2,length(fft_vec_1));
freq_vec_2 = linspace(-Fs/2,Fs/2,length(fft_vec_2));
freq_vec_3 = linspace(-Fs/2,Fs/2,length(fft_vec_3));
freq_vec_4 = linspace(-Fs/2,Fs/2,length(fft_vec_4));


% Plotting 4 signal segements
figure;
t = linspace(0, 5, length(vec_1));

subplot(4,1,1);
plot(t + 2, vec_1);
xlabel("Time(s)");
ylabel("x(t)");
title("Signal from 2 to 7");

subplot(4,1,2);
plot(t + 30, vec_2);
xlabel("Time(s)");
ylabel("x(t)");
title("Signal from 30 to 35");

subplot(4,1,3);
plot(t + 42, vec_3);
xlabel("Time(s)");
ylabel("x(t)");
title("Signal from 42 to 47");

subplot(4,1,4);
plot(t + 50, vec_4);
xlabel("Time(s)");
ylabel("x(t)");
title("Signal from 50 to 55");



% Plotting the frequency content in 4 signal segements
figure;

subplot(4,1,1)
plot(freq_vec_1(freq_vec_1 < 30 & freq_vec_1 > 0), db(abs(fft_vec_1(freq_vec_1 < 30 & freq_vec_1 > 0))))
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 2 to 7")
grid on

subplot(4,1,2)
plot(freq_vec_2(freq_vec_2 < 30 & freq_vec_2 > 0), db(abs(fft_vec_2(freq_vec_2 < 30 & freq_vec_2 > 0))))
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 30 to 35")
grid on

subplot(4,1,3)
plot(freq_vec_3(freq_vec_3 < 30 & freq_vec_3 > 0), db(abs(fft_vec_3(freq_vec_3 < 30 & freq_vec_3 > 0))))
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 42 to 47")
grid on

subplot(4,1,4)
plot(freq_vec_4(freq_vec_4 < 30 & freq_vec_4 > 0), db(abs(fft_vec_4(freq_vec_4 < 30 & freq_vec_4 > 0))))
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 50 to 55")
grid on

%% Part 7
% Using pwelch to determine the power spectral density
[pxx1,f1] = pwelch(Z(5, time_vec < 7 & time_vec > 2),[],[],[],Fs);
[pxx2,f2] = pwelch(Z(5, time_vec < 35 & time_vec > 30),[],[],[],Fs);
[pxx3,f3] = pwelch(Z(5, time_vec < 47 & time_vec > 42),[],[],[],Fs);
[pxx4,f4] = pwelch(Z(5, time_vec < 55 & time_vec > 50),[],[],[],Fs);
figure;
subplot(4,1,1)
plot(f1,pxx1)
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 2 to 7")
grid on

subplot(4,1,2)
plot(f2,pxx2)
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 30 to 35")
grid on

subplot(4,1,3)
plot(f3,pxx3)
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 42 to 47")
grid on

subplot(4,1,4)
plot(f4,pxx4)
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 50 to 55")
grid on

%% Part 8

L = 128;
noverlap = 64;
nfft = 128;
window = hamming(L);

figure;
spectrogram(Z(5,time_vec < 7 & time_vec > 2),window,noverlap,nfft,Fs,'yaxis');
xlabel('time(s)')
ylabel('|X(f)| (dB)')
title("Spectrogram of the Signal 2 to 7")

figure;
spectrogram(Z(5,time_vec < 35 & time_vec > 30),window,noverlap,nfft,Fs,'yaxis');
xlabel('time(s)')
ylabel('|X(f)| (dB)')
title("Spectrogram of the Signal 30 to 35")

figure;
spectrogram(Z(5,time_vec < 47 & time_vec > 42),window,noverlap,nfft,Fs,'yaxis');
xlabel('time(s)')
ylabel('|X(f)| (dB)')
title("Spectrogram of the Signal 42 to 47")

figure;
spectrogram(Z(5,time_vec < 55 & time_vec > 50),window,noverlap,nfft,Fs,'yaxis');
xlabel('time(s)')
ylabel('|X(f)| (dB)')
title("Spectrogram of the Signal 50 to 55")
%% Part 9
n = 4;
lowpassed_signal = lowpass(Z(5,:),30, Fs); 
downsampled_signal = lowpassed_signal(1:n:end);
time_vec_down = (0:(length(downsampled_signal)-1)) / Fs * n;
figure;
plot(time_vec_down,downsampled_signal);
grid on;
xlabel('time(s)')
ylabel('x(t)')
title("Down-Sampled Signal with n = 4")
xlim([0 max(time_vec_down)]);
fft_vec_new_2 = fftshift(fft(downsampled_signal( time_vec_down > 30 & time_vec_down < 35)));
freq_vec_new_2 = linspace(-Fs/4/2,Fs/4/2,length(fft_vec_new_2));

% Plotting the DFT of the second interval signal
figure;
plot(freq_vec_new_2(freq_vec_new_2 < 30 & freq_vec_new_2 > 0), db(abs(fft_vec_2(freq_vec_new_2 < 30 & freq_vec_new_2 > 0))))
xlabel('Frequency(Hz)')
ylabel('|X(f)| (dB)')
title("Frequency of signal segement from 30 to 35")
grid on
% Plotting the spectrogram of the down-sampled signal
figure;
L = 128;
noverlap = 64;
nfft = 128;
window = hamming(L);
spectrogram(downsampled_signal(time_vec_down > 30 & time_vec_down < 35),window,noverlap,nfft,Fs/n,'yaxis');
xlabel('time(s)')
ylabel('|X(f)| (dB)')
title("Spectrogram of the Signal")

