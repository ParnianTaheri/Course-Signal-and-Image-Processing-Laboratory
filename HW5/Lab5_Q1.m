% Q1
clc
clear
close all

fs = 250;
gain = 1000;
vmax = 5;
t = 4;
data = load('Lab 5_data/normal.mat');
data = data.normal();
data_rest = data(1:t*fs*60,2).';
data_active = data(t*fs*60+1:(t+1)*fs*60,2).';

%% A
figure;
pwelch(data_rest(1:8*fs),[],[],[],fs)
title("PSD During Rest")

figure;
pwelch(data_active(1:8*fs),[],[],[],fs)
title("PSD of Noisy Data")

%% B
BP_filter = load('filter_Q1.mat');
BP_filter = BP_filter.Num;
figure;
stem(BP_filter)
title("Impulse Response of Filter")

figure;
f = linspace(-fs/2, fs/2, length(BP_filter));
plot(f,fftshift(abs(fft(BP_filter))))
xlabel("Frequancy [Hz]")
title("Frequancy Response of Filter")

%% C
data_active_filtered = filter(BP_filter,1,data_active);
figure;
pwelch(data_active_filtered(1:8*fs),[],[],[],fs);
title("PSD After Filter")
