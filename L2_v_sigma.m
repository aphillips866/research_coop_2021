function[] = L2_v_sigma(start, stop, step)
    
 
    L2_out = zeros(1, (stop-start)/step);
    sigma_out = zeros(1,(stop-start)/step);
    
    
    
    
    sigma = 0;
    
    for i=1:((stop-start)/step)
        disp(sigma)
        L2_out(i) = sniperNW(500, sigma, 1, 4);
        sigma_out(i) = sigma;
        sigma = sigma + step;
        
    end
        
    
    
    
    
    
    