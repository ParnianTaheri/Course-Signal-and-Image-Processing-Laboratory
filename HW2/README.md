# Signal and Medical Image Processing Lab  
**Experiment 2: Noise and Artifacts in EEG Signals and Their Removal**

## Objective
In this experiment, we will explore methods to remove noise and artifacts from both simulated and real epileptic EEG signals. Using Independent Component Analysis (ICA), we will investigate noise reduction techniques in both simulated and real-world scenarios.

---

## Part 1: Noise Removal from Simulated Non-Seizure Epileptic EEG Signals

### Data
- The simulated non-seizure epileptic EEG signal data is provided in the `1_Lab2` folder.
- The dataset includes:
  - **Clean Signal**: `X_org` (ground truth EEG data without noise)
  - **Noisy Signal**: `X_noise` (real EEG data with muscle and background noise)

### Tasks

1. **Plot the Clean EEG Signal**:
   - Plot the clean EEG signal (`X_org`) for all 32 channels using the provided functions `plotEEG.m` and `disp_eeg.m`. Adjust the `offset` parameter to enhance signal visibility, and label the time and channels appropriately.

2. **Plot the Noisy EEG Signal**:
   - Plot the noisy EEG signal (`X_noise`). Label the time axis in seconds and appropriately tag each channel.

3. **Add Noise to the Clean Signal at Different SNR Levels**:
   - Combine the clean EEG signal with the noisy signal at different Signal-to-Noise Ratios (SNR):
     - **SNR = -5 dB**
     - **SNR = -15 dB**
   - Plot the noisy signal at **SNR = -15 dB** and compare it to the clean signal.
   - **Explanation of SNR**:
     - SNR formula for multi-channel signals:
       $$
       SNR = 10 \log_{10} \left(\frac{P_{signal}}{P_{noise}}\right)
       $$
     - Where \(P_{signal}\) and \(P_{noise}\) are the power of the signal and noise, respectively.

4. **Apply ICA for Source Separation**:
   - Use a chosen ICA algorithm to extract independent sources from the noisy signal. You can use the `COM2R.m` function (Com2 algorithm) for this purpose.

5. **Select and Retain Desired Sources**:
   - Examine all extracted sources and retain the ones that correspond to the desired (spike) components. Discard the rest.

6. **Reconstruct the Denoised Signal**:
   - Reconstruct the denoised signal by mapping the desired sources back to the sensor domain. Store the denoised signal as `X_den`.

7. **Compare the Denoised Signal with Original Data**:
   - Plot the denoised signal for Channels 13 and 24 alongside the original clean and noisy signals. Compare the performance of the noise removal.

8. **Calculate and Analyze RMSE and RRMSE**:
   - Compute the **Root Mean Square Error (RMSE)** and **Relative RMSE (RRMSE)** for each SNR level. Analyze the results and discuss the efficiency of the noise removal algorithm.
     $$
     RRMSE = \frac{\sum_{i=1}^{N}(x_i(t) - \hat{x}_i(t))^2}{\sum_{i=1}^{N}x_i(t)^2}
     $$

---

## Part 2: Noise Removal from Real Epileptic EEG Signals

### Data
- The folder `2_Lab2` contains four EEG recordings from epileptic patients, with signals sampled at 250 Hz.
- The data includes both seizure and non-seizure periods.

### Tasks

1. **Plot the Time-Domain EEG Signal**:
   - Plot the time-domain EEG signals for the selected channels, ensuring that all channels are labeled appropriately.

2. **Analyze Noise and Artifacts**:
   - Inspect the signal for noise and artifacts. Identify the types of artifacts present (e.g., muscle noise, eye blinks). Can these artifacts be removed using ICA?

3. **Apply ICA to Extract Independent Components**:
   - Apply ICA to the EEG signal using the `COM2R.m` algorithm. Extract independent components and the corresponding mixing matrix.

4. **Plot Time, Frequency, and Spatial Characteristics**:
   - Plot the time-domain, frequency-domain, and spatial characteristics for each component:
     - For time-domain and frequency-domain characteristics, use the rows of the source matrix.
     - For spatial characteristics, use the corresponding columns of the mixing matrix.
     - Use `pwelch.m` for frequency analysis and `plottopomap.m` for spatial mapping.

5. **Select and Retain Desired Sources**:
   - Store the desired sources (non-artifact components) in the `SelSources` vector. Use the following equation to reconstruct the denoised signal:
     ```matlab
     X_rec = A(:,SelSources) * S(SelSources,:);
     ```

6. **Plot and Compare the Denoised Signal**:
   - Plot the denoised EEG signal and compare it to the original signal. Did you select the correct sources? Is the noise removal effective, or should the selection process be refined?

---

This README outlines the key steps involved in **EEG signal denoising using ICA** for both simulated and real epileptic signals. The experiment explores the use of ICA to separate noise from desired signal components, aiming for effective artifact removal in clinical EEG data.
