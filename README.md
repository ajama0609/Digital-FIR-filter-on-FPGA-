# Signal Processing Project

This project demonstrates the process of filtering a noisy sine wave using a 10th order FIR filter, starting from the raw signal, analyzing its frequency components, and finally implementing the filter in hardware.

---

## Noisy Signal
<img width="752" height="386" alt="Noisy Signal" src="https://github.com/user-attachments/assets/b1c20be4-2340-4868-8b12-a2caaa565678" />

We begin with a **noisy sine wave**, which represents a clean sine signal contaminated with random noise. This initial signal illustrates the challenge of separating the underlying waveform from unwanted disturbances.

---

## Single-Sided FFT of Noisy Signal
<img width="751" height="393" alt="Single-Sided FFT" src="https://github.com/user-attachments/assets/b3e11fad-647e-4cbd-bbbe-2383dc3d1c44" />

The **single-sided FFT spectrum** of the noisy signal shows the dominant frequency of the sine wave as a sharp peak, while the noise appears as smaller components across the spectrum. This analysis helps in designing an appropriate filter to target the noise without distorting the desired signal.

---

## 10th Order FIR Filter
<img width="750" height="447" alt="10th Order FIR Filter" src="https://github.com/user-attachments/assets/960b754c-cc4c-45f5-9ccd-4eca24f6f2bc" />

A **10th order FIR filter** is designed to attenuate unwanted frequencies while preserving the primary sine wave. The filter coefficients are chosen to balance noise reduction and signal fidelity.

---

## Filtered Signal in MATLAB
<img width="749" height="403" alt="Filtered Signal MATLAB" src="https://github.com/user-attachments/assets/58ba7f29-44a9-4d54-a276-6a8e12af5df7" />

After applying the FIR filter, the signal shows a much cleaner waveform. Most of the noise is removed, effectively recovering the original sine wave.

---

## Verilog Implementation of FIR Filter
<img width="756" height="350" alt="FIR Filter Verilog" src="https://github.com/user-attachments/assets/8c25dea8-b9f9-44b4-a1a4-19755324dac4" />

The FIR filter is implemented in **Verilog** for hardware deployment. Shift registers are used to store input samples, and convolution with the filter coefficients produces the filtered output in real-time.

---

## Filtered Signal from FPGA (Verilog)
<img width="748" height="391" alt="Filtered Verilog Signal" src="https://github.com/user-attachments/assets/961e566d-506a-447d-863a-8128c8c62214" />

The filtered signal from the FPGA shows that the largest peak is at **11 Hz**, compared to **15.9 Hz** in MATLAB. This corresponds to a small percentage error, which is reasonable for low-frequency applications.

---

## Single-Sided FFT of Filtered Verilog Signal
<img width="748" height="391" alt="FFT Filtered Verilog" src="https://github.com/user-attachments/assets/ff160156-450e-4c25-99d7-7a824edfd004" />

The FFT of the filtered Verilog signal confirms the noise has been significantly reduced, and the main frequency component is preserved.

---

This project demonstrates the full workflow from noisy signal analysis to FIR filter design, implementation in MATLAB, and hardware deployment using Verilog, illustrating both theoretical and practical aspects of digital signal processing.
