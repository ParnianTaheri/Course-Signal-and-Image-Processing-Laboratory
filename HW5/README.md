# Signal and Medical Image Processing Lab  
**Experiment 5: ECG Signal Patterns and Detection of Cardiac Arrhythmias**

## Introduction

### Overview of ECG Signal
The Electrocardiogram (ECG) is a surface recording that reflects the electrical activity of the heart. It is widely used for clinical evaluation of heart function and health. This experiment focuses on designing filters and techniques to extract abnormal heart rhythms (Arrhythmias) from the ECG signal.

## Part 1: Frequency Limitation and Noise Reduction of ECG Signal

### Data
- **File**: `normal.mat`
- The data matrix contains two columns: one for the time samples (in seconds) and the other for the ECG signal (in volts).
- **Sampling Frequency**: 250 Hz
- The first four minutes contain clean data (subject lying still), and the last minute introduces noise (subject tensing chest muscles).

### Tasks

1. **Power Spectrum of Clean and Noisy Signals**:
   - Select a 5 to 10-second segment of clean ECG data and analyze its frequency content using the `pwelch` function. Repeat this for a noisy segment.
   - Plot the power spectrum in decibels (dB) and compare the differences between clean and noisy signals in the frequency domain.

2. **Designing a Bandpass Filter**:
   - Design a bandpass filter to reduce noise by removing low-frequency baseline fluctuations and high-frequency noise.
   - Select cutoff frequencies by examining the power spectrum of the signal, ensuring to preserve the main ECG components.
   - Plot the filter's frequency response (in dB) and impulse response (use `stem` for the impulse response).

3. **Filtering the ECG Signal**:
   - Apply the designed filter to the clean and noisy segments of the ECG signal.
   - Analyze how effectively the filter reduces noise while preserving the signal characteristics.

---

## Part 2: Detection of Ventricular Arrhythmias

### Data
The ECG data for this part comes from the MIT-BIH Malignant Ventricular Arrhythmia Database. The signal has been sampled at 250 Hz and quantized to 12 bits.

### Tasks

1. **Analysis of Ventricular Arrhythmias**:
   - Load one or more of the following files:
     - `n_422.mat` - Ventricular fibrillation episode
     - `n_424.mat` - Ventricular fibrillation episode
     - `n_426.mat` - Ventricular fibrillation with noise
     - `n_429.mat` - Ventricular flutter and tachycardia
   - For each file, select segments containing both "normal" rhythms and ventricular arrhythmias.
   - Analyze the frequency content of these segments using `pwelch` and compare the differences between normal and arrhythmic ECG.

2. **Time and Frequency Domain Characteristics**:
   - Investigate the differences between normal and arrhythmic segments in both the time and frequency domains. Plot relevant graphs and describe the differences.

3. **Windowing for Classification**:
   - Segment the ECG data into 10-second windows with 50% overlap (5-second overlap).
   - For each window, assign a label (Normal, VFIB, VT, Noise, or None) based on the provided annotation file.
   - Perform this labeling for the data in `n_422.mat`.

4. **Feature Extraction and Classification**:
   - Extract frequency-based features (such as band power, median frequency, etc.) for each window.
   - Plot histograms of these features for VFIB and Normal classes. Determine if the classes are separable using these features and select a threshold for classification.

5. **Implementation of Ventricular Arrhythmia Detection**:
   - Complete the provided `va_detect.m` function to classify windows using the selected features.
   - For each window, calculate an alarm vector based on the threshold set in the previous step.

6. **Confusion Matrix and Classification Performance**:
   - For each feature, calculate the confusion matrix using the labeled data (VFIB as positive, Normal as negative).
   - Compute the accuracy, sensitivity, and specificity of the detection system.

7. **Morphological and Statistical Features**:
   - Investigate shape-based (morphological) features such as:
     - Maximum and minimum amplitude
     - Peak-to-peak amplitude
     - Mean peak amplitude (using `findpeaks`)
     - Zero-crossing count
     - Variance of amplitudes
   - Calculate histograms of these features for VFIB and Normal classes. Identify which features best separate the two classes.

8. **Final Classification**:
   - Implement the feature-based classification using the selected morphological and statistical features.
   - Compute the confusion matrix, sensitivity, and specificity for this classification.

---

## Additional Tasks and Comparisons

### Apply the Detection System to Different Datasets
- Repeat the process for the second dataset (`n_424.mat`).
- Compare the best detection system from `n_422.mat` with that of `n_424.mat`.

### Cross-Validation
- Test the best detection system from `n_422.mat` on `n_424.mat` and vice versa.
- Apply the detection system to another dataset (e.g., `n_421.mat`, which contains noise but no ventricular arrhythmias). Analyze how well the system handles noisy data without producing false alarms.

### False Alarms and Missed Detections
- Investigate under what conditions the detection system is most likely to produce false alarms or miss detections. Identify any weaknesses in the detection system.

---

This README outlines the steps for designing filters to reduce noise in ECG signals and building a detection system for identifying ventricular arrhythmias. The experiment covers both frequency-domain and morphological analysis, feature extraction, and classification techniques to distinguish between normal and arrhythmic heart rhythms.
