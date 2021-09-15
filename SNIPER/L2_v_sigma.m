%%Author: Andrew R. Phillips, Drexel University, Department of Physics
%%Email: arp384@drexel.edu
%%Dependancies: sniperNW.m, sniper_function.m
%%Purpose: Calculates L2 norm for simulations of a network of SNIPER
%%oscillators in domain sigma = [start, stop] with a step size step. 
%%Plots L2 as a function of the coupling strength



function[] = L2_v_sigma(start, stop, step)
    
    close all;
 
    L2_out = zeros((stop-start)/step, (stop-start)/step);
    sigma_out = zeros(1,(stop-start)/step);
    
    
    
    
    
    sigma = 0;
    
    for i=1:((stop-start)/step)
        disp(sigma)
        L2_out(i) = sniperNW(100, 1, sigma);
        sigma_out(i) = sigma;
        sigma = sigma + step;
        
    end
        
    figure(1);
    plot(sigma_out, L2_out);
    axis([0 1 0 .3]);
    xlabel('\sigma');
    ylabel('L2');
    
    
    
    