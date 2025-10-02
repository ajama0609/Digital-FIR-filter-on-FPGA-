Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1001;             % Length of signal
t = (0:L-1)*T;        % Time vector

t=(0:0.01:10); 
x = sin(10*t); 
y = awgn(x,1,'measured');
plot(t, y);
legend('Original Signal','Signal with AWGN') 

Y=fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1); 

f = Fs/L*(0:(L/2));
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|") 

n = 50;                 % Filter order
f_low = 20;                     
Wn = f_low /(Fs/2);  % Normalize to Nyquist 
bF1 = fir1(n, Wn, 'low');  % Bandpass FIR filter
%filterAnalyzer(bF1,MagnitudeMode="squared")   
w = filter(bF1, 1, y); 
plot(t, y, 'r');          % original noisy signal
hold on
plot(t, w, 'b', 'LineWidth', 2);  % filtered signal
legend('Noisy Signal', 'Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
title('FIR Filter Applied to Signal');

y = y / max(abs(y));  % now all samples are in [-1,1]

% Assume bF1 is already designed
coeffs = fi(bF1, 1, 16, 15);  
% Assume bF1 is already designed
data = fi(y, 1, 16, 15);    

data_int = data.int;       
coeff_int = coeffs.int; 


% Save to text files
writematrix(data_int, 'data.txt', 'Delimiter',';');
writematrix(coeff_int, 'coeffs.txt', 'Delimiter',';'); 

fid = fopen('data.mem','w');
fprintf(fid, '%d\n', data_int);  % writes one value per line
fclose(fid);

fid = fopen('coeffs.mem','w');
fprintf(fid, '%d\n', coeff_int);
fclose(fid);







