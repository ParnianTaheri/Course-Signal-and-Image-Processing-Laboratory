close all
clear;
clc;
%% Part 01
close all
clear;
clc;
image_1 = imread("S1_Q1_utils/t1.jpg");
% Plotting the image
figure;
imshow(image_1);
title("Image 1");
image_1 = double(image_1);
signal = image_1(128,:,1);
fft_signal = fft(signal); 
w = linspace(0,2*pi,length(signal));
figure;
subplot(1,2,1);
plot(w,db(abs(fft_signal)));
grid on;
xlabel("\omega (rad/s)")
ylabel("|X(j\omega) dB|")

subplot(1,2,2);
plot(w,angle(fft_signal));
grid on;
xlabel("\omega (rad/s)")
ylabel("\theta (rad)")
% Plotting the 2D fft
fft_image = fftshift(fft2(image_1(:,:,1)));
figure;
subplot(1,2,1)
imagesc(db(abs(fft_image)));
title("Result of 2D Fourier")
subplot(1,2,2)
imagesc(image_1(:,:,1));
title("Original Image")


%% Part 02
close all
clear;
clc;
G = zeros(256,256);
[X,Y] =ndgrid(1:256,1:256);
G((X-128).^2+(Y-128).^2 < 15^2) = 1;
figure;
imagesc(G)
F = zeros(256);
F(120,48) = 2;
F(100,50) = 1;
F_fft = fftshift(fft2(F));
G_fft = fftshift(fft2(G));
H_fft = F_fft.*G_fft;
H = ifft2(ifftshift(H_fft));
figure;
imagesc(H);
title("Result of 2D Convulution")
% Reading Image
image_2 = imread("S1_Q2_utils/pd.jpg");
image_2 = double(image_2);
image_2 = image_2(:,:,1);
fft_image_2 = fftshift(fft2(image_2));
fft_result = fft_image_2 .* G_fft;
result_image = (ifft2(ifftshift(fft_result)));
figure;
subplot(1,2,1)
imagesc(image_2);
title("Original Image")
subplot(1,2,2)
imagesc(result_image);
title("Result of convolution")


%% Part 3
close all
clear;
clc;
image_3 = imread("S1_Q3_utils/ct.jpg");
image_3 = double(image_3);
image_3 = image_3(:,:,1);
fft_image_3 = fftshift(fft2(image_3));
fft_image_3 = padarray(fft_image_3,[128,128]);

result_image = ifft2(ifftshift(fft_image_3));
figure;
subplot(1,2,1)
imagesc(image_3);
title("Original Image");
subplot(1,2,2)
imagesc(abs(result_image(129:384,129:384)));
title("Zoom In Result")


%% Part 4
% Q1
 close all
 clear;
 clc;
 image_4 = imread("S1_Q4_utils/ct.jpg");
 image_4 = double(image_4);
 image_4 = image_4(:,:,1);
 figure;
 imagesc(image_4);
 w_vec = 2*pi/256*(0:255);
 x_vec = exp(-1i*w_vec*20);
 y_vec = exp(-1i*w_vec*40);
 convulution_fft = fft2(image_4) .* x_vec .* (y_vec.');
 convulution_result = ifft2(convulution_fft);
 figure;
 imagesc(abs(convulution_result))
 figure;
 imagesc(abs(x_vec .* (y_vec.')))

% Q2

rotation_result = imrotate(image_4,30);
figure;
subplot(1,2,1)
imagesc(abs(fftshift(fft2(rotation_result))));
title("The FFT of Rotated Image")
subplot(1,2,2)
imagesc(abs(fftshift(fft2(image_4))));
title("The FFT of Original Image")


fft_rotation = imrotate(rotation_result,-30);
figure;
imagesc((fft_rotation))


%% Part 05
close all
clear;
clc;
image_5 = imread("S1_Q5_utils/t1.jpg");
image_5 = double(image_5);
image_5 = image_5(:,:,1);
right_image = circshift(image_5,1,2);
left_image = circshift(image_5,-1,2);
upper_image = circshift(image_5,-1,1);
lower_image = circshift(image_5,1,1);
grad_x = (left_image - right_image)/2;
grad_y = (upper_image - lower_image)/2;
grad_abs = sqrt(grad_x.^2 + grad_y.^2);
figure;
imagesc(right_image)
figure;
imagesc(upper_image)
figure;
imagesc(image_5)
figure;
subplot(2,2,1)
imagesc(image_5)
title("Original Image")
subplot(2,2,2)
imagesc(abs(grad_x))
title("Horizontal Edges")
subplot(2,2,3)
imagesc(abs(grad_y))
title("Vertical Edges")
subplot(2,2,4)
imagesc(abs(grad_abs))
title("Absolute Value of Gradient")


%% Part 06
% Sobel 
close all
clear;
clc;
image_5 = imread("S1_Q5_utils\t1.jpg");
image_5 = double(image_5);
image_5 = image_5(:,:,1);
Gx = conv2([1 0 -1;
    2 0 -2;
    1 0 -1],image_5);
Gy = conv2([1 2 1;0 0 0;-1 -2 -1],image_5);
Gabs = sqrt(Gx.^2+Gy.^2);
figure; 
imagesc(Gabs)
figure;
imagesc(edge(image_5,'sobel'))


% Canny
edge_map = edge(image_5,'canny');
figure; 
imagesc(edge_map)





