# Signal and Medical Image Processing Lab  
**Experiment 7: Medical Image Filtering**

This README provides an overview and instructions for completing the questions in experiment 7, which primarily focuses on image processing techniques using Fourier Transforms, filtering, and transformations in the frequency domain. 

---

## **Q1: Discrete Fourier Transform (DFT) Analysis**

### **Task:**
1. Load the image `t1.jpg` using `imread` from the provided `S1_Q1_utils`.
2. Display the image using `imshow`.
3. Compute the DFT of the image slice using `fft2` and extract the 128th frequency component.
4. Apply `fftshift` to center the low frequencies of the DFT.
5. Display the magnitude spectrum of the Fourier transform using `imshow`.

### **Instructions:**
- Perform DFT on the image slice and visualize the frequency domain.
- Normalize the DFT results for better visualization.
- Use `fftshift` to move the zero frequency component to the center.
- Display the results.

---

## **Q2: Gaussian Filtering in the Frequency Domain**

### **Task:**
1. Create a 2D Gaussian filter `G` using `ndgrid` with standard deviation parameters (`σ = 10`) and size `256x256`.
2. Apply this filter in the frequency domain to an image loaded from `pd.jpg` using the DFT.
3. Display the original, the filtered DFT, and the reconstructed image using `ifft2`.
   
### **Instructions:**
- Use a Gaussian filter to suppress high-frequency components.
- Multiply the Fourier transform of the image by the filter in the frequency domain.
- Apply inverse FFT (`ifft2`) to transform back to the spatial domain.
- Visualize the filtered image and compare it with the original.

---

## **Q3: Zero Padding and Frequency Domain Zoom**

### **Task:**
1. Apply zero-padding to `ct.jpg` to increase its resolution.
2. Perform a zoom-in on the Fourier spectrum of the padded image.
3. Use `fft2` to compute the DFT of the zero-padded image and `ifft2` to reconstruct the image.

### **Instructions:**
- Perform zero-padding on the image in both spatial and frequency domains.
- Visualize how zero-padding affects the resolution and frequency domain representation.
- Compare the results with the original Fourier spectrum.

---

## **Q4_1 & Q4_2: Rotation in Spatial and Frequency Domains**

### **Q4_1 Task:**
1. Load the image `ct.jpg` and rotate it by 30 degrees in the spatial domain.
2. Perform DFT on the rotated image and analyze the result.
3. Visualize both the rotated image and its Fourier transform.

### **Q4_2 Task:**
1. Perform a 30-degree rotation in the frequency domain using the same image.
2. Apply `ifft2` to visualize the spatial result after frequency domain rotation.

### **Instructions:**
- Investigate the effect of rotation both in the spatial and frequency domains.
- Compare how rotation in the two domains influences the image.
- Ensure proper interpolation and display when rotating the image.

---

## **Q5: High-Pass Filtering**

### **Task:**
1. Load the image `t1.jpg`.
2. Apply a high-pass filter to remove low-frequency components.
3. Perform `fft2` on the image, apply the filter, and use `ifft2` to reconstruct the image.
4. Display the original and filtered images.

### **Instructions:**
- Design a high-pass filter in the frequency domain (e.g., a Butterworth or Ideal filter).
- Filter out the low frequencies and visualize the resulting high-frequency content of the image.

---

