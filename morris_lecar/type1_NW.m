%Author: Andrew Phillips, Drexel University
%Purpose: calculates the voltage time series for a variable sized network
%of Morris-Lecar Neurons. Creates plot of spike times for all neurons.
%Dependancies: ML_function.m, inp.m, find_spikes.m
function[] = type1_NW(number, coupling)
    
   
    %Global variables. We want these to be accessible to all the functions.
    global howstrong;
    global n g dt T_MAX; 
        
    close all; %closing previous plots.
    
    tx = tic; %starting timer
    
    
    n = number; %number of neurons in the network
    
    %%we want a lot of variability in our applied current,
    %%So it'd be useful to place mean near bifurcation point.
    mean1 = 37;
    dist = 2.*randn(200000,1)+mean1;
    howstrong = dist(dist > mean1);
    howstrong = howstrong(randperm(length(howstrong)));
    
    %creating bimodal distribution of currents
    %dist = [10.*randn(500000,1)+mean1; 10.*randn(500000,1) + mean2]; 
    %dist = dist(randperm(length(dist)));
   
    g = coupling;
    
    
    T_MAX = 1000; %Duration of measurement
    dt = .1; %Time step
    
    
    %randomizing ICs
    v0 = 20.*rand(1,n) + -60.855;
    n0 = .01.*rand(1,n) + -0.01495;
    
    
    %Putting IC vectors into composite matrix, x0
    x0 = [v0;n0];
    
    %Initializing t and x. 
    t = 0;
    x = x0;
    
    
    %Lists to store output; what we'll ultimately plot.
    t_out = zeros(1,T_MAX/dt);
    v_out = zeros(n, T_MAX/dt);
    n_out = zeros(n, T_MAX/dt);
    
    
    
    %Runge-Kutta integration
    
    index = 0;
    
    while t < T_MAX
        
        index = index + 1;
        
        k1 = ML_function(t,x);
        k2 = ML_function((t+dt/2), (x+(dt/2)*k1));
        k3 = ML_function((t+dt/2), (x+(dt/2)*k2));
        k4 = ML_function((t+dt), (x+dt*k3));
        
        x = x + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*dt;
        
        t = t + dt;
           
        t_out(index) = t;
        v_out(:,index) = x(1,:)';
        n_out(:,index) = x(2,:)';
        
        if  (T_MAX/4 < t) && (t <  (T_MAX/4 + 2*dt))
            disp('25 percent completion')
        end
        
        if  ((T_MAX/2) <  t) && (t <  (T_MAX/2 + 2*dt))
            disp('50 percent completion')
        end
        
        if  (((3*T_MAX)/4) <  t) && (t <  ((3*T_MAX)/4 + 2*dt))
            disp('75 percent completion')
        end
        
        
    end
    
    
    
    %%FILLING UP 'spikes' matrix with all neurons' times of spikes.
    spikes = find_spikes(v_out, t_out);
    
    
    
    %%%%%%%%%%CREATING PLOTS%%%%%%%%%%%%%%%
    i_plot = zeros(1,n);
    for i=1:n
        i_plot(i) = i;
    end
    
    
    figure(1);
    histogram(howstrong);
    title('Distribution of Applied Currents');
    xlabel('Applied Current, I');
    figure(2)
   
    subplot(1,2,1)
    
    hold on;
    
    
    for i=1:n
        p = plot(t_out, v_out(i,:));
        p.Color = [rand rand rand]; 
        
        
    end
    
    
    axis([0 T_MAX -100 100]);
    xlabel('t (ms)');
    ylabel('V (mV)');
    tit = sprintf('Network of %d Neurons; g = %f', n, g);
    title(tit);
    grid on;
    hold off;
    subplot(1,2,2);
    for j=1:length(spikes(1,:))
       hold on;
       scatter(i_plot, spikes(:,j), 15, [0 0 0],'filled' );
       
       axis([0 n 1 T_MAX]);
       
       xlabel('i');
       ylabel('Time of spike');  
    end
   
   
   fprintf('\nProgram complete; check output.\nElapsed time = %f seconds.\n', toc(tx));
   
   
    
    
    
    
    

    


    
            
            
                
     
                
             
            
            
            

        
    
    
    