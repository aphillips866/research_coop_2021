function L2_norm = findL2(H_mag)
    
    
    SUM = sum(H_mag);
    
    H_avg = (1/length(H_mag))*SUM;
    
    SUM_DIFFS = 0;
    
    
    
    for i=1:length(H_mag)
        
        SUM_DIFFS = SUM_DIFFS + (H_mag(i) - H_avg)^2;
        
    end
    
    
    L2_norm = sqrt((1/length(H_mag))*SUM_DIFFS);
    
    
    