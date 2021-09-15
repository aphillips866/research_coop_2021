%Author: Andrew R. Phillips, Drexel University
%Purpose: Integrates mean field equation for SNIPER model and plots
%Time series of |R(t)|, the magnitude of the order parameter.

function[] = mean_field(K)

close all;



%%Start with mixing state, |R| = 0


R0 = 0;
R = R0;

T_MAX = 2500;
t = 0;
dt = 0.01;
omega0 = 1.03;
delta = 0.01;

R_out = zeros(1, T_MAX/dt);
rho_out = zeros(1, T_MAX/dt);
t_out = zeros(1, T_MAX/dt);

function rdot = mf_function(R, K)


    magR = sqrt(real(R)^2 + imag(R)^2);
    
    rdot = (K*R*(1 - magR^2))/2 + (1i - (2*1i*omega0 + 2*delta)*R + 1i*R^2)/2;
    
    
    
    
    
end   
index = 0;
while t < T_MAX
    
    index = index + 1;
    t_out(index) = t;
    rdot = mf_function(R, K);
    R = R + rdot*dt;
    rho = sqrt(real(R)^2 + imag(R)^2);
    rho_out(index) = rho;
    R_out(index) = R;
    t = t + dt;
    
    
    
end
    
figure(1)
plot(t_out, rho_out);
xlabel('t');
ylabel('|R|');
axis([0 2500 0 1]);




end
    
   
    
