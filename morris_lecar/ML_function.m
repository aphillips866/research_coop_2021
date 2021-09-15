%%Calculates xdot for a single neuron.
function xdot = ML_function(t,x)
    
    global n g;
    
    %Setting up adjacency matrix. Here it's all ones. (unless i=j, because
    %it doesn't make sense for a neuron to be connected to itself.)
    A = ones([n,n]);
    for i=1:n
        for j=1:n
            if i==j
                A(i,j)=0;
            end
            
            
        end
    end
    
    
    
    %each iteration we calculate the current (pretty easy, its just
    %constant over whatever interval we choose)
    I = inp(t); 
    
    %Taking first row of x, which is v
    v = x(1, :);   
    
    %Taking second row of x, whcih is N (I had ot do a capital N, because
    %n is already in use for number of neurons.)
    N = x(2, :); 
    
    %%initialize vectors for all the gating variables
    minf = zeros(1,5);
    ninf = zeros(1,5);
    lamw = zeros(1,5);
    
    %Looping through each neuron and calculating the functions.
    for i = 1:n
        minf(i) = 0.5*(1+tanh((v(i)+1.2)/18));
        ninf(i) = 0.5*(1+tanh((v(i)+5)/7));
        lamw(i) = 0.0075*(cosh((v(i)+5)/(2*7)));
    end
    
    
    %These hold the differential change in v, N
    %Initially empty n-D vectors
    dv = zeros(1, n);
    dn = zeros(1, n);
    
    
    %Looping through the neurons and calcuating the change in its v and N.
    for i=1:n
       
        
        %First I find Iion
        dv(i) = (I(i) - 4.4*minf(i)*(v(i)-120) - 8*N(i)*(v(i)+84) - 2*(v(i)+60));
        dn(i) = lamw(i)*(ninf(i) - N(i));
        for j=1:n
            
            %then I tag the coupling term on after (easier)
            dv(i) = dv(i) + (g/n)*A(i,j)*(v(j) - v(i));
        end
        
        %Then at the end I divide every thing by the capacitance
        dv(i) = dv(i)/20;
    end
    
  
    %Function outputs a matrix with all our dv's and dn's.
    xdot = [dv; dn];
    