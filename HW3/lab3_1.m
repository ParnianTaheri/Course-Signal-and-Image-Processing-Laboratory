%% Part 1
% mv fs = 256 Hz
close all
clear
clc
load("Lab3_data/data/fecg1.dat");
load("Lab3_data/data/mecg1.dat");
load("Lab3_data/data/noise1.dat");
Fs = 256;
 
t = 0 : 1 / Fs : (length(fecg1) - 1) / Fs;

figure();

subplot(4,1,1);
plot(t, fecg1);
xlabel("t(s)");
ylabel("y(mV)");
title("Fetus ECG");

subplot(4,1,2);
plot(t, mecg1);
xlabel("t(s)");
ylabel("y(mV)");
title("Mother ECG");

subplot(4,1,3);
plot(t, noise1);
xlabel("t(s)");
ylabel("y(mV)");
title("Noise");

accumulated = fecg1 + mecg1 + noise1;

subplot(4,1,4);
plot(t, accumulated);
xlabel("t(s)");
ylabel("y(mV)");
title("Accumulated signal");

%% Part 2
[fwelch, f1] = pwelch(fecg1, Fs);
[mwelch, f2] = pwelch(mecg1, Fs);
[nwelch, f3] = pwelch(noise1, Fs);
[awelch, f4] = pwelch(accumulated, Fs);

figure();

subplot(2,2,1);
plot(f1, db(fwelch));
xlabel("f(Hz)");
title("Fetus's ECG Power Spectrum");
grid on;
grid minor;

subplot(2,2,2);
plot(f2, db(mwelch));
xlabel("f(Hz)");
title("Mother's ECG Power Spectrum");
grid on;
grid minor;

subplot(2,2,3);
plot(f3, db(nwelch));
xlabel("f(Hz)");
title("Noise Power Spectrum");
grid on;
grid minor;

subplot(2,2,4);
plot(f4, db(awelch));
xlabel("f(Hz)");
title("Accumulated Power Spectrum");
grid on;
grid minor;

%% Part 3
mean_fetus = mean(fecg1);
mean_mother = mean(mecg1);
mean_noise = mean(noise1);
% mean_accumulated = mean(accumulated)

var_fetus = var(fecg1);
var_mother = var(mecg1);
var_noise = var(noise1);
% var_accumulted = var(accumulated)

disp(['The mean of fetus signal is: ', num2str(mean_fetus),' and the variance of the fetus signal is: ',num2str(var_fetus)]);
disp(['The mean of mother signal is: ', num2str(mean_mother),' and the variance of the mother signal is: ',num2str(var_mother)]);
disp(['The mean of noise signal is: ', num2str(mean_noise),' and the variance of the noise signal is: ',num2str(var_noise)]);
% the variance cannot be used as a distinguishing factor between signals.

%% Part 4-1
nbins = 40;
figure();
subplot(3,1,1)
histogram(fecg1,nbins);
xlabel("y(mV)");
ylabel("n");
title("Fetus's ECG Histogram");
grid on;

subplot(3,1,2)
histogram(mecg1,nbins);
xlabel("y(mV)");
ylabel("n");
title("Mother's ECG Histogram");
grid on;

subplot(3,1,3)
histogram(noise1,nbins);
xlabel("y(mV)");
ylabel("n");
title("Noise's Histogram");
grid on;

%% Part 4-2
moment4_fetus = kurtosis(fecg1);
moment4_mother = kurtosis(mecg1);
moment4_noise = kurtosis(noise1);
disp(['The kurtosis of fetus ECG is ',num2str(moment4_fetus)]);
disp(['The kurtosis of mother ECG is ',num2str(moment4_mother)]);
disp(['The kurtosis of noise ECG is ',num2str(moment4_noise)]);

% moment4_accumulated = kurtosis(accumulated)

% The less the 4th order moment of a signal, the closer its pdf is to a
% gaussian distribution


    
