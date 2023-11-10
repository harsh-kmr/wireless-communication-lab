clc;
close all;
clear all;

%n=input('Enter the no. of bit : ');
n = 10; % length of bit stream

m = randi([0, 1], 1, n); % input bits
c = randi([0, 1], 1, n); % pseudorandom code

% Message signal points
m0 = zeros(1, 100);
m1 = ones(1, 100);

% Code Signal points
c0 = zeros(1, 10);
c1 = ones(1, 10);

message = [];
for i = 1:n
    if m(i) == 0
        message = [message, m0];
    else
        message = [message, m1];
    end
end

code = [];
for i = 1:n
    if c(i) == 0
        code = [code, c0];
    else
        code = [code, c1];
    end
end

cdma = [];
for i = 1:n
    if m(i) == 0
        cdma = [cdma, xor(m0, code)];
    else
        cdma = [cdma, xor(m1, code)];
    end
end

time = 0.01:0.01:n;
tb = 0.01:0.01:1;

subplot(2, 3, 1);
plot(time, message);
title('Message Signal');

subplot(2, 3, 2);
plot(tb, code);
title('Code Signal');

subplot(2, 3, 3);
plot(time, cdma);
title('CDMA Signal');

M = abs(fft(message));
CDMA = abs(fft(cdma));

subplot(2, 3, 4);
plot(time, M);
title('Message Frequency Spectrum');

subplot(2, 3, 6);
plot(time, CDMA);
title('CDMA Frequency Spectrum');

% Demodulation process
demodulated = [];
for i = 1:n
    if m(i) == 0
        demodulated = [demodulated, xor(m0, cdma((i-1)*100+1:i*100))];
    else
        demodulated = [demodulated, xor(m1, cdma((i-1)*100+1:i*100))];
    end
end

% Frequency spectrum of demodulated signal
Demodulated_Freq = abs(fft(demodulated));

figure;
subplot(2, 1, 1);
plot(time, demodulated);
title('Demodulated Signal');

subplot(2, 1, 2);
stem(m, 'filled');
title('Original Message Bits');

figure;
plot(time, Demodulated_Freq);
title('Demodulated Signal Frequency Spectrum');