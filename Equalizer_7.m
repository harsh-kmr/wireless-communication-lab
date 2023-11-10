clc;
clear all;

fs = 1000;
t = 0:1/fs:1;
f = 100;
input = sin(2*pi*f*t);
channelDelay = 5;
noisePower = 0.2;

distortedSignal = [zeros(1, channelDelay) input(1:end-channelDelay)] + noisePower * randn(1, length(t));

equalizesignalZF = lin_eq_ZF(distortedSignal, channelDelay);
equalizesignalMLSE = nonlin_eq_mlse(distortedSignal, channelDelay);
equalizesignalAda = Ada_eq(distortedSignal, input, channelDelay);

% Plotting
figure;

subplot(5,1,1);
plot(t, input);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,2);
plot(t, distortedSignal);
title('Distorted Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,3);
plot(t, equalizesignalZF);
title('Equalized Signal (ZF)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,4);
plot(t, equalizesignalMLSE);
title('Equalized Signal (mlse)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,5);
plot(t, equalizesignalAda);
title('Equalized Signal (Ada)');
xlabel('Time (s)');
ylabel('Amplitude');

function output = lin_eq_ZF(input, delay)
    output = zeros(size(input)); 
    for n = delay + 1:length(input)
        output(n) = input(n - delay);
    end
end

function output = nonlin_eq_mlse(input, delay)
    output = zeros(size(input)); 
    for n = delay + 1:length(input)
        output(n) = input(n - delay)^2;
    end
end

function output = Ada_eq(input, desired, filterLength)
    mu = 0.01;
    W = zeros(1, filterLength);
    output = zeros(1, length(input));
    for n = filterLength:length(input)
        r = input(n:-1:n - filterLength + 1);
        y = W * r';
        e = desired(n) - y;
        W = W + 2 * mu * e * r;
        output(n) = y;
    end
end
