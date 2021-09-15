%%Author: Andrew R. Phillips,Drexel University, Department of Physics
%%Email: arp384@drexel.edu
%%Dependancies: sniper_function.m, makePlots.m
%%Function: 
%{
Takes a number of oscillators, the coupling strength,
and a mean and simulates a network of SNIPER oscillators
with system size 'number' = N and coupling strength 'coupling'=sigma between
oscillators, with intrinsic frequencies drawn from a cauchy distribution 
with center 'mean' = eta0. Calculates the order parameter of the system
at each time step and returns the norm of the order parameter.
%}

%%MAIN
function L2_norm = sniperNW(number, coupling, mean)
    %% SETTING UP GLOBAL VARIABLES
    
    close all; %closing any plots that are open
    
    
    global b n T_MAX dt sigma R A alpha;
    
    alpha = 0; %phase lag parameter; don't really use
    
    n = number;
    
    
    
    T_MAX = 100;
    
    dt = .1;
    
    
    
    R = n/2; %%all to all coupling
    
    sigma = coupling;
    
    
    %% Creating adjacency matrix
    A = zeros(n,n);
    for i=1:n
        for j=1:n
            if i==j
                for k=(j-R):(j+R)
                    index = mod((k + n), n);
                    if index == 0
                        index = n;
                    end
                    A(i, index) = 1;
                end
            end
            
        end
        
    end
    for i=1:n
        for j=1:n
            if i==j
                A(i,j) = 0;
            end
        end
    end
   
    
    
    
    %% SETTING UP DISTRIBUTION OF INTRINSIC FREQUENCIES
    
    %%%%Cauchy distribution with mean eta0 and width delta%%%%
    
    eta0 = mean;

    delta = 0.01;

    dist = eta0+delta*tan(pi*(randn(1000,1)-0.5));
    
    b = dist(1:n); %b takes on first n values in dist

    
    
    %% INITIAL CONDITIONS
    theta0 = 0 + (2*pi) * rand(1, n);
    
    r0 = ones(1,n); 
    
    X0 = [theta0;r0];
    
    X = X0;
    
    %% INITIALIZING OUTPUT VECTORS
    
    t_out = zeros(1,T_MAX/dt);
    theta_out = zeros(n, T_MAX/dt);
    r_out = zeros(n, T_MAX/dt);
    H_out = zeros(1, T_MAX/dt);

    
    %% runge-kutta integration
    
    index  = 1;
    
    t = 0;
    
    while t < T_MAX
        theta_out(:,index) = X(1,:)';
        r_out(:,index) = X(2,:)';
        t_out(index) = t;
        
        k1 = sniper_function(t,X);
        k2 = sniper_function((t+dt/2), (X+(dt/2)*k1));
        k3 = sniper_function((t+dt/2), (X+(dt/2)*k2));
        k4 = sniper_function((t+dt), (X+dt*k3));
        
        X = X + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*dt;
    
  
        %%calculating order parameter.
        H = 0;
        for i=1:n
            H = H + exp(1i*theta_out(i, index));
        end
        H = H/n;
            
        H_out(index) = H;
        
        
        index = index + 1;
        t = t + dt;
        disp(t);
        
        
        
    end
    
   
    %% CHANGING FROM POLAR TO CARTESIAN
    
    
    x_out = zeros(n, length(t_out));
    y_out = zeros(n, length(t_out));
    
    for i=1:n
        for j=1:length(t_out)
            theta_out(i,j) = mod(theta_out(i,j), 2*pi);
        end
    end
    for i=1:n
        for j=1:length(t_out)
            x_out(i,j) = r_out(i,j)*cos(theta_out(i,j));
            y_out(i,j) = r_out(i,j)*sin(theta_out(i,j));
        end
    end
   
    %% CALCULATING MAGNITUDE OF H
    
    
    H_mag = zeros(1, T_MAX/dt);
    for i=1:length(x_out(1,:))
        H_mag(i) = sqrt(real(H_out(i))^2 + imag(H_out(i))^2);
    end
    
     %% APPROXIMATING PERIOD
     
     
    T0 = zeros(1,n);
    for i=1:n
        T0(i) = sqrt(2/(abs(b(i)-1)))*pi;
        
    end
    
    
    %% COMPUTING L2-NORM
    
    SUM = sum(H_mag);
    
    H_avg = (1/length(H_mag))*SUM;
    
    SUM_DIFFS = 0;
    
    
    
    for i=1:length(H_mag)
        
        SUM_DIFFS = SUM_DIFFS + (H_mag(i) - H_avg)^2;
        
    end
    
    
    L2_norm = sqrt((1/length(H_mag))*SUM_DIFFS);
    
    
   
    %% PLOTS
    
    makePlots(H_mag, t_out, x_out, dist, y_out, theta_out, T0);
    
    
    
    
    
