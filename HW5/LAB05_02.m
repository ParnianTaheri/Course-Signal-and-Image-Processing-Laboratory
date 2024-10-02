% Amirmohammad Marshalpirgheybi - 98109815, Parnian Taheri, Amirali Razi
close all
clear;
clc;
%% Part 1
load('Lab 5_data\n_422.mat')
figure(WindowState='maximized');
signal_vec = n_422;
Fs = 250;
time_vec = (0:length(signal_vec)-1) / Fs;
plot(time_vec,signal_vec)
grid on
grid minor
xlabel("Time(s)")
ylabel("Signal")
signal_segment_normal = signal_vec(2500:5000);
signal_segment_VT = signal_vec(11442:11442+2500);
signal_segment_VFIB = signal_vec(61288:2500+61288);
figure;
[pxx,f] = pwelch(signal_segment_normal,[],[],[],Fs);
plot(f,pxx);

figure;
[pxx1,f1] = pwelch(signal_segment_VT,[],[],[],Fs);
plot(f1,pxx1);

figure;
[pxx2, f2] = pwelch(signal_segment_VFIB,[],[],[],Fs);
plot(f2,pxx2);


figure;
subplot(3,1,1)
plot(time_vec(1:2501),signal_segment_normal)
grid on;
xlabel("time(s)")

subplot(3,1,2)
plot(time_vec(1:2501),signal_segment_VT)
grid on;
xlabel("time(s)")

subplot(3,1,3)
plot(time_vec(1:2501),signal_segment_VFIB)
grid on;
xlabel("time(s)")


%% Part 03
LABEL_idx = [1 10711 11211 11442 59711 61288 ];
win_vec = 1:5*Fs:length(signal_vec);
L = 10*Fs;
LABEL_name = ["Normal";"VT";"Normal";"VT";"Noise";"VFIB"];
label_vec = [];
for new_win = 1:5*Fs:length(signal_vec)-5*Fs
    max_idx = new_win + L-1;
    idx1 = find((max_idx >= LABEL_idx),1,'last');
    idx2 = find((new_win >= LABEL_idx),1,'last');
    if(idx1 == idx2)
        label_vec = [label_vec;LABEL_name(idx1)];
    else
        label_vec = [label_vec;'None'];
    end
end


