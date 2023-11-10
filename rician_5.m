num_samples = 1000;
snr_dB = 20;
t = linspace(0, 1, num_samples);

% LOS component (deterministic signal)
K = 10; % Rician K-factor
los_signal = sqrt(K / (K + 1)) * sin(2 * pi * 10 * t); % LOS component

% Generate a Rayleigh fading channel (complex Gaussian noise)
multipath_signal = sqrt(1 / (K + 1)) * (randn(1, num_samples) + 1i * randn(1, num_samples)); % Multipath component
received_signal = los_signal + multipath_signal;

subplot(2,1,1);
plot(t, abs(los_signal), 'b-', 'LineWidth', 2, 'DisplayName', 'LOS Component');
xlabel('Time');
ylabel('Amplitude');
hold on;

subplot(2,1,2);
plot(t, abs(received_signal), 'LineWidth', 2, 'DisplayName', 'Received Signal (with Rician fading)');
xlabel('Time');
ylabel('Amplitude');
legend('Location', 'best');
grid on;
title('LOS and Multipath Components with Rician Fading')
