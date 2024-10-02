%%
clc;
close all;
clear all;
load('Lab4_data/FiveClass_EEG.mat');

%% Extracting the Delta wave
% Bandpass filter between 1 - 4
fs = 256; % Sampling Frequency
N = 4; % Order
Fpass1 = 1; % First Passband Frequency
Fpass2 = 4; % Second Passband Frequency
Apass = 1; % Passband Ripple (dB)
% Construct an FDESIGN object and call its CHEBY1 method.
h = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, fs);
Hd = design(h, 'cheby1');
for c=1:30
 Delta_X(:,c) = filter(Hd,X(:,c));
end

%% Extracting the Theta wave
% Bandpass filter between 4 - 8
fs = 256; % Sampling Frequency
N = 4; % Order
Fpass1 = 4; % First Passband Frequency
Fpass2 = 8; % Second Passband Frequency
Apass = 1; % Passband Ripple (dB)
% Construct an FDESIGN object and call its CHEBY1 method.
h = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, fs);
Hd = design(h, 'cheby1');
for c=1:30
 Theta_X(:,c) = filter(Hd,X(:,c));
end

%% Extracting the Alpha wave
% Bandpass filter between 8 - 13
fs = 256; % Sampling Frequency
N = 4; % Order
Fpass1 = 8; % First Passband Frequency
Fpass2 = 13; % Second Passband Frequency
Apass = 1; % Passband Ripple (dB)
% Construct an FDESIGN object and call its CHEBY1 method.
h = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, fs);
Hd = design(h, 'cheby1');
for c=1:30
 Alpha_X(:,c) = filter(Hd,X(:,c));
end

%% Extracting the Beta wave
% Bandpass filter between 13 - 30
fs = 256; % Sampling Frequency
N = 4; % Order
Fpass1 = 13; % First Passband Frequency
Fpass2 = 30; % Second Passband Frequency
Apass = 1; % Passband Ripple (dB)
% Construct an FDESIGN object and call its CHEBY1 method.
h = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2, Apass, fs);
Hd = design(h, 'cheby1');
for c=1:30
 Beta_X(:,c) = filter(Hd,X(:,c));
end

%% Plotting the samples

time = 5;
n = fs * time;
figure();
t = linspace(0, 5, 256*5);

subplot(5,1,1);
plot(t, X(1:n,1));
title("Original wave");
xlabel("Time(s)")
grid on;
grid minor;

subplot(5,1,2);
plot(t, Delta_X(1:n,1));
title("Delta wave");
xlabel("Time(s)")
grid on;
grid minor;

subplot(5,1,3);
plot(t, Theta_X(1:n,1));
title("Theta wave");
xlabel("Time(s)")
grid on;
grid minor;

subplot(5,1,4);
plot(t, Alpha_X(1:n,1));
title("Alpha wave");
xlabel("Time(s)")
grid on;
grid minor;

subplot(5,1,5);
plot(t, Beta_X(1:n,1));
xlabel("Time(s)")
grid on;
grid minor;
title("Beta wave");

%% Extracting Trials
for i=1:200
    Delta_Trials(:,:,i) = Delta_X(trial(i): trial(i)+256*10,:);
    Theta_Trials(:,:,i) = Theta_X(trial(i): trial(i)+256*10,:);
    Alpha_Trials(:,:,i) = Alpha_X(trial(i): trial(i)+256*10,:);
    Beta_Trials(:,:,i) = Beta_X(trial(i): trial(i)+256*10,:);
end

%% 
Delta_Trials = Delta_Trials .^ 2;
Theta_Trials = Theta_Trials .^ 2;
Alpha_Trials = Alpha_Trials .^ 2;
Beta_Trials = Beta_Trials .^ 2;

%% Finding the average signal for each channel and each class
Delta_X_avg = zeros(2561, 30, 5);
Theta_X_avg = zeros(2561, 30, 5);
Alpha_X_avg = zeros(2561, 30, 5);
Beta_X_avg = zeros(2561, 30, 5);
Class_Count = zeros(5);

for i=1:200
   Class_Count(y(i)) = Class_Count(y(i)) + 1;
   Delta_X_avg(:,:,y(i)) = Delta_X_avg(:,:,y(i)) + Delta_Trials(:,:,i);
   Theta_X_avg(:,:,y(i)) = Theta_X_avg(:,:,y(i)) + Theta_Trials(:,:,i);
   Alpha_X_avg(:,:,y(i)) = Alpha_X_avg(:,:,y(i)) + Alpha_Trials(:,:,i);
   Beta_X_avg(:,:,y(i)) = Beta_X_avg(:,:,y(i)) + Beta_Trials(:,:,i);
end

for i=1:5
    Delta_X_avg(:, :, i) = Delta_X_avg(:, :, i) / Class_Count(i);
    Theta_X_avg(:, :, i) = Theta_X_avg(:, :, i) / Class_Count(i);
    Alpha_X_avg(:, :, i) = Alpha_X_avg(:, :, i) / Class_Count(i);
    Beta_X_avg(:, :, i) = Beta_X_avg(:, :, i) / Class_Count(i);
end

%% Filtering the averages

newWin = ones(1, 200)/sqrt(200);

for i=1:30
    for j=1:5
        Delta_X_avg_filtered(:,i,j) = conv(newWin, Delta_X_avg(:,i,j));
        Theta_X_avg_filtered(:,i,j) = conv(newWin, Theta_X_avg(:,i,j));
        Alpha_X_avg_filtered(:,i,j) = conv(newWin, Alpha_X_avg(:,i,j));
        Beta_X_avg_filtered(:,i,j) = conv(newWin, Beta_X_avg(:,i,j));
    end
end


%%
% CPz channel = 16
channel = 16;
t = linspace(0,10,2760);

figure();
subplot(2,2,1);
for i=1:5
    plot(t, Delta_X_avg_filtered(:,channel,i));
    hold on;
    xlabel("time(s)")
    grid on;
    grid minor
end
title("Delta Waves");
legend('1', '2', '3', '4', '5');

subplot(2,2,2);
for i=1:5
    plot(t, Theta_X_avg_filtered(:,channel,i));
    hold on;
    xlabel("time(s)")
    grid on;
    grid minor
end
title("Theta Waves");
legend('1', '2', '3', '4', '5');

subplot(2,2,3);
for i=1:5
    plot(t, Alpha_X_avg_filtered(:,channel,i));
    hold on;
    xlabel("time(s)")
    grid on;
    grid minor
end
title("Alpha Waves");
legend('1', '2', '3', '4', '5');

subplot(2,2,4);
for i=1:5
    plot(t, Beta_X_avg_filtered(:,channel,i));
    hold on;
    xlabel("time(s)")
    grid on;
    grid minor
end
title("Beta Waves");
legend('1', '2', '3', '4', '5');
