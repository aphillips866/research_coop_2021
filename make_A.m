function A = make_A(n, R)
    %%creating adjacency matrix
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
    A;
    