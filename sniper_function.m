function Xdot = sniper_function(t, X)

    global sigma n b R alpha A;
    
    
    
    theta = X(1, :);
    r = X(2, :);
    
    thetadot = zeros(1,n);
    rdot = zeros(1,n);
   
    for i = 1:n
        
        thetadot(i) = b(i) - r(i)*cos(theta(i));
        rdot(i) = 0;
    
        for j=1:n
                        
            thetadot(i) = thetadot(i) + A(i,j)*((sigma)/(2*R))*sin(theta(j)-theta(i) + alpha);
            
        end 
    end
    
    
    Xdot = [thetadot; rdot];
    
    