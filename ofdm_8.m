m = 4; nfft = 8; cplen = 4; nsym =2;
data = randi([0,m-1],nfft, nsym);
qam_mod = qammod(data, m);
ofdm_mod = ofdmmod(qam_mod, nfft, cplen);

figure;
scatter(real(ofdm_mod(:)), imag(ofdm_mod(:)));
title('Scatter Plot of OFDM Symbols');
xlabel('Real Part');
ylabel('Imaginary Part');

ofdm_demod = ofdmdemod(ofdm_mod, nfft, cplen);
qam_demod = qamdemod(ofdm_demod, m);

figure;
subplot(2,1,1);
plot(qam_demod);
title('Received Data');
subplot(2,1,2);
plot(data);
title('Transmitted Data');
