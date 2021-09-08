function H = find_OP(theta)

    global n;
    
    H = 0;
    
    for i=1:n
        H = H + exp(sqrt(-1)*theta(i));
    end
    
    H = H/n;