# Signal and Medical Image Processing Lab  
**Experiment 8: Medical Image Denoising**

The homework focuses on applying various noise reduction techniques on medical images, such as MRI, which are often affected by Gaussian, Speckle, and other types of noise. Key methods include **median filtering**, **Gaussian smoothing**, **windowed averaging**, and **deconvolution** for restoring medical images.

## Table of Contents

- [Project Overview](#project-overview)
- [Noise Types and Denoising Techniques](#noise-types-and-denoising-techniques)
- [Questions Overview](#Questions-Overview)


## Project Overview

In this homework, we aim to understand and implement various denoising algorithms used in medical imaging, with a focus on:

- **Speckle noise**: A granular noise that appears in coherent imaging systems such as ultrasound and SAR.
- **Gaussian noise**: A common noise that affects both real and imaginary parts of MRI images, also known as Rician noise.
- **Deconvolution**: A technique to reverse the blurring effects of the Point Spread Function (PSF) in medical imaging devices.

The goal is to restore noisy medical images using different denoising filters and techniques and analyze their effectiveness.

## Noise Types and Denoising Techniques

1. **Median Filtering**: 
   - Used for removing Salt-and-Pepper noise.
   - Operates by replacing each pixel with the median of its neighboring pixels.

2. **Windowed Averaging**: 
   - Smoothens the image by averaging pixel intensities in a local window.
   - Reduces high-frequency components, but can also cause blurring.

3. **Gaussian Smoothing**:
   - Convolves the image with a Gaussian kernel, offering a more refined smoothing without excessive distortion.

4. **Deconvolution**:
   - Attempts to reverse the blurring effect caused by the PSF using methods such as gradient descent.
   - Essential in recovering original images that have been blurred by medical imaging devices.

## Questions Overview

### Q1: Gaussian Noise Addition and Fourier Filtering

1. Load the `t2.jpg` image from the `S2_Q1_utils/` folder.
2. Add Gaussian noise with variance 15 to the image.
3. Create a square kernel (4x4) in a new binary image, apply normalization, and perform Fourier filtering on the noisy image.
4. Perform Gaussian convolution using `imgaussfilt` and compare the results with the Fourier filtered image.

### Q2: Blurring and Gaussian Convolution

1. Load the `t2.jpg` image from the `S2_Q2_utils/` folder.
2. Apply Gaussian blur with a high variance and visualize the results.
3. Add Gaussian noise to the blurred image and attempt to recover the original image using Fourier techniques.

### Q3: Matrix-Based Deconvolution

1. Create a convolution matrix `D` for a given filter `h`.
2. Simulate filtering of the original image using matrix operations.
3. Add Gaussian noise to the filtered image and recover the original using a matrix-based approach.

### Q4: Gradient Descent Method

1. Implement the Gradient Descent algorithm for image deconvolution.
2. Compare the results of Gradient Descent with the matrix-based approach from Question 3.
3. Analyze the convergence behavior of the Gradient Descent algorithm.

### Q5: Anisotropic Diffusion

1. Study the Anisotropic Diffusion method for noise reduction.
2. Run the provided MATLAB script (`S2_Q5_Anisotropic_Diffusion.m`) and analyze the results.
3. Compare this advanced noise removal method with the techniques used in previous questions.
