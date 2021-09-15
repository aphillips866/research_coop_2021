%Function that calculates the applied current
function I = inp(t)

    global howstrong T_MAX;
    global n;
    I = zeros(1,n);
    
    
    
    for i=1:n
        if (t <= T_MAX)
            I(i) = howstrong(i);
        end
    end
    
    

                                