fc = 5; N = 10; Tb = 1;
time = 0:0.001:N*Tb;
Tc = 0.001:0.001:Tb; 
c = sqrt(2/Tb)*sin(2*pi*fc*Tc); 

M = randi([0, 1], 1, N);
Mod = 0; Message = 0;

for i = 1:N
    if M(i) == 1
        Mod = [Mod, c]; 
        Message = [Message, ones(1, 1000)];
    else
        Mod = [Mod, -c]; 
        Message = [Message, zeros(1, 1000)];
    end
end

subplot(4, 1, 1); plot(time, Message); title('Message signal');
subplot(4, 1, 2); plot(time, Mod); title('Modulated signal');

subplot(4, 1, 3); plot(Tc, c); title('Carrier signal'); % Corrected variable name
subplot(4, 1, 4); plot(time, abs(fft(Mod))); title('Frequency domain');


