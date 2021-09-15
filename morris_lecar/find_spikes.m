%%this function finds all the times of spikes. 
function spikes = find_spikes(v_out, t_out)
    
    global n;
    
    %%To find the maxima I store vpp ('v-previous-previous'), vp
    %%('v-previous) and vc ('v-current')
    %%If vpp is less than vp, but vp is greater than vc, we know that vp is
    %%a maximum, so I store vp and the time associated with it. 
    
    vpp = 0;
    vp = 0;
    vc = 0;
    spikes = zeros(n,1);
    
    for i=1:n
        num_spike = 0;
        for j=1:length(v_out(1,:))
            
            vpp = vp;
            vp = vc;
            vc = v_out(i,j);
            
            if (vpp < vp) && (vp > vc)
                num_spike = num_spike + 1;
                spikes(i, num_spike) = t_out(j);
            end
            
        end
        
    end
    
   