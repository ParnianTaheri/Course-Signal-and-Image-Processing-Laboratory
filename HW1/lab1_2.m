%%
load("Lab1_data/ECG_sig.mat")

%% Part 1-1
figure();
t = [0:length(Sig)-1]/sfreq;

subplot(2,1,1);
plot(t, Sig(:,1));
title("Channel 1");
xlabel("t(s)");

subplot(2,1,2);
plot(t, Sig(:,2));
title("Channel 2");
xlabel("t(s)");

%% Part1-2
sample1 = Sig(2100:2600, 1);
sample1_x = [91 125 139 148 222 349 381 398 421 478];
sample1_y = sample1(sample1_x);

sample2 = Sig(31200:31700, 1);
sample2_x = [75 90 108 119 199];
sample2_y = sample2(sample2_x);
figure();

subplot(2,1,1);
plot(sample1);
hold on;
scatter(sample1_x, sample1_y);

subplot(2,1,2);
plot(sample2);
hold on;
scatter(sample2_x, sample2_y);


%%
arrythmiaa = ["NOTQRS" "NORMAL" "LBBB" "RBBB" "ABERR" "PVC" "FUSION" "NPC" "APC" "SVPB" "VESC" "NESC" "PACE" "UNKNOWN" "NOISE" "ARFCT" "STCH" "TCH" "SYSTOLE" "DIASTOLE" "NOTE" "MEASURE" "PAWVE" "BBB" "PAECSP" "TWAVE" "RHYTHM" "UWAVE" "LEARN" "FLWAV" "VFON" "VFOFF" "AESC" "SVESC" "LINK" "NAPC" "PFUS" "WFON" "WFOFF" "RONT"];

%% Part2
arrythmia = ["NOTQRS" "NORMAL" "LBBB" "RBBB" "ABERR" "PVC" "FUSION" "NPC" "APC" "SVPB" "VESC" "NESC" "PACE" "UNKNOWN" "NOISE" "ARFCT" "STCH" "TCH" "SYSTOLE" "DIASTOLE" "NOTE" "MEASURE" "PAWVE" "BBB" "PAECSP" "TWAVE" "RHYTHM" "UWAVE" "LEARN" "FLWAV" "VFON" "VFOFF" "AESC" "SVESC" "LINK" "NAPC" "PFUS" "WFON" "WFOFF" "RONT"];
figure();
sample_length = 10000;
sample_start = 1;
sample_end = sample_start + sample_length;
sample = Sig(sample_start:sample_end, 1);
x_plot = linspace(sample_start, sample_end+1, sample_length+1);

plot(x_plot,sample);
title("Channel 1");
xlabel("t");

for i = 1:length(ANNOTD)
    x = floor(ATRTIMED(i)*sfreq);
    if x < sample_start
        continue;
    end
    if x > sample_end
        break;
    end
    y = Sig(x, 1);
    text(x, y, arrythmia(ANNOTD(i) + 1)); 
end
%% Part3
selected_arrythmia = [556 906 1371 1686];
figure;
l = 400;
for i=1:4
    subplot(2,2,i);
    sample_mid = selected_arrythmia(i) * sfreq;
    sample = Sig(sample_mid - l:sample_mid + l, 1);
    t = (sample_mid - l:sample_mid + l)/sfreq;
    plot(t, sample);
    title(arrythmia(ANNOTD(selected_arrythmia(i)) + 1));
    xlabel("t(s)");
    grid on;
    grid minor;
end


%% Part4
close all;
l = 1000;
figure();

for i=1:2
    subplot(2,2,i);
    sample_mid = selected_arrythmia(i) * sfreq;
    sample = Sig(sample_mid - l:sample_mid + l, 1);
    t = (sample_mid - l:sample_mid + l)/sfreq;
    spectrogram(sample, hamming(128), 64, 128, sfreq, 'yaxis');
    title("channel 1");
end

for i=3:4
    subplot(2,2,i);
    sample_mid = selected_arrythmia(i) * sfreq;
    sample = Sig(sample_mid - l:sample_mid + l, 2);
    t = (sample_mid - l:sample_mid + l)/sfreq;
    spectrogram(sample, hamming(128), 64, 128, sfreq, 'yaxis');
    title("channel 2");
end

figure();

for i=1:2
    subplot(2,2,i);
    sample_mid = selected_arrythmia(i) * sfreq;
    sample = abs(fftshift(fft(Sig(sample_mid - l:sample_mid + l, 1))));
    l = length((sample_mid - l:sample_mid + l));
    f = (-l/2:l/2-1)*sfreq/l;
    plot(f, sample);
    title("channel 1");
    xlabel("f(Hz)");
    grid on;
    grid minor;
end

for i=3:4
    subplot(2,2,i);
    sample_mid = selected_arrythmia(i) * sfreq;
    sample = abs(fftshift(fft(Sig(sample_mid - l:sample_mid + l, 2))));
    l = length((sample_mid - l:sample_mid + l));
    f = (-l/2:l/2-1)*sfreq/l;
    plot(f, sample);
    title("channel 2");
    xlabel("f(Hz)");
    grid on;
    grid minor;
end




