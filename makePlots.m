function[] = makePlots(H_mag, t_out, x_out, uni_dist, y_out, theta_out, T0, x_avg, y_avg, H_out)

    global dt T_MAX n;
    
    
     %%%%%%%%%%%%%MAG of Order parameter vs. time%%%%%%%%%%%%%%%%
    figure(1)
    plot(t_out(50/dt:end), H_mag(50/dt:end))
    xlabel('time, t');
    ylabel('|H(t)|');
    title('Order Parameter')
    axis([50 T_MAX 0 1.1]);
  
      
    
    
    %%%%%%%%%%%%%%Order parameter in Complex Plane%%%%%%%%%%%%%
    figure(2)
    myVideo = VideoWriter('7_9_v2');
    myVideo.FrameRate = 7;
    open(myVideo);
    
    for i=1:length(t_out)
        
        quiver(0, 0, real(H_out(i)), imag(H_out(i)));
        xlabel('Re(H)');
        ylabel('Im(H)');
        title('Complex Plane');
        axis([-1 1 -1 1]);
        frame=getframe(gcf);
        writeVideo(myVideo, frame);
        drawnow
        
    end
    close(myVideo);    
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%X VARIABLE TIME SERIES%%%%%%%%%%%%%%%%%%%
    figure(2)
    
    hold on;
    for i=1:n
        p = plot(t_out, x_out(i,:));
        p.Color = [rand rand rand];
    end
    
    axis([0 T_MAX -2 2]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%%%%%%%%%%%%%%%%%%%%HISTOGRAM OF B-DISTRIBUTION%%%%%%%%%%%%%%%
    figure(3)
    subplot(1,2,1);
    histogram(uni_dist, 1000);
    
    ylabel('Bifurcation parameter, b');
    
    subplot(1,2,2);
    scatter(linspace(1,n,n), T0, 'filled', 'red');
    xlabel('i');
    title('Unperturbed Period')
    ylabel('T0_i');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4);
    subplot(1,2,1);
    scatter(x_out(1:n,100), y_out(1:n,100), 'filled', 'blue');
        
    xlabel('x');
    ylabel('y');
    axis([-1 1 -1 1]);
    
    subplot(1,2,2);
    scatter(x_out(1:n,200), y_out(1:n,200), 'filled', 'blue');
        
    xlabel('x');
    ylabel('y');
    axis([-1 1 -1 1]);
    
    
    %%%%%%%%%%%%%%%%%%%%%PHASE PORTRAITS%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(5);
    myVideo = VideoWriter('7_9_v1');
    myVideo.FrameRate = 7;
    open(myVideo);
    for i=500:1000
        clf
        hold on
        scatter(x_out(:,i), y_out(:,i), 'filled', 'blue');
        plot(x_avg(i), y_avg(i), '.', 'MarkerSize', 50);
        
        
        
        
        xlabel('x');
        ylabel('y');
        axis([-1 1 -1 1]);
        title('Phase plane');
        pause(.01);
        frame=getframe(gcf);
        writeVideo(myVideo, frame);
        drawnow;
        
    end
    close(myVideo);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%PHASE EVOLVING IN TIME%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure(6);
    %myVideo = VideoWriter('7_9_v2');
    %myVideo.FrameRate = 7;
    %open(myVideo);
    for i=500:2:1000
        
        scatter(linspace(1, n, n),theta_out(:,i), 'filled');
        xlabel('i');
        ylabel('\theta_i');
        yticks([0 pi 2*pi])
        yticklabels({'0','\pi','2\pi'})
        title('Phase');
        axis([0 n 0 2*pi]);
        %frame=getframe(gcf);
        %writeVideo(myVideo, frame);
        %drawnow;
    end
    %close(myVideo);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    