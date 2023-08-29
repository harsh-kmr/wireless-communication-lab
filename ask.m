Tb = 1;

N = 10;

fc = 10;

time = 0:0.001:N*Tb;

C = sqrt(2/Tb) * sin(2*pi*fc*time); % Corrected 'tb' to 'Tb'
M = randi([0, 1], 1, N);

Message = 0; % Initialize as empty array

for i = 1:N
    if M(i) == 1
        Message = [Message, ones(1, 1000)];
    else
        Message = [Message, zeros(1, 1000)];
    end
end

Mod = Message .* C; % Corrected 'message' to 'Message'
subplot(4, 1, 1);

plot(time, Message); % Corrected 'message' to 'Message'
title('Message signal');
subplot(4, 1, 2);
plot(time, C);
title('Carrier signal');
subplot(4, 1, 3);
plot(time, Mod);
title('ASK Modulated signal'); % Changed 'Ask' to 'ASK'
subplot(4, 1, 4);
f = abs(fft(Mod));
plot(time, f);
title('Frequency domain');
