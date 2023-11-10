% Simulation parameters
numBits = 1e6;  % Number of bits to be transmitted
SNR_dB = 0:2:20;  % Signal-to-Noise Ratio (SNR) range in dB
ber = zeros(size(SNR_dB));
per = zeros(size(SNR_dB));

for snrIdx = 1:length(SNR_dB)
    % Generate random bits to transmit
    data = randi([0, 1], 1, numBits);

    % Modulation (e.g., BPSK)
    modulated = 2 * data - 1;

    % AWGN Channel
    SNR = 10^(SNR_dB(snrIdx) / 10); % Convert SNR from dB to linear scale
    noisePower = 1 / SNR;
    noise = sqrt(noisePower) * randn(1, numBits);
    received = modulated + noise;

    % Demodulation
    demodulated = received > 0;

    % Calculate Bit Error Rate (BER)
    ber(snrIdx) = sum(demodulated ~= data) / numBits;

    % Calculate Packet Error Rate (PER)
    % Assuming packet size (P) and error-free detection
    packetSize = 100; % Example: Packet size of 100 bits
    numPackets = numBits / packetSize;
    numErrPackets = sum(reshape(demodulated ~= data, packetSize, numPackets), 1) > 0;
    per(snrIdx) = sum(numErrPackets) / numPackets;

    % Calculate Channel Capacity (Shannon capacity in bits per channel use)
    channelCapacity(snrIdx) = 0.5 * log2(1 + SNR);

    % Calculate Throughput
    throughput(snrIdx) = (1 - per(snrIdx)) * channelCapacity(snrIdx);
end

% Plotting results
figure;

% Plot BER vs SNR
subplot(2, 2, 1);
semilogy(SNR_dB, ber, 'o-');
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('Bit Error Rate vs SNR');

% Plot PER vs SNR
subplot(2, 2, 2);
semilogy(SNR_dB, per, 'o-');
xlabel('SNR (dB)');
ylabel('Packet Error Rate (PER)');
title('Packet Error Rate vs SNR');

% Plot Channel Capacity vs SNR
subplot(2, 2, 3);
plot(SNR_dB, channelCapacity, 'o-');
xlabel('SNR (dB)');
ylabel('Channel Capacity (bps)');
title('Channel Capacity vs SNR');

% Plot Throughput vs SNR
subplot(2, 2, 4);
plot(SNR_dB, throughput, 'o-');
xlabel('SNR (dB)');
ylabel('Throughput (bps)');
title('Throughput vs SNR');
