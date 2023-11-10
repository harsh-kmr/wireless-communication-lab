Tb = 1;
N = 10;
FC1 = 10;
FC2 = 5;
time = 0:0.001:N * Tb;
Tc = 0.001:0.001:Tb;

C1 = sqrt(2 / Tb) * sin(2 * pi * FC1 * time);
C2 = sqrt(2 / Tb) * sin(2 * pi * FC2 * time);

M = randi([0, 1], 1, N);
Mod = 0;
Message = 0;

for i = 1:N
    if M(i) == 1
        Mod = [Mod, sqrt(2 / Tb) * sin(2 * pi * FC1 * Tc)];
        Message = [Message, ones(1, 1000)];
    else
        Mod = [Mod, sqrt(3 / Tb) * sin(2 * pi * FC2 * Tc)];
        Message = [Message, zeros(1, 1000)];
    end
end

subplot(5, 1, 1); plot(time, Message); title('Message signal');
subplot(5, 1, 2); plot(time, Mod); title('Modulated signal');
subplot(5, 1, 3); plot(time, C2); title('Carrier signal 2');
subplot(5, 1, 4); plot(time, C1); title('Carrier signal 1');
subplot(5, 1, 5); mag = abs(fft(Mod)); plot(mag); title('Magnitude Spectrum of Modulated signal');
