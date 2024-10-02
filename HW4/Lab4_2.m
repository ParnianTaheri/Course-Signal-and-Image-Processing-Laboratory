% Lab4 - Q2 - Parnian Taheri - Mohammad Marshal Pirgheiby - Amirali Razi
clc
clear
close all

%%
fs = 250;
data = load('Lab4_data/SSVEP_EEG.mat');
event_samples = data.Event_samples;
events = data.Events;
signal = data.SSVEP_Signal;

%% A
clc;
lowcut = 1;  
highcut = 40; 
order = 5;
filtered_data = zeros(6,117917);
figure;
for i = 1 : length(signal(:,1))
%     [a, b] = butter(2,[lowcut, highcut]/(fs/2), "bandpass");
%     filtered_data(i,:) = filter(a, b, signal(i,:));
    filtered_data(i,:) = bandpass(signal(i,:), [lowcut, highcut], fs);
    subplot(3,2,i)
    plot(signal(i,:))
    hold on;
    plot(filtered_data(i,:))
    hold off
    legend(["Main Signal", "Filtered Signal"])
    xlabel("Sample")
    ylabel("Amplitude")
    title(['Channel ',num2str(i)])
    sgtitle("Main vs Filtered Signal")
    grid on;
    grid minor
end

%% B
clc
trials = zeros(15,6,5*fs);
for i = 1:15
    event_sample = event_samples(i);
    trials(i,:,:) = filtered_data(:,event_sample:event_sample+5*fs-1);
end

%% C
clc
figure;
for i = 1:15
    subplot(3,5,i)
    for j = 1:6
        [pxx, f] = pwelch(squeeze(trials(i,j,:)), [], [], [], fs);
        plot(f,pxx)
        hold on
    end
    xlim([0, 50])
    ylabel("PSD")
    xlabel("Frequancy")
    title(['Trial ', num2str(i)])
    legend(["Ch 1", "Ch 2", "Ch 3", "Ch 4", "Ch 5", "Ch 6"])
    hold off
    grid on;
    grid minor;
end
sgtitle("PSD of Each Channel in Each Trial")

