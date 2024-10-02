# Signal and Medical Image Processing Lab  
**Experiment 3: Separation of Maternal and Fetal ECG Signals**

## Objective
In this experiment, we will perform blind source separation (BSS) to separate maternal ECG (mECG) and fetal ECG (fECG) from mixed signals containing both, along with noise. We will employ two methods:
- **Singular Value Decomposition (SVD)**
- **Independent Component Analysis (ICA)**

The goal is to compare the effectiveness of these methods in separating the signals and assess their performance in terms of signal quality and clinical relevance.

---

## Part 1: Data Overview

### Data Description
- **maternal ECG signal**: `mceg1.dat`
- **fetal ECG signal**: `fecg1.dat`
- **noise signal**: `noise1.dat`

Each file contains a single vector labeled `'recorded'` with units in mV and a sampling frequency of 256 Hz. These signals will be combined to simulate real-world conditions of mixed maternal and fetal ECG with noise.

### Tasks

1. **Plotting the Signals**:
   - Load and plot the three signals: maternal ECG, fetal ECG, and noise, along with the mixed signal (sum of the three). Display all signals in the time domain.

2. **Power Spectrum Analysis**:
   - Compute and plot the power spectrum of the three signals using the `pwelch` function. Compare the frequency content of the maternal and fetal signals. What are the similarities and differences in their frequency content?

3. **Mean and Variance Calculation**:
   - Calculate and report the mean and variance of each signal. Analyze how these values relate to the frequency content of the signals.

4. **Histogram and Kurtosis**:
   - Plot the histogram (using `hist` in MATLAB) to approximate the probability density function (PDF) of each signal. Compute the fourth moment (kurtosis) using the `kurtosis` function to evaluate the Gaussianity of the signals. Can you infer the degree of Gaussianity from these values?

---

## Part 2: Signal Separation using Singular Value Decomposition (SVD)

### Introduction
SVD is a standard method that utilizes second-order statistics to decompose the data. It projects the data onto orthogonal axes with the highest variance. This method is particularly effective in scenarios where the source signals are uncorrelated.

### Tasks

1. **Loading and Plotting Mixed Data**:
   - Load the data from `X.dat` (mixed signal) and use the provided `plot3ch` function to display the three-channel signal. The first plot shows the signals over time, while the second is a scatter plot displaying the variation of one channel relative to the others.

2. **SVD Decomposition**:
   - Perform SVD on the mixed data (`X.dat`) using MATLAB's `svd` function. Decompose the data into three matrices: `U`, `S`, and `V`.
   - Use the provided `plot3dv` function to visualize the columns of matrix `V`. Save the output figure and the SVD matrices.

3. **Analysis of U Matrix**:
   - Plot the first three columns of the `U` matrix. Identify which component corresponds to the maternal signal, fetal signal, or noise. Plot the **eigenspectrum** using the `stem` function and include it in your report.
   - To retrieve clinical relevance, modify the SVD results to retain only the singular value corresponding to the fetal signal, set other singular values to zero, and reconstruct the fetal ECG.

4. **Reconstructed Fetal Signal**:
   - Plot the three recovered fetal sensor channels after reconstructing the signal based on the modified SVD. Evaluate the success of the reconstruction.

---

## Part 3: Signal Separation using Independent Component Analysis (ICA)

### Introduction
ICA is a higher-order statistical technique that separates sources by maximizing their statistical independence. It assumes that the source signals are non-Gaussian and statistically independent.

### Tasks

1. **ICA on Mixed Data**:
   - Apply ICA to the mixed signal using the provided `ica.m` function. Retrieve the matrices `W` (unmixing matrix) and `Z` (independent components). Store both matrices and compute the mixing matrix `A` (inverse of `W`).

2. **Scatter Plot Analysis**:
   - Use `plot3ch` to visualize the scatter plot of the mixed signal, and `plot3dv` to plot the independent components from matrix `Z`. Save the resulting figure.

3. **Analysis of ICA Components**:
   - Plot the first three rows of matrix `Z`. Identify the column in `W` that most accurately represents the fetal signal component. Zero out the remaining columns and reconstruct the fetal ECG from the modified matrices.

4. **Reconstructed Fetal Signal from ICA**:
   - Plot the recovered fetal ECG after ICA. Discuss the success of the ICA method in separating the fetal signal from the mixed data.

---

## Part 4: Comparison of SVD and ICA

1. **3D Scatter Plot Comparison**:
   - Create a 3D scatter plot that includes:
     - Scatter plot of the original mixed signal (`X`)
     - Scatter plot of the reconstructed signals from SVD and ICA
     - Directions of the columns of matrices `V` (SVD) and `W` (ICA)
   - Compare the results visually and compute the angles between the vectors using the `dot` function. Also, calculate the norms of the different axes and compare them.

2. **Reconstructed Signal Comparison**:
   - Plot the recovered fetal ECG signal (from one channel) using both SVD and ICA methods. Compare the performance of both methods relative to the ideal fetal ECG (`fecg2.dat`).

3. **Correlation Coefficient**:
   - Calculate the **correlation coefficient** between the ideal fetal ECG (`fecg2.dat`) and the reconstructed fetal ECG (from both SVD and ICA). Use the `corrcoef` function in MATLAB and compare the results.

4. **Final Comparison**:
   - Summarize the advantages and disadvantages of SVD and ICA. Which method performed better in separating the fetal ECG? Discuss the key factors that influenced the performance of each method.

5. **Key Takeaways**:
   - Highlight the most important insight or lesson learned from this experiment.

---

This README provides step-by-step instructions for separating fetal and maternal ECG signals using **SVD** and **ICA** techniques. The goal is to assess the effectiveness of these methods in source separation and compare their performances in real-world applications.
