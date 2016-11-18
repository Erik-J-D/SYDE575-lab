function [ new_image ] = Lee_Filter( orig_image, K, lmean )

    org_size = size(orig_image);
    k_size = size(K);
    
    m = org_size(1);
    n = org_size(2);
    m1 = k_size(1);
    n1 = k_size(2);
    
    new_image = zeros(m,n);
    
    row = 1;
    col = 1;
    
    while(row ~= m)
        while(col ~= n+1)
            new_image(row, col) = K(row, col) * orig_image(row, col) + ((1 - K(row, col)) * lmean(row, col));
            col = col + 1 ;
        end
        col = 1;
        row = row + 1 ;
    end
    
end

