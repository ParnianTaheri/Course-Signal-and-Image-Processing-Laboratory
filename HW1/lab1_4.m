% Part 4 - EMG

data = load('Lab1_data/EMG_sig.mat'); % Load Data
healthy = data.emg_healthym;
myopathy = data.emg_myopathym;
neuropathy = data.emg_neuropathym;

Fs = data.fs;
t1 = 0: 1/Fs: (length(healthy)-1)/Fs;
t2 = 0: 1/Fs: (length(myopathy)-1)/Fs;
t3 = 0: 1/Fs: (length(neuropathy)-1)/Fs;

% Plot
figure;
subplot(3,1,1)
plot(t1,healthy)
title("Healthy")
xlabel("t(s)");

subplot(3,1,2)
plot(t2,myopathy)
title("Myopathy")
xlabel("t(s)");

subplot(3,1,3)
plot(t3,neuropathy)
title("Neuropathy")
xlabel("t(s)");

%%
fft_healthy = fft(healthy) ;
fft_shifted_healthy = fftshift(abs(fft_healthy));

fft_myopathy = fft(myopathy) ;
fft_shifted_myopathy = fftshift(abs(fft_myopathy));

fft_neuropathy = fft(neuropathy) ;
fft_shifted_neuropathy = fftshift(abs(fft_neuropathy))/;

L1 = length(healthy);
L2 = length(myopathy);
L3 = length(neuropathy);

f1 = (-L1/2:L1/2-1)*(Fs/L1);
f2 = (-L2/2:L2/2-1)*(Fs/L2);
f3 = (-L3/2:L3/2-1)*(Fs/L3);

figure;
subplot(3,1,1);
plot(f1, fft_shifted_healthy);
title("fft healthy");
xlabel("f(Hz)");

subplot(3,1,2);
plot(f2, fft_shifted_myopathy);
title("fft myopathy");
xlabel("f(Hz)");

subplot(3,1,3);
plot(f3, fft_shifted_neuropathy);
title("fft neuropathy");
xlabel("f(Hz)");

%%
figure;
subplot(3,1,1) ;
spectrogram(healthy,hamming(128),64,128,Fs,'yaxis');
title('Spectogram of healthy patiants');

subplot(3,1,2) ;
spectrogram(myopathy,hamming(128),64,128,Fs,'yaxis');
title('Spectogram of myopathy patiants');

subplot(3,1,3) ;
spectrogram(neuropathy,hamming(128),64,128,Fs,'yaxis');
title('Spectogram of neuropathy patiants');