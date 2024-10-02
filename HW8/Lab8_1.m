%% Lab 8 - Q1
clc
clear
close all

pic1 = imread("Lab 8_data/S2_Q1_utils/t2.jpg");

pic1_1 = double(pic1(:,:,1));

noise_var = 15;
noise_image = randn(size(pic1_1)) .* (15);
noisy_img = pic1_1 + noise_image;

kernel_size = 4;
kernel = zeros(256,256);
kernel((256-kernel_size)/2+1:(256+kernel_size)/2,(256-kernel_size)/2+1:(256+kernel_size)/2) = 1;
kernel = kernel/sum(kernel,'all');

F_kernel = fftshift(fft2(kernel, size(pic1_1, 1), size(pic1_1, 2)));
F_noisy_img = fftshift(fft2(noisy_img));

filtered_img_F = fftshift(ifft2(ifftshift(F_noisy_img .* F_kernel)));

figure;
subplot(1,3,1);
imshow(pic1_1/255);
title('Original Image');

subplot(1,3,2);
imshow(noisy_img/255);
title('Noisy Image');

subplot(1,3,3);
imshow(abs(filtered_img_F/255));
title('Filtered Image in Fourier Domain');

% Gaussian
gauss_filtered_img = imgaussfilt(noisy_img, sqrt(1));

figure;
subplot(2,2,1);
imshow(pic1_1/255);
title('Original Image');

subplot(2,2,2);
imshow(noisy_img/255);
title('Noisy Image');

subplot(2,2,3);
imshow(abs(filtered_img_F)/255);
title('Fourier Domain Filtering');

subplot(2,2,4);
imshow(abs(gauss_filtered_img)/255);
title('Gaussian Filtered Image');