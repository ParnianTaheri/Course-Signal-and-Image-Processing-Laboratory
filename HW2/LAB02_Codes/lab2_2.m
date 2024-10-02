%% LAB02 - Amirmohammad Marshalpirgheybi - Parnian Taheri - Amirali Razi
close all
clear
clc
%%% Section 2
%% Part 1
% We use the 1st and 3rd signal for our comprehensive analysis
signal_1 = load('Lab2_2/NewData1.mat').EEG_Sig;
signal_2 = load('Lab2_2/NewData3.mat').EEG_Sig;
load("Lab2_2/Electrodes.mat")

offset = max(max(abs(signal_1)))/2 ;
feq = 250 ;
ElecName = Electrodes.labels ;
disp_eeg(signal_1,offset,feq,ElecName) ;
title("The Main Signal 1")


offset = max(max(abs(signal_2)))/2 ;
feq = 250 ;
ElecName = Electrodes.labels ;
disp_eeg(signal_2,offset,feq,ElecName) ;
title("The Main Signal 3")

%% Part 3
num_channel  = 21;
[F_1,W_1,K_1] = COM2R(signal_1,num_channel);
[F_2,W_2,K_2] = COM2R(signal_2,num_channel);


% %% Part 4
% Fs = 250;
% time_vec = (0:size(signal_1,2)-1) / Fs;
% figure;
% for i = 1:num_channel
%     subplot(3,1,1)
%     plot(time_vec,signal_1(i,:))
%     grid on;
%     xlabel("Time(seconds)")
%     ylabel("x(t)")
%     title("The Signal Time Domain for Signal 1")
% 
%     subplot(3,1,2)
%     pwelch(signal_1(i,:))
% 
%     subplot(3,1,3)
%     plottopomap(Electrodes.X,Electrodes.Y,Electrodes.labels,F_1(:,i))
%     savefig(figure(3),['figure_signal_1_',num2str(i),'.fig'])
%     
% end
% 
% for i = 1:num_channel
%     subplot(3,1,1)
%     plot(time_vec,signal_2(i,:))
%     grid on;
%     xlabel("Time(seconds)")
%     ylabel("x(t)")
%     title("The Signal Time Domain for Signal 3")
% 
%     subplot(3,1,2)
%     pwelch(signal_2(i,:))
% 
%     subplot(3,1,3)
%     plottopomap(Electrodes.X,Electrodes.Y,Electrodes.labels,F_2(:,i))
%     savefig(figure(3),['figure_signal_3_',num2str(i),'.fig'])
%     
% end


%% Part 4-2
Fs = 250;
time_vec = (0:size(signal_1,2)-1) / Fs;
f = figure;
f.Position = [150 100 1000 800];
sgtitle("The Signal Time Domain for Signal 1",'FontSize',14, 'Interpreter','latex')   
for i = 1:num_channel
    subplot(7,3,i)
    plot(time_vec,signal_1(i,:))
    grid on;
    xlabel("Time(seconds)")
    ylabel("x(t)")
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');
end

%savefig(figure(3),['figure_signal_3_',num2str(i),'.fig'])
f = figure;
f.Position = [150 100 1000 800];
sgtitle(['PSD of Different Sources in Signal 1'],'FontSize',14, 'Interpreter','latex');
for i = 1:num_channel
    subplot(7,3,i)
    pwelch(signal_1(i,:),[],[],[],Fs)
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');
end
f = figure;
f.Position = [150 100 1000 800];
sgtitle(['Different Sources in Signal 1'],'FontSize',14, 'Interpreter','latex');
for i = 1:num_channel
    subplot(7,3,i)
    plottopomap(Electrodes.X,Electrodes.Y,Electrodes.labels,F_1(:,i))   
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');
end

f = figure;
f.Position = [150 100 1000 800];
sgtitle("The Signal Time Domain for Signal 3",'FontSize',14, 'Interpreter','latex')  
for i = 1:num_channel
    subplot(7,3,i)
    plot(time_vec,signal_2(i,:))
    grid on;
    xlabel("Time(seconds)")
    ylabel("x(t)")
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');
end
%savefig(figure(3),['figure_signal_3_',num2str(i),'.fig'])
f = figure;
f.Position = [150 100 1000 800];
sgtitle(['PSD of Different Sources in Signal 3'],'FontSize',14, 'Interpreter','latex');
for i = 1:num_channel
    subplot(7,3,i)
    pwelch(signal_2(i,:),[],[],[],Fs);
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');  
end

f = figure;
f.Position = [150 100 1000 800];
sgtitle(['Different Sources in Signal 3'],'FontSize',14, 'Interpreter','latex');
for i = 1:num_channel
    subplot(7,3,i)
    plottopomap(Electrodes.X,Electrodes.Y,Electrodes.labels,F_2(:,i))   
    title([num2str(i),'th Source'],'FontSize',14, 'Interpreter','latex');
end
    

%% Part 5
idx_1 = [2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
idx_2 = [2,6,9,10,14,17,18,19,20,21];
component_signal_1 = W_1 * signal_1;
component_signal_2 = W_2 * signal_2;

signal_1_denoised = F_1(:,idx_1) * component_signal_1(idx_1,:);
signal_2_denoised = F_2(:,idx_2) * component_signal_2(idx_2,:);


offset = max(max(abs(signal_1_denoised)))/2 ;
feq = 250;
ElecName = Electrodes.labels;
disp_eeg(signal_1_denoised,offset,feq,ElecName) ;
title("The Signal 1 Denoised Version")


offset = max(max(abs(signal_2_denoised)))/2 ;
feq = 250;
ElecName = Electrodes.labels;
disp_eeg(signal_2_denoised,offset,feq,ElecName) ;
title("The Signal 3 Denoised Version")

