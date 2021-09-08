
subplot(3,3,9);
load('data/sigma_0.500.mat');
t_out = linspace(0, 250, 250/.1);
H_mag = H_mag(50/dt:2500);
t_out = t_out(50/dt:2500);
plot(t_out, H_mag);
xlabel('t');
ylabel('|H(t)|');
title('\sigma = 0.500');
axis([50 250 0 1]);