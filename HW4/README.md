# Signal and Medical Image Processing Lab  
**Experiment 4: EEG Signal Patterns and Detection Methods**

## Part 1: Event-Related Potentials (ERP)

### Data
- **File**: `EEG_ERP.mat`
- The dataset contains an EEG signal recorded from a single channel (Pz) in response to a visual stimulus. The signal includes both the background EEG and the Event-Related Potential (ERP) component, specifically the **P300 response**.
- **Sampling Frequency**: 240 Hz
- **Number of Trials**: 2550 trials, each recording 1 second of EEG after stimulus onset.

### Tasks

1. **Averaged Response for Varying Number of Trials**:
   - For \( N = 100:100:2500 \), calculate and plot the averaged response for each number of trials.
   - Compare the resulting plots to observe how the P300 response emerges as \( N \) increases.

2. **Maximum Absolute Amplitude vs. Number of Trials**:
   - For \( N = 1:2550 \), compute and plot the maximum absolute amplitude of the signal as a function of the number of averaged trials.

3. **Root Mean Square (RMS) Error**:
   - For \( N = 1:2550 \), compute the RMS error between the \( i \)-th averaged template and the \( (i-1) \)-th averaged template. Plot this error as a function of \( N \).

4. **Determine Minimum Required Number of Trials**:
   - Based on the results of parts (a), (b), and (c), determine the minimum number of trials needed to reliably extract the P300 response. Denote this number as \( N_{min} \).

5. **Comparative Analysis of Averaged Responses**:
   - Plot and compare the averaged P300 response for:
     - \( N = N_{min} \) (determined in part d)
     - A random selection of \( N_{min} \) trials from the 2550 available trials
     - A random selection of 10% and 90% of the trials.
     - The averaged response for all 2550 trials.
   - Analyze and interpret the results.

6. **Review Real-World P300 Experiments**:
   - Research examples of real-world P300-based experiments, such as Brain-Computer Interfaces (BCIs). How many repetitions of the P300 pattern are typically used in these experiments? Compare these numbers with your results from part (d). Explain any differences.

---

## Part 2: Steady-State Visual Evoked Potential (SSVEP)

### Data
- **File**: `SSVEP_EEG.mat`
- This dataset contains SSVEP EEG signals recorded from six channels (O2, P8, P7, Oz, Pz, O1) with a sampling frequency of 250 Hz. The matrix `Events` contains the stimulus frequencies, and `Event_Samples` contains the time points when each stimulus begins.

### Tasks

1. **Bandpass Filtering**:
   - Apply a bandpass filter to remove frequencies below 1 Hz and above 40 Hz from each channel’s EEG signal.
   - Plot the filtered signal alongside the original signal for each channel.

2. **Segmentation of Data**:
   - Segment the EEG data into 5-second windows corresponding to the 15 trials in the experiment, based on the `Event_Samples`.

3. **Frequency Content Analysis**:
   - For each trial, compute the frequency content of the EEG signals from all six channels using `pwelch` and plot them in a single figure. Use the legend to label each channel.

4. **Comparison of Frequency Content Across Channels**:
   - Investigate whether the frequency content is the same across all channels for a given trial. Explain any differences in the frequency content across channels.

5. **Identifying Dominant Frequency**:
   - Determine the dominant frequency in each trial based on the frequency content of each channel. Identify the frequency peaks and explain why they occur.

6. **Alternative Methods for SSVEP Processing**:
   - Research alternative methods for identifying the dominant frequency in SSVEP signals. List and briefly describe other techniques used for SSVEP signal processing (e.g., canonical correlation analysis, multivariate synchronization index).

---

## Part 3: Event-Related Synchronization/Desynchronization (ERD/ERS)

### Data
- **File**: `FiveClass_EEG.mat`
- The dataset contains EEG signals recorded at 256 Hz from 30 channels during five different mental tasks:
  1. Word formation (mentally forming words starting with a displayed letter)
  2. Mental subtraction (repeated subtraction of a smaller number from a larger one)
  3. Navigation (mentally navigating a familiar place, like a home)
  4. Motor imagery (imagining hand movement)
  5. Motor imagery (imagining foot movement)
  
  The experiment includes a preparation phase (focus on a ‘+’ sign for 3 seconds) and a task phase (7 seconds). There are 200 trials, each labeled by task class.

### Tasks

1. **Bandpass Filtering**:
   - Filter the EEG signals from all channels into the following frequency bands:
     - **Delta**: 1 - 4 Hz
     - **Theta**: 4 - 8 Hz
     - **Alpha**: 8 - 13 Hz
     - **Beta**: 13 - 30 Hz
   - Use a Chebyshev Type I bandpass filter. Plot the original and filtered signals for approximately 5 seconds from the first channel.

2. **Segmentation of Data**:
   - Segment the data into 10-second trials, using the `trial` vector for trial start times.

3. **Power Calculation**:
   - For each trial and frequency band, compute the power (squared amplitude) at each time point for each channel.

4. **Class-Averaged Power**:
   - Based on the trial labels in `y`, separate the trials by class and compute the average power for each channel in each frequency band. You will end up with four tensors representing the average power for each frequency band, with dimensions \( 30 \times 5 \times N \), where \( N \) is the number of samples.

5. **Smoothing the Power Signal**:
   - Smooth the power signal over time for each class, channel, and frequency band using a moving average window. Plot the smoothed signals.

6. **Visualization**:
   - Choose one channel (e.g., CPz) and plot the average power in the 10-second trial window for each frequency band, displaying the five classes on the same plot. Repeat this for all four frequency bands.

7. **Analysis**:
   - Based on the plots, analyze the differences in frequency band power across the five mental tasks. What insights can be drawn from the frequency bands in relation to the different mental tasks?
