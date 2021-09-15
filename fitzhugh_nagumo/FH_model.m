%Author: Andrew R. Phillips
%Purpose: Simulates a network of Fitzhugh Nagumo neurons. 


function[]= FH_model(param)
    %%global variables
    
    global a howlong delay T_MAX;
    
    a = param;
    howlong = 500;
    delay = 0;
    
    T_MAX = 50;
    t = 0;
    dt = 0.01; %time step
   
    t_out = [];
   
    
    
    close all;
    X0 = [1; -1]';
    X = X0;
    x_out = [];
    y_out = [];
    
    
    
    
    %euler integration for now.
    while t < T_MAX
        
        k1 = sniper_function(t,X);
        k2 = sniper_function((t+dt/2), (X+(dt/2)*k1));
        k3 = sniper_function((t+dt/2), (X+(dt/2)*k2));
        k4 = sniper_function((t+dt), (X+dt*k3));
        X = X + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*dt;
        x = X(1);
        y = X(2);
        
        x_out = [x_out x];
        y_out = [y_out y];
    
       
        t = t + dt;
        t_out = [t_out t];
        
        
    end  
    
    
   
    figure(1);
   
    plot(x_out, y_out);
    grid on;
    axis([-2 2 -2 2]);
    
    figure(2);
  
    plot(t_out, x_out);
  
    axis([0 T_MAX -5 5]);
    xlabel('time, t');
    ylabel('Activator variable, u');
    
   
   
function Xdot = sniper_function(t,X)
        
    global a;
    
    
   
    u = X(1);
    v = X(2);
        
       
    %%differential eqns
    udot = u - (u^3)/3 - v;
    vdot = u + a;
    
    
    Xdot = [udot vdot]';
    
    
    

    
    
    



    

    
        
        
    
