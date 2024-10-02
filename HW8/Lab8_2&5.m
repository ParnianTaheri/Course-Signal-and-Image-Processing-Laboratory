%% Part 02
close all
clear
clc;
f = imread('S2_Q3_utils\t2.jpg');
f = f(:,:,1);
f = double(f);
h = Gaussian(10,[5,5]);
g = conv2(f,h,'same');
figure;
subplot(1,2,1)
imagesc(f)
title("Original Image")
subplot(1,2,2)
imagesc(g)
title("Noised Image")
G = fft2(g);
H = fft2(h,256,256);
F = G./H;
f1 = ifft2(F);
figure;
subplot(1,2,1)
imagesc(f1)
title("Denoised Image")
subplot(1,2,2)
imagesc(f)
title("Original Image")
g1 = rand(size(f))*sqrt(0.001) + g;
G1 = fft2(g1);
H = fft2(h,256,256);
F1 = G./H;
f2 = ifft2(F1);
figure;
subplot(1,2,1)
imagesc(f2)
title("Denoised Image")
subplot(1,2,2)
imagesc(f)
title("Original Image")



%% Part 05
close all
clear
clc;
addpath(genpath('.'))
image = imread('t1.jpg');
image = image(:,:,1);
image = double(image);
S2_Q5_Anisotropic_Diffusion