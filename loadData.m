
L2_out = zeros(1, 110);

sigma_out = linspace(0, .545, 110);

for i=1:110
    
    filename = sprintf('sigma_%.3f', 0.005*(i-1));
    
    load(['data/', filename, '.mat']);
    
    L2_out(i) = L2_norm;
    
    
end

subplot(1,2,2)
scatter(sigma_out, L2_out, 'red');
xlabel('Coupling strength, \sigma');
ylabel('L2 Norm, ||H||');
title('L2 Norm vs. \sigma');
axis([0 .5 0 .5]);

