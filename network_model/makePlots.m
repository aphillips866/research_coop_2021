%%Author: Andrew R. Phillips, Drexel University
%%Email: arp384@drexel.edu
%%Purpose: Creates plots.

function[] = makePlots(H_mag, t_out, x_out, dist, y_out, T0)

    global T_MAX n;
    
    
     %%%%%%%%%%%%%MAG of Order parameter vs. time%%%%%%%%%%%%%%%%
    figure(1)
    plot(t_out, H_mag)
    xlabel('time, t');
    ylabel('|H(t)|');
    title('Order Parameter')
    axis([0 T_MAX 0 1.1]);
  
    
    
    
    %%%%%%%%%%%%%%%%%%%%%HISTOGRAM OF B-DISTRIBUTION%%%%%%%%%%%%%%%
    figure(2)
    subplot(1,2,1);
    histogram(dist);
    
    ylabel('Bifurcation parameter, b');
    
    subplot(1,2,2);
    scatter(linspace(1,n,n), T0, 'filled', 'red');
    xlabel('i');
    title('Unperturbed Period')
    ylabel('T0_i');
    
    
    %%%%%%%%%%%%%%%%%%%%%PHASE PORTRAITS%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure(3);
    for i=1:2:1000
        clf
        hold on
        scatter(x_out(1:n/2,i), y_out(1:n/2,i), 'filled', 'blue');
        scatter(x_out(n/2:n,i), y_out(n/2:n,i), 'filled', 'blue');
        
        xlabel('x');
        ylabel('y');
        axis([-1 1 -1 1]);
        title('Phase plane');
        pause(.01);
        
        drawnow;
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    