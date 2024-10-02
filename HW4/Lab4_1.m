% Lab4 - Q1 - Parnian Taheri - Mohammad Marshal Pirgheiby - Amirali Razi
clc
clear
close all

%%
fs = 240;
data = load('Lab4_data/ERP_EEG.mat').ERP_EEG;
%% A
figure;
for N = 100:100:2500
    avg = mean(data(:,1:N),2);
    subplot(5,5,N/100)
    plot(avg)
    grid on;
    grid minor;
    xlabel('Sample')
    ylabel('Amplitude')
    title(['Average of ' ,num2str(N) ,' trials'])
end

%% B
max_amp = [];
for N = 1:2550
    avg2 = mean(data(:,1:N),2);
    max_amp(N) = max(avg2);
end
figure;
plot(max_amp)
xlim([0,2550])
xlabel('Trial')
ylabel('Amplitude')
title(['Maximum amplitude of trials'])
grid on;
grid minor;

%% C
clc
avg3 = zeros(240,2550);
for N = 1:2550
    avg3(:,N) = mean(data(:,1:N),2);
end

error = [];
for N = 2:2550 
error(N) = sqrt(sum((avg3(:,N) - avg3(:,N-1)).^2,1));
end

figure;
plot(error)
xlim([0,2550])
xlabel('Trial')
ylabel('Error')
title(['Square Root Mean Error of trials'])
grid on;
grid minor;

%% D
clc
% N = N0
N0 = 600;
avg_N0 = mean(data(:,1:N0),2);

% N = 2550
avg4 = mean(data(:,1:2550),2);

% N = N0/3
avg5 = mean(data(:,1:N0/3),2);

% N = random N0
Nrnd = randperm(2550,N0);
avg6 = mean(data(:,1:Nrnd),2);

% N = random N0/3
Nrnd2 = randperm(2550,N0/3);
avg7 = mean(data(:,1:Nrnd2),2);

figure;
subplot(3,2,1)
plot(avg_N0)
xlabel('Trial')
ylabel('Amplitude')
title(['Amplitude of N = N_0 = ',num2str(N0),' trials'])
grid on;
grid minor;


subplot(3,2,3)
plot(avg4)
xlabel('Trial')
ylabel('Amplitude')
title(['Amplitude of N = ',num2str(2550),' trials'])
grid on;
grid minor;


subplot(3,2,4)
plot(avg5)
xlabel('Trial')
ylabel('Amplitude')
title(['Amplitude of N = N_0/3 = ',num2str(N0/3),' trials'])
grid on;
grid minor;


subplot(3,2,5)
plot(avg6)
xlabel('Trial')
ylabel('Amplitude')
title(['Amplitude of N = random N_0 = ',num2str(N0),' trials'])
grid on;
grid minor;


subplot(3,2,6)
plot(avg7)
xlabel('Trial')
ylabel('Amplitude')
title(['Amplitude of N = random N_0/3 = ',num2str(N0/3),' trials'])
grid on;
grid minor;
