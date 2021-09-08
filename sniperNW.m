%%Author: Andrew R. Phillips,Drexel University, Department of Physics
%%Email: arp384@drexel.edu
%%Most recent edit: 7/27/21
%%NOTE: requires auxiliary files 'sniper_function.m' and 'find_OP.m'


function L2_norm = sniperNW(number, coupling,param1, param2)

    %% setting up
    
    close all;
    
    
    global b n T_MAX dt sigma R A alpha;
    
    alpha = 0;
    
    n = number;
    
    A = make_A(n,R);
    
    T_MAX = 100;
    
    dt = .1;
    
    
    
    R = n/2; %%all to all coupling; change to 1 for nearest neighbor.
    
    sigma = coupling;
    
    %%for now we'll have equivalent coupling in x and y. Simplifies
    %%equations. 
    
    %% SETTING UP DISTRIBUTIONS FOR B
    
    
    %%%%%%%%%%%%%%%%%%%Unimodal Distribution%%%%%%%%%%%%%%%%%%%%%%%
    mean = param1;
    dist = .05.*randn(200000,1)+mean;
    uni_dist = dist(dist > 1);
    uni_dist = uni_dist(randperm(length(uni_dist)));
    b = uni_dist(1:n)';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%%%%%bimodal distribution%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sd1 = .05; %%%standard deviations of two peaks
    sd2 = .01;
    bi_dist = [sd1.*randn(1000000,1)+param1; sd2.*randn(1000000,1) + param2]; 
    bi_dist = bi_dist(randperm(length(bi_dist)));
    bi_dist = bi_dist(sqrt(bi_dist.^2) > 1);
    left_dist = bi_dist(bi_dist < ((param1+param2)/2));
   
    
    right_dist = bi_dist(bi_dist > ((param1+param2)/2));
    
    %b = [left_dist(1:n/2);right_dist(1:n/2)]' ;
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%Uniform Distribution%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %b = ones(1,n);
    %b = b.*1.05;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %%ICs
    theta0 = zeros(1, n);
    r0 = zeros(1, n);
    
    
    theta0 = 0 + (2*pi) * rand(1, n);
    r0 = ones(1,n);
    
    X0 = [theta0;r0];
    
    X = X0;
    
    %%vectors to store output
    t_out = zeros(1,T_MAX/dt);
    theta_out = zeros(n, T_MAX/dt);
    r_out = zeros(n, T_MAX/dt);
    H_out = zeros(1, T_MAX/dt);
    X;
    
    %% runge-kutta integration
    
    
    
    index  = 1; %%variable specifying where to put output. 
    t = 0;
    tx = tic; %%starting timer. 
    while t < T_MAX
        theta_out(:,index) = X(1,:)';
        r_out(:,index) = X(2,:)';
        
        k1 = sniper_function(t,X);
        k2 = sniper_function((t+dt/2), (X+(dt/2)*k1));
        k3 = sniper_function((t+dt/2), (X+(dt/2)*k2));
        k4 = sniper_function((t+dt), (X+dt*k3));
        
        X = X + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*dt;
        
        %%filling up output vectors.
        t_out(index) = t;
        
        index = index + 1;
        
        %%calculating order parameter.
        H = find_OP(X(1,:));
        H_out(index) = H;
        
        
        
        
        t = t + dt;
        disp(t);
        
        
    end
    
    
    toc(tx) %%stopping timer. 
    
    %% changing coords
    
   x_avg = zeros(1,length(t_out));
   y_avg = zeros(1, length(t_out));
   
   %%avg phase?
   theta_avg = zeros(1, length(t_out));
   for i=1:length(t_out)
        SUM = 0;
        for j=1:n
            SUM = SUM + exp(sqrt(-1)*theta_out(j,i));
        end
        theta_avg(i) = angle(SUM);
        x_avg(i) = cos(theta_avg(i));
        y_avg(i) = sin(theta_avg(i));
    end
            
    
    
   
    %%%%changing to cartesian coords%%%
    x_out = zeros(n, length(t_out));
    y_out = zeros(n, length(t_out));
    
    
    
    for i=1:n
        for j=1:length(t_out)
            [x_out(i,j), y_out(i,j)] = pol2cart(theta_out(i,j), 1);
        end
    end
    
   
    
    
    %% calculating OP
    
    
    H_mag = zeros(1, T_MAX/dt);
    for i=1:length(x_out(1,:))
        H_mag(i) = sqrt(real(H_out(i))^2 + imag(H_out(i))^2);
    end
    
     %% Calculating Period
     
     
    T0 = zeros(1,n);
    for i=1:n
        T0(i) = sqrt(2/(abs(b(i)-1)))*pi;
        
    end
    
    
   
    %% making plots
    makePlots(H_mag, t_out, x_out, uni_dist, y_out, theta_out, T0, x_avg, y_avg, H_out);
    
    
    %filename = sprintf('sigma_%.3f', sigma);
    %disp(filename);
    %L2_norm = findL2(H_mag((50/dt):end));
   % save(['data/', filename, '.mat'], 'H_mag', 'L2_norm');
    
    
    