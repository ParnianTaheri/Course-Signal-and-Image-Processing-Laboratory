%% LAB03 - Amirmohammad Marshalpirgheybi - Parnian Taheri - Amirali Razi 
addpath(genpath('.'))
close all
clear
clc
%%% Part 01 
load('Lab3_data/data/X.dat')
plot3ch(X)
% Finding the SVD of X matrix
[U,S,V] = svd(X);
save('SVD_Data.mat','U','S','V')
%% Part 02
for i = 1:max(size(V))
    plot3dv(V(:,i),S(i,i))
end
h = figure(2);
savefig(h,'Section02Part02.fig');
%% Part 03
% Plotting the first three columns of the data
fs = 256;
time_vec = (0:length(U(:,1))-1) / fs;
figure;
for i = 1:3
    subplot(3,1,i);
    plot(time_vec, U(:,i))
    hold on
    title(['The ',num2str(i), 'th Column of matrix U'])
    grid on;
    grid minor;
end
figure;
stem(diag(S))
grid on;
title("The Eigenspectrum Plot")
%% Part 04
% Reconstructing the refined version
new_S = S;
new_S(1,1) = 0;
new_S(3,3) = 0;
new_X = U*new_S*V';
% Plotting the data
plot3ch(new_X);


%% Section 3 - Part 01
[W,Zhat] = ica(X.');
A = inv(W);
save('Zhat_mat.mat','Zhat')
save('W_mat.mat','W')
save('A_mat.mat','A');


%% Section 3 - Part 02
plot3ch(X);
for i = 1:3
    plot3dv(A(:,i))
end
savefig(figure(6),'Section03Part02.fig')

%% Section 3 - Part 03
fs = 256;
time_vec = (0:length(U(:,1))-1) / fs;
figure;
for i = 1:3
    subplot(3,1,i)
    plot(time_vec,Zhat(i,:));
    grid on
    title(['The',num2str(i),'th channel'])
end
reconst_data = A(:,3)  * Zhat(3,:);
%% Section 3 - Part 04
plot3ch(reconst_data.');
savefig(figure(11),'ScatterPlot.fig');
savefig(figure(10),'ChannelData.fig');

%% Section 4 - Part 01
figure;
plot3(X(:,1), X(:,2), X(:,3),'.m');
hold all;
plot3(reconst_data(1,:),reconst_data(2,:),reconst_data(3,:),'+')
hold all;
plot3(new_X(:,1),new_X(:,2),new_X(:,3),'*')
xlabel('Ch1'); ylabel('Ch2'); zlabel('Ch3');
title('Varios Methods Scatter Plots');
grid on;
for i = 1:3
    plot3dv(A(:,i))
end

for i = 1:max(size(V))
    plot3dv(V(:,i),S(i,i))
end
norm_V = [norm(V(:,1)),norm(V(:,2)),norm(V(:,3))];
angles_V = [dot(V(:,1),V(:,2))/norm_V(1)/norm_V(2),dot(V(:,1),V(:,3))/norm_V(1)/norm_V(3),dot(V(:,2),V(:,3))/norm_V(2)/norm_V(3)];
angles_V = acosd(angles_V);

norm_A = [norm(A(:,1)),norm(A(:,2)),norm(A(:,3))];
angles_A = [dot(A(:,1),A(:,2))/norm_A(1)/norm_A(2),dot(A(:,1),A(:,3))/norm_A(1)/norm_A(3),dot(A(:,2),A(:,3))/norm_A(2)/norm_A(3)];
angles_A = acosd(angles_A);
%% Section 4 - Part 02
load("Lab3_data\data\fecg2.dat")
figure;
subplot(3,1,1);
plot(time_vec, fecg2)
hold on
title('The Original and Pure Fetus ECG Signal')
xlabel("Times(us)")
grid on;
grid minor;
subplot(3,1,2);
plot(time_vec, new_X(:,1))
hold on
title('The SVD Method Result')
xlabel("Times(us)")
grid on;
grid minor;
subplot(3,1,3);
plot(time_vec, reconst_data(1,:))
hold on
title('The ICA Method Result')
xlabel("Times(us)")
grid on;
grid minor;


%% Section 4 - Part 03
reconst_data = reconst_data';
corrcoef_SVD = corrcoef(new_X(:,1),fecg2(:,1));
corrcoef_ICA = corrcoef(reconst_data(:,1),fecg2(:,1));
disp(['The correlation factor of SVD method is: ',num2str(corrcoef_SVD(1,2))])
disp(['The correlation factor of ICA method is: ',num2str(corrcoef_ICA(1,2))])