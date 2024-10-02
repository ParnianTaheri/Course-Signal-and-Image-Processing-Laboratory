# Signal and Medical Image Processing Lab  
**Experiment 1: EEG and ECG Signal Analysis**

## Objective
This experiment involves analyzing EEG and ECG signals in various domains to explore the concepts of signal sampling, Discrete Fourier Transform (DFT), and Short-Time Fourier Transform (STFT). The signals used include EEG data from an epileptic patient and ECG data from MIT-BIH Arrhythmia.

---

## Part 1: EEG Signal Analysis

### Data
- The EEG signal is provided in the `EEG_sig.mat` file, containing a 32-channel matrix (`Z`) and signal metadata (`des`) including the sampling frequency and channel labels.
- The signal is recorded from an epileptic patient during pre-seizure and seizure periods, with muscle artifacts clearly visible.

### Tasks

1. **Plotting Channel 5 (C3) EEG Signal**:
   - Plot the 5th channel’s signal over time, ensuring the time axis is in seconds. Manually adjust the height and width of the plot to clearly display signal variations. Label the vertical axis with the channel name.

2. **Analyzing Signal Characteristics**:
   - Examine the signal’s time-domain features in the following time ranges: 
     - First 15 seconds
     - 18 to 40 seconds
     - 45 to 50 seconds
     - 50 seconds to the end
   - Identify any prominent features in the signal during these intervals.

3. **Plot Another Channel**:
   - Choose another channel to plot and compare its signal with Channel 5. Are the signals consistent across time for both channels?

4. **Displaying EEG Signals for All Channels**:
   - Use the provided code to display EEG signals from all channels:
     ```matlab
     offset = max(max(abs(Z)))/5;
     feq = 256;
     ElecName = des.channelnames;
     disp_eeg(Z, offset, feq, ElecName);
     ```
   - Adjust the `offset` parameter for better visualization. Compare the EEG signal behavior from Channel 5 (C3) with the other channels, noting that Channel C3 is closer to the seizure focus.

5. **Investigating Signal Features**:
   - Analyze the signal from six initial channels and summarize the signal features observed in three marked intervals, as shown in **Figure 1**. These intervals include:
     - Rhythmic spikes before seizure onset (red box)
     - Fast activity (green box)
     - Slower irregular activity (blue box)

6. **Time-Frequency Analysis for Channel 5 (C3)**:
   - Isolate the following 5-second intervals:
     - 2 to 7 seconds
     - 30 to 35 seconds
     - 42 to 47 seconds
     - 50 to 55 seconds
   - Plot the time-domain signal and its DFT for each interval. Adjust the frequency axis to clearly display the signal's frequency content.

7. **Power Spectral Density (PSD) Analysis**:
   - Use the `pwelch` function to compute the PSD of each 5-second interval. Discuss the frequency characteristics of each interval based on the PSD plots.

8. **Spectrogram Analysis**:
   - Perform time-frequency analysis using the `spectrogram` function with the following parameters:
     - Window length (L) = 128
     - Overlap (N) = 64
     - DFT points (`nfft`) = 128
   - Use a Hamming window and analyze the time-frequency characteristics of each 5-second interval.

9. **Downsampling the Signal**:
   - Focus on the second interval (30 to 35 seconds). Reduce the sampling frequency while preserving the frequency content, using an appropriate low-pass filter before downsampling. Plot the time-domain, DFT, and STFT of the downsampled signal, and compare the results with previous sections.

---

## Part 2: ECG Signal Analysis

### Data
- The ECG data is provided in the `ECG_sig.mat` file, containing signals from two leads. These signals are part of the MIT-BIH Arrhythmia database (recording 201).

### Tasks

1. **Plotting ECG Signals**:
   - Plot both channels over time, with the time axis in seconds. Zoom into the signals to observe the changes over time and identify differences in the heartbeat patterns for both channels. Highlight the S, R, Q, P, and T waves on two different heartbeats.

2. **Identifying R-Peaks and Anomalies**:
   - The R-peak timings are provided in `ATRTIMED`, and the anomaly types are listed in `ANNOTD`. Label the type of anomaly for each heartbeat on the plot, using the `text` command.

3. **Morphological Comparison of Heartbeats**:
   - Select one normal heartbeat and one abnormal heartbeat, and compare their morphological characteristics. Briefly describe each anomaly by searching online for information on the specific conditions.

4. **Frequency and Time-Frequency Analysis**:
   - Select two segments, each containing three consecutive heartbeats:
     - One segment with normal heartbeats.
     - One segment with abnormal heartbeats.
   - Perform and compare the frequency and time-frequency analysis for both segments.

---

## Part 3: EOG Signal Analysis

### Data
- The EOG signals are provided in the `EOG_sig.mat` file, containing signals from two channels (left and right eyes).

### Tasks

1. **Plotting EOG Signals**:
   - Plot both EOG signals over time and compare them. Sketch an approximate diagram showing electrode placement relative to the eyes based on the signal shapes. Analyze the information obtained from visual inspection of the time-domain signals.

2. **Frequency and Time-Frequency Analysis**:
   - Perform frequency and time-frequency analysis for both EOG channels. Discuss the signal characteristics based on the time and frequency domains.

---

## Part 4: EMG Signal Analysis

### Data
- The EMG signals are provided in `EMG_sig.mat`, recorded from three individuals using needle electrodes. The signals were originally sampled at 50kHz, but later downsampled to 4kHz. The dataset includes one healthy subject and two subjects with Neuropathy and Myopathy.

### Tasks

1. **Plotting EMG Signals**:
   - Plot the time-domain signals for each subject. Zoom into different sections of the signal and compare the features across individuals.

2. **Frequency and Time-Frequency Analysis**:
   - Perform frequency and time-frequency analysis for each subject's EMG signals and compare the results.

3. **Comparing Neuropathy and Myopathy**:
   - Research Neuropathy and Myopathy online, and explain the results observed in parts 1 and 2 in terms of these medical conditions.

---

This README provides step-by-step instructions for analyzing EEG, ECG, EOG, and EMG signals as part of the **Signal and Medical Image Processing Lab**. Each section includes tasks related to time-domain, frequency-domain, and time-frequency analysis, offering insights into various physiological signals.
