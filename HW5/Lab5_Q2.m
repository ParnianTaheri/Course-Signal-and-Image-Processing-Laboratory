% Amirmohammad Marshalpirgheybi - 98109815, Parnian Taheri, Amirali Razi
close all
clear;
clc;
%% Part 1 - Loading and spectral analysis
load('Lab 5_data/n_422.mat')
figure();
signal_vec = n_422;
Fs = 250;
time_vec = (0:length(signal_vec)-1) / Fs;
plot(time_vec,signal_vec)
grid on
grid minor
xlabel("Time(s)")
ylabel("Signal")
title("Raw Signal");
signal_segment_normal = signal_vec(2500:5000);
signal_segment_VT = signal_vec(11442:11442+2500);
signal_segment_VFIB = signal_vec(61288:2500+61288);
figure;
%[pxx,f] = pwelch(signal_segment_normal,[],[],[],Fs);
%plot(f,pxx);
pwelch(signal_segment_normal,[],[],[],Fs);
title("Power Spectral density of a normal signal");

figure;
%[pxx1,f1] = pwelch(signal_segment_VT,[],[],[],Fs);
%plot(f1,pxx1);
pwelch(signal_segment_VT,[],[],[],Fs);
title("Power Spectral density of a VT signal");

figure;
%[pxx2, f2] = pwelch(signal_segment_VFIB,[],[],[],Fs);
%plot(f2,pxx2);
pwelch(signal_segment_VFIB,[],[],[],Fs);
title("Power Spectral density of a VFIB signal");


figure;
subplot(3,1,1)
plot(time_vec(1:2501),signal_segment_normal)
grid on;
xlabel("time(s)")
title("Normal Signal");

subplot(3,1,2)
plot(time_vec(1:2501),signal_segment_VT)
grid on;
xlabel("time(s)")
title("VT Signal");

subplot(3,1,3)
plot(time_vec(1:2501),signal_segment_VFIB)
grid on;
xlabel("time(s)")
title("VFIB Signal");


%% Part 03 - Window labeling
LABEL_idx = [1 10711 11211 11442 59711 61288 ];
win_vec = 1:5*Fs:length(signal_vec);
L = 10*Fs;
LABEL_name = ["Normal";"VT";"Normal";"VT";"Noise";"VFIB"];
LABEL_code = [1, 3, 1, 3, 4, 2];
label_vec = [];
for new_win = 1:5*Fs:length(signal_vec)-5*Fs
    max_idx = new_win + L-1;
    idx1 = find((max_idx >= LABEL_idx),1,'last');
    idx2 = find((new_win >= LABEL_idx),1,'last');
    if(idx1 == idx2)
        label_vec = [label_vec;LABEL_code(idx1)];
    else
        label_vec = [label_vec;0];
    end
end
%% Part 04 - Feature Extraction
n_422_features = zeros(59, 4);
for i=1:59
    window_start = (i-1) * 5 * Fs + 1;
    window_end = window_start + 10 * Fs - 1;
    window = n_422(window_start:window_end);
    n_422_features(i, 1) = bandpower(window,Fs,[0 60]);
    n_422_features(i, 2) = bandpower(window,Fs,[60 120]);
    n_422_features(i, 3) = meanfreq(window, Fs);
    n_422_features(i, 4) = medfreq(window, Fs);
end

%% Part 05 - Feature Histograms

index_normal = label_vec==1;
index_VFIB = label_vec==2;
feature_normal = n_422_features(index_normal, :);
feature_VFIB = n_422_features(index_VFIB, :);

titles = ["0 to 60 Hz Band power", "60 to 120 Hz Band power", "Meanfreq", "Medfreq"];
figure();
for i=1:length(titles)
    subplot(2,2,i);
    histogram(feature_normal(:, i));
    hold on;
    histogram(feature_VFIB(:, i));
    title(titles(i));
    legend("Normal", "VFIB");
end

%% Part 07 - Model Evaluation
n_422_detection = va_detect1(n_422); % prediciton
output = zeros(2, length(n_422_detection));
output(1, :) = n_422_detection == 0; 
output(2, :) = n_422_detection == 1;
n_422_truth = label_vec==2; % ground truth
target = zeros(2, length(n_422_truth));
target(1, :) = n_422_truth == 0;
target(2, :) = n_422_truth == 1;
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 08 - Extracting Morphologic and statistical features
n_422_features2 = zeros(59, 6);
for i=1:59
    window_start = (i-1) * 5 * Fs + 1;
    window_end = window_start + 10 * Fs - 1;
    window = n_422(window_start:window_end);
    n_422_features2(i, 1) = max(window);
    n_422_features2(i, 2) = min(window);
    n_422_features2(i, 3) = n_422_features2(i, 1) - n_422_features2(i, 2);
    n_422_features2(i, 4) = mean(findpeaks(window));
    n_422_features2(i, 5) = zero_intersections(window);
    n_422_features2(i, 6) = var(window);
end
%% Part 09 - Feature Histograms
feature_normal2 = n_422_features2(index_normal, :);
feature_VFIB2 = n_422_features2(index_VFIB, :);

figure();
titles = ["Max", "Mean", "Peak to Peak", "Peak Average", "Zero intersections", "Variance"];
for i=1:6
    subplot(2,3,i);
    histogram(feature_normal2(:, i));
    hold on;
    histogram(feature_VFIB2(:, i));
    title(titles(i));
    legend("Normal", "VFIB"); 
end

%% Part 11 - New Model's evaluation

n_422_detection2 = va_detect2(n_422); % prediciton
output = zeros(2, length(n_422_detection));
output(1, :) = n_422_detection2 == 0; 
output(2, :) = n_422_detection2 == 1;
n_422_truth = label_vec==2; % ground truth
target = zeros(2, length(n_422_truth));
target(1, :) = n_422_truth == 0;
target(2, :) = n_422_truth == 1;
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 12-1 - Loading the data
load('Lab 5_data\n_424.mat')
signal_vec = n_424;

%% Part 12-2 - Labeling the data
LABEL_idx = [1 27249 53673 55134 58288];
win_vec = 1:5*Fs:length(signal_vec);
L = 10*Fs;
LABEL_name = ["Normal";"VFIB";"Noise";"ASYS";"Nod"];
LABEL_code = [1, 2, 0, 3, 5, 6];
label_vec = [];
for new_win = 1:5*Fs:length(signal_vec)-5*Fs
    max_idx = new_win + L-1;
    idx1 = find((max_idx >= LABEL_idx),1,'last');
    idx2 = find((new_win >= LABEL_idx),1,'last');
    if(idx1 == idx2)
        label_vec = [label_vec;LABEL_code(idx1)];
    else
        label_vec = [label_vec;0];
    end
end

%% Part 12-3 - Feature Extraction
n_424_features = zeros(59, 4);
for i=1:59
    window_start = (i-1) * 5 * Fs + 1;
    window_end = window_start + 10 * Fs - 1;
    window = n_424(window_start:window_end);
    n_424_features(i, 1) = bandpower(window,Fs,[0 60]);
    n_424_features(i, 2) = bandpower(window,Fs,[60 120]);
    n_424_features(i, 3) = meanfreq(window, Fs);
    n_424_features(i, 4) = medfreq(window, Fs);
end

%% Part 12-4 - Feature Histograms
index_normal = label_vec==1;
index_VFIB = label_vec==2;
feature_normal = n_424_features(index_normal, :);
feature_VFIB = n_424_features(index_VFIB, :);

titles = ["0 to 60 Hz Band power", "60 to 120 Hz Band power", "Meanfreq", "Medfreq"];
figure();
for i=1:length(titles)
    subplot(2,2,i);
    histogram(feature_normal(:, i));
    hold on;
    histogram(feature_VFIB(:, i));
    title(titles(i));
    legend("Normal", "VFIB");
end

%% Part 12-5 - Model Evaluation
n_424_detection = va_detect3(n_424); % prediciton
output = zeros(2, length(n_424_detection));
output(1, :) = n_424_detection == 0; 
output(2, :) = n_424_detection == 1;
n_424_truth = label_vec==2; % ground truth
target = zeros(2, length(n_424_truth));
target(1, :) = n_424_truth == 0;
target(2, :) = n_424_truth == 1;
figure();
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 12-6 - Extracting Morphologic and statistical features
n_424_features2 = zeros(59, 6);
for i=1:59
    window_start = (i-1) * 5 * Fs + 1;
    window_end = window_start + 10 * Fs - 1;
    window = n_424(window_start:window_end);
    n_424_features2(i, 1) = max(window);
    n_424_features2(i, 2) = min(window);
    n_424_features2(i, 3) = n_424_features2(i, 1) - n_424_features2(i, 2);
    n_424_features2(i, 4) = mean(findpeaks(window));
    n_424_features2(i, 5) = sum(window == 0);
    n_424_features2(i, 6) = var(window);
end
%% Part 12-7 Feature Histograms
feature_normal2 = n_424_features2(index_normal, :);
feature_VFIB2 = n_424_features2(index_VFIB, :);

figure();
titles = ["Max", "Mean", "Peak to Peak", "Peak Average", "Zero intersections", "Variance"];
for i=1:6
    subplot(2,3,i);
    histogram(feature_normal2(:, i));
    hold on;
    histogram(feature_VFIB2(:, i));
    title(titles(i));
    legend("Normal", "VFIB"); 
end

%% Part 12-8 - New Model's Evaluation
n_424_detection2 = va_detect4(n_424); % prediciton
output = zeros(2, length(n_424_detection));
output(1, :) = n_424_detection2 == 0; 
output(2, :) = n_424_detection2 == 1;
n_424_truth = label_vec==2; % ground truth
target = zeros(2, length(n_424_truth));
target(1, :) = n_424_truth == 0;
target(2, :) = n_424_truth == 1;
figure();
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 14-1 - classifier 1 on data 2
n_424_detection2 = va_detect1(n_424); % prediciton
output = zeros(2, length(n_424_detection));
output(1, :) = n_424_detection2 == 0; 
output(2, :) = n_424_detection2 == 1;
n_424_truth = label_vec==2; % ground truth
target = zeros(2, length(n_424_truth));

target(1, :) = n_424_truth == 0;
target(2, :) = n_424_truth == 1;
figure();
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 14-2 - classifier 4 on data 1
n_422_detection2 = va_detect4(n_422); % prediciton
output = zeros(2, length(n_422_detection));
output(1, :) = n_422_detection2 == 0; 
output(2, :) = n_422_detection2 == 1;
n_422_truth = label_vec==2; % ground truth
target = zeros(2, length(n_422_truth));
target(1, :) = n_422_truth == 0;
target(2, :) = n_422_truth == 1;
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Part 15 - Best Classifier on Random Data
% Classifier 1 is the best classifier

load('Lab 5_data\n_605.mat');
signal = n_605;

LABEL_idx = [1 36942 44115];
win_vec = 1:5*Fs:length(signal_vec);
L = 10*Fs;
LABEL_name = ["Noise";"VT";"Noise"];
LABEL_code = [0, 3, 0];
label_vec = [];
for new_win = 1:5*Fs:length(signal_vec)-5*Fs
    max_idx = new_win + L-1;
    idx1 = find((max_idx >= LABEL_idx),1,'last');
    idx2 = find((new_win >= LABEL_idx),1,'last');
    if(idx1 == idx2)
        label_vec = [label_vec;LABEL_code(idx1)];
    else
        label_vec = [label_vec;0];
    end
end

detection = va_detect4(signal); % prediciton
output = zeros(2, length(n_422_detection));
output(1, :) = detection == 0; 
output(2, :) = detection == 1;
truth = label_vec==2; % ground truth
target = zeros(2, length(truth));
target(1, :) = truth == 0;
target(2, :) = truth == 1;
[c,cm,ind,per] = confusion(target,output);
plotconfusion(target, output);
title("1 = normal    2 = VFIB");
TP = cm(2, 2);
TN = cm(1, 1);
FP = cm(1, 2);
FN = cm(2, 1);
accuracy = (TP + TN) / (TP + TN + FP + FN); % calculating the accuracty of our model
accuracy
sensitivity = (TP) / (TP + FN); % calculating the sensitivity of our model
sensitivity
specificity = (TN) / (TN + FP); % calculating the specificity of our model
specificity

%% Functions
function [alarm,t] = va_detect1(ecg_data,Fs)
    frame_sec = 10;  % sec
    overlap = 0.5;    % 50% overlap between consecutive frames
    if nargin < 2
        Fs = 250;  % default sample rate
    end
    if nargin < 1
        error('You must enter an ECG data vector.');
    end
    ecg_data = ecg_data(:);  % Make sure that ecg_data is a column vector
    frame_length = round(frame_sec*Fs);  % length of each data frame (samples)
    frame_step = round(frame_length*(1-overlap));  % amount to advance for next data frame
    ecg_length = length(ecg_data);  % length of input vector
    frame_N = floor((ecg_length-(frame_length-frame_step))/frame_step); % total number of frames
    alarm = zeros(frame_N,1);	% initialize output signal to all zeros
    t = ([0:frame_N-1]*frame_step+frame_length)/Fs;
    for i = 1:frame_N % Analysis loop: each iteration processes one frame of data
        seg = ecg_data(((i-1)*frame_step+1):((i-1)*frame_step+frame_length));
        segMedfreq = medfreq(seg, Fs);
        segBandpower2 = bandpower(seg,Fs,[60 120]);
        if segMedfreq >= 4 && segBandpower2 < 2.4 % deciding alarm
            alarm(i) = 1;
        end
    end
end

function [alarm,t] = va_detect2(ecg_data,Fs)
    frame_sec = 10;  % sec
    overlap = 0.5;    % 50% overlap between consecutive frames
    if nargin < 2
        Fs = 250;  % default sample rate
    end
    if nargin < 1
        error('You must enter an ECG data vector.');
    end
    ecg_data = ecg_data(:);  % Make sure that ecg_data is a column vector
    frame_length = round(frame_sec*Fs);  % length of each data frame (samples)
    frame_step = round(frame_length*(1-overlap));  % amount to advance for next data frame
    ecg_length = length(ecg_data);  % length of input vector
    frame_N = floor((ecg_length-(frame_length-frame_step))/frame_step); % total number of frames
    alarm = zeros(frame_N,1);	% initialize output signal to all zeros
    t = ([0:frame_N-1]*frame_step+frame_length)/Fs;
    for i = 1:frame_N  % Analysis loop: each iteration processes one frame of data
        seg = ecg_data(((i-1)*frame_step+1):((i-1)*frame_step+frame_length));
        seg_peak_average = mean(findpeaks(seg));
        seg_zeros = zero_intersections(seg);
        seg_max = max(seg);
        if seg_peak_average >= -20 && seg_zeros > 90 % deciding alarm
            alarm(i) = 1;
        end
    end
end

function [alarm,t] = va_detect3(ecg_data,Fs)
    frame_sec = 10;  % sec
    overlap = 0.5;    % 50% overlap between consecutive frames
    if nargin < 2
        Fs = 250;  % default sample rate
    end
    if nargin < 1
        error('You must enter an ECG data vector.');
    end
    ecg_data = ecg_data(:);  % Make sure that ecg_data is a column vector

    frame_length = round(frame_sec*Fs);  % length of each data frame (samples)
    frame_step = round(frame_length*(1-overlap));  % amount to advance for next data frame
    ecg_length = length(ecg_data);  % length of input vector
    frame_N = floor((ecg_length-(frame_length-frame_step))/frame_step); % total number of frames
    alarm = zeros(frame_N,1);	% initialize output signal to all zeros
    t = ([0:frame_N-1]*frame_step+frame_length)/Fs;
    for i = 1:frame_N % Analysis loop: each iteration processes one frame of data
        seg = ecg_data(((i-1)*frame_step+1):((i-1)*frame_step+frame_length));
        seg_meanfreq = meanfreq(seg);
        seg_medfreq = medfreq(seg);
        if seg_meanfreq > 1 && seg_medfreq > 0.5 % deciding alarm
            alarm(i) = 1;
        end
    end
end

function [alarm,t] = va_detect4(ecg_data,Fs)
    frame_sec = 10;  % sec
    overlap = 0.5;    % 50% overlap between consecutive frames
    if nargin < 2
        Fs = 250;  % default sample rate
    end
    if nargin < 1
        error('You must enter an ECG data vector.');
    end
    ecg_data = ecg_data(:);  % Make sure that ecg_data is a column vector
    frame_length = round(frame_sec*Fs);  % length of each data frame (samples)
    frame_step = round(frame_length*(1-overlap));  % amount to advance for next data frame
    ecg_length = length(ecg_data);  % length of input vector
    frame_N = floor((ecg_length-(frame_length-frame_step))/frame_step); % total number of frames
    alarm = zeros(frame_N,1);	% initialize output signal to all zeros
    t = ([0:frame_N-1]*frame_step+frame_length)/Fs;
    for i = 1:frame_N % Analysis loop: each iteration processes one frame of data
        %  Get the next data segment
        seg = ecg_data(((i-1)*frame_step+1):((i-1)*frame_step+frame_length));
        seg_zeros = sum(seg == 0);
        seg_var = var(seg);
        if seg_zeros > 10 && seg_var < 20000
            alarm(i) = 1;
        end
    end
end

function o = zero_intersections(x) % finds the number of time a function passes 0
    o = 0;
    for i=1:length(x) - 1
        if x(i) * x(i+1) <= 0
            o = o + 1;
        end
    end
end


