clear, close all, clc ;

loction = load('ElecPosXYZ').ElecPos ;

%Forward Matrix
ModelParams.R = [8 8.5 9.2] ; % Radius of diffetent layers
ModelParams.Sigma = [3.3e-3 8.25e-5 3.3e-3]; 
ModelParams.Lambda = [.5979 .2037 .0237];
ModelParams.Mu = [.6342 .9364 1.0362];

Resolution = 1 ;
[LocMat,GainMat] = ForwardModel_3shell(Resolution, ModelParams) ;

%% A
figure;
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:))
xlabel("x")
ylabel("y")
zlabel("z")
title("Location of Bipolars")

%% B
figure;
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:))
xlabel("x")
ylabel("y")
zlabel("z")
title("Location of Electrodes")
hold on;
for i = 1:21
    scatter3(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3), 'filled')
    text(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3),loction{1,i}.Name)
end
hold off;

%% C
% Random
bipolar = randi(length(LocMat));
selected_bipolar = LocMat(:,bipolar);

% Central
% bipolar = 1299;
% selected_bipolar = LocMat(:,bipolar);

% Temporal
% bipolar = 90;
% selected_bipolar = LocMat(:,bipolar);

% In depth bipolar
% bipolar = 97;
% selected_bipolar = LocMat(:,bipolar);

total_size = sqrt(selected_bipolar(1)^2 + selected_bipolar(2)^2 + selected_bipolar(3)^2);
bipolar_size = [selected_bipolar(1)/total_size, selected_bipolar(2)/total_size, selected_bipolar(3)/total_size];
figure;
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:))
xlabel("x")
ylabel("y")
zlabel("z")
title("Arrow from a Specific Bipolar")
hold on;
for i = 1:21
    scatter3(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3), 'filled')
    text(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3),loction{1,i}.Name)
end
scatter3(selected_bipolar(1),selected_bipolar(2), selected_bipolar(3), 'filled')
quiver3(selected_bipolar(1), selected_bipolar(2), selected_bipolar(3), bipolar_size(1), bipolar_size(2), bipolar_size(3))
hold off

%% D 
clc
interictal = load("Interictal.mat").Interictal;
size_interictal = size(interictal);
random_idx = randi(size_interictal(1));
selected_interictal = interictal(random_idx,:);
%%
Q = bipolar_size' * selected_interictal;
G = GainMat(:,[bipolar*3-2, bipolar*3-1, bipolar*3]);
m = G * Q;
display_eeg = disp_eeg(m,20,[]);
%% E
[max_vals, row_indices] = max(m');
[max_vals2, row_indices2] = max(max_vals);
[piks, x] = findpeaks(m(row_indices2,:), "MinPeakHeight", max(m(row_indices2,:))-max(m(row_indices2,:))/7);
temp = zeros(21,length(x));
for i = 1:length(x)
    temp(:,i) = mean(m(:, x(i)-3 : x(i)+3),2);
end
average_potential = mean(temp, 2);
figure
Display_Potential_3D(ModelParams.R(3), average_potential)

%% F
alpha = 0.1;
I_N = eye(21) * alpha;
Q_MNE = GainMat.' * inv(GainMat * GainMat' + I_N) * m;

%% G
bipolar_potential = zeros(1317,1);
for i = 1:1317
    bipolar_potential(i) = sum(sqrt(Q_MNE(3*i-2,:).^2 + Q_MNE(3*i-1,:).^2 + Q_MNE(3*i,:).^2),2);
end
best_bipolar = find(bipolar_potential == max(bipolar_potential));
disp(["Best bipolar: " + best_bipolar])

figure;
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:))
xlabel("x")
ylabel("y")
zlabel("z")
title("Arrow From the Best Bipolar")
hold on;
for i = 1:21
    scatter3(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3), 'filled')
    text(loction{1,i}.XYZ(1,1)*ModelParams.R(3), loction{1,i}.XYZ(1,2)*ModelParams.R(3), loction{1,i}.XYZ(1,3)*ModelParams.R(3),loction{1,i}.Name)
end
selected_bipolar2 = LocMat(:,best_bipolar);
total_size = sqrt(selected_bipolar2(1)^2 + selected_bipolar2(2)^2 + selected_bipolar2(3)^2);
bipolar_size = [selected_bipolar2(1)/total_size, selected_bipolar2(2)/total_size, selected_bipolar2(3)/total_size];

scatter3(selected_bipolar(1),selected_bipolar(2), selected_bipolar(3), 'filled')
quiver3(selected_bipolar(1), selected_bipolar(2), selected_bipolar(3), bipolar_size(1), bipolar_size(2), bipolar_size(3))

scatter3(selected_bipolar2(1),selected_bipolar2(2), selected_bipolar2(3), 'filled')
quiver3(selected_bipolar2(1), selected_bipolar2(2), selected_bipolar2(3), bipolar_size(1), bipolar_size(2), bipolar_size(3))
hold off

%% H
clc
loc_error = sqrt((selected_bipolar2(1) - selected_bipolar(1))^2 + (selected_bipolar2(2) - selected_bipolar(2))^2 + (selected_bipolar2(3) - selected_bipolar(3))^2);

normalized_vec_estimated=Q_MNE((best_bipolar-1)*3+1:best_bipolar*3)./sqrt(sum(Q_MNE((best_bipolar-1)*3+1:best_bipolar*3).^2,'all'));
normalized_vec_selected=Q_MNE((bipolar-1)*3+1:bipolar*3)./sqrt(sum(Q_MNE((bipolar-1)*3+1:bipolar*3).^2,'all'));
direction_error = sqrt(sum((normalized_vec_estimated-normalized_vec_selected).^2));
disp(("Location Error: " + loc_error))
disp(("Direction Error: " + direction_error))


