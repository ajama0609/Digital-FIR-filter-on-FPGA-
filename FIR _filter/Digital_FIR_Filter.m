Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 90;             % Length of signal
t = (0:L-1)*T;   

data = load('fir_output.txt');  % load integer values
tap = 10;
frac_bits = 30;  % number of fractional bits in Q2.30

% Convert from fixed-point integer to floating point
data_real = data / 2^frac_bits;

plot(data_real, '-o');
xlabel('Sample Index');
ylabel('FIR Output');
title('10-tap FIR Filter Output');
grid on; 

Y=fft(data_real);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1); 

f = Fs/L*(0:(L/2));
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of FIR")
xlabel("f (Hz)")
ylabel("|P1(f)|") 
