d = 1:10:1000;
h_t = 10;
h_r = 2;
p_t = 100;
G_t = 0.5;
G_r = 0.5;
PR = zeros(size(d));
PL_dB = zeros(size(d));
for i = 1:length(d)
    PR(i) = p_t * G_t * G_r * (h_t^2 * h_r^2) / d(i)^4;
    PL_linear = p_t / PR(i);
    PL_dB(i) = 10 * log10(PL_linear);
end

% Plot PR and PL_dB
figure;
subplot(2, 1, 1);
plot(d, PR, 'b');
xlabel('Distance (m)' );
ylabel('Received Power (PR) in Watts');
title('Received Power vs. Distance');

subplot(2, 1, 2);
plot(d, PL_dB, 'r');
xlabel('Distance (m)');
ylabel('Path Loss (PL) in dB');
title('Path Loss vs. Distance');

% Display the plot
grid on;
