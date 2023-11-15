n = 10;
data = randi([0,1], 1,n);
PRcode = randi([0,1], 1,n);

m0 = zeros(1, 100);
m1 = ones(1,100);
c0 = zeros(1,10);
c1 = ones(1, 10);

time = 0.01: 0.01:n;
t = 0.01:0.01:1;

msg = [];
code = [];
cdma_mod = [];

for i = 1:n
    if data(i) == 1
        msg = [msg, m1];
    else
        msg = [msg, m0];
    end

    if PRcode(i) == 1
        code = [code, c1];
    else
        code = [code, c0];
    end
end


for i = 1:n
    if data(i) == 1
        cdma_mod = [cdma_mod, xor(m1, code)];
    else
        cdma_mod = [cdma_mod, xor(m0, code)];
    end
end

subplot(2, 3, 1);
plot(time, msg);
title('Message Signal');

subplot(2, 3, 2);
plot(t, code);
title('code signal');

subplot(2, 3, 3);
plot(time, cdma_mod);
title('cdma signal');

M = abs(fft(msg));
CDMA = abs(fft(cdma_mod));

subplot(2, 3, 4);
plot(time, M);
title('message Frequency Spectrum');

subplot(2, 3, 6);
plot(time, CDMA);
title('cdma Frequency Spectrum');

%demodulate

msg_demod = [];

for i = 1:n
    msg_demod = [msg_demod, xor(code, cdma_mod((i-1)*100+1:i*100))];
end


% Frequency spectrum of demodulated signal
Demodulated_Freq = abs(fft(msg_demod));

% Plotting
figure;
subplot(2, 1, 1);
plot(time, msg_demod);
title('Demodulated Signal');

subplot(2, 1, 2);
plot(time,msg);
title('Original Message Bits');

figure;
plot(time, Demodulated_Freq);
title('Demodulated Signal Frequency Spectrum');
