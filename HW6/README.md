# Signal and Medical Image Processing Lab  
**Experiment 6: Brain Source Localization**

## Introduction

### Overview
In this experiment, we aim to solve the problem of localizing brain sources using a three-layer spherical head model. The experiment involves calculating the positions of electrodes, simulating dipole placements, and applying the MNE algorithm for source localization. 

### Model Setup
- **Spherical Head Model**: Consists of three layers with radii of 8 cm, 8.5 cm, and 9.2 cm.
- **Electrode Positions**: The normalized positions of the electrodes are provided in the `ElecPosXYZ.mat` file. To find their actual locations, multiply the normalized values by the radius of the outer layer.
- **Dipole Positions**: Dipoles are considered to be placed inside the first layer (upper hemisphere) of the model, and their locations can be defined with desired resolution.

## Tasks

### Part A: Dipole Generation and Lead Field Matrix Calculation
1. **Generate Dipole Positions**:
   - Using the `ForwardModel_3shell.m` function, generate positions for all possible dipoles with a resolution of 1 cm. 
   - Plot the dipoles in 3D space using `scatter3`.
   - Calculate and save the lead field matrix corresponding to these dipoles.

2. **Electrode Position Visualization**:
   - Add the electrode positions to the 3D plot created in the previous step. Label each electrode accordingly.

3. **Random Dipole Selection**:
   - Choose a random location for a dipole and set its direction radially. Mark this dipole's position on the 3D plot from the previous steps.

### Part B: EEG Potential Calculation
4. **Spike Activity Assignment**:
   - Assign a spike activity from a line in the `Interictal.mat` to the selected dipole. Calculate the potential at the 21 electrodes based on the dipole's orientation and the lead field matrix.
   - Plot the potentials over time for all electrodes and include labels next to each plot.

5. **Spike Peak Detection and Averaging**:
   - Identify the time of the positive peak for all spikes at the electrodes. Define a window of 7 points centered around each peak.
   - Store the average potential for all electrodes in a vector around each spike and visualize these potentials using the `Display_Potential_3D.m` function.

### Part C: Inverse Problem Solution Using MNE
6. **Applying the MNE Algorithm**:
   - Implement the MNE algorithm on the electrode potentials calculated in Part B.
   
7. **Estimating Dipole Location**:
   - For each dipole, calculate the estimated moment amplitude. Select the dipole with the highest amplitude and determine its direction.

8. **Error Calculation**:
   - Calculate the error in estimating the dipole location and direction based on the results obtained from the previous step.

### Part D: Parameterized Model Inversion
9. **Estimating Dipole Parameters**:
   - In this section, set up the dipole as a variable for location (or three variables corresponding to the x, y, and z coordinates) and three variables for direction.
   - Use an optimization algorithm, such as genetic algorithms or simulated annealing, to estimate the dipole's location and direction.
   - Minimize the cost function \( ||\mathbf{qG} - \mathbf{m}|| \).

10. **Re-evaluation of Results**:
   - Repeat steps 8 and 9 with this new method, comparing the results with previous estimations.

---

## Final Notes
- Ensure all plots are appropriately labeled with variable names and units (e.g., time in seconds, amplitude in microvolts).
- Save and document your MATLAB code and results for reproducibility and further analysis.
- Analyze the effectiveness of different dipole placements and orientations, comparing the error rates across different configurations.

---

This README provides a structured overview of **Experiment 6: Brain Source Localization**, detailing the objectives and tasks involved in localizing brain sources using EEG signals and the relevant techniques for achieving this goal.
