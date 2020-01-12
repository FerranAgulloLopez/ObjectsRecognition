function featureVector = textureFeatures(B)
    featureVector=zeros([1 6]);

    grayB=rgb2gray(B);
    p = imhist(grayB);
    p = p./numel(grayB);
    L = length(p);
        
    p = p/sum(p); 
    p = p(:);
    z = 0:(L-1);
    z = z./(L-1);

    m = z*p;
    z = z - m;

    %Average
    featureVector(1,1)=m.*(L-1);
    
    %Average Contrast
    featureVector(1,2)=(((z*(L-1)).^2)*p).^0.5;

    % Smoothness
    varn = (((z*(L-1)).^2)*p)/(L - 1)^2;
    featureVector(1,3) = 1 - 1/(1 + varn);
    
    % Skewness
    featureVector(1,4) = (((z*(L-1)).^3)*p)/(L - 1)^2;
    
    % Uniformity
    featureVector(1,5) = sum(p.^2);
    
    % Entropy
    featureVector(1,6) = -sum(p.*(log2(p + eps)));
end

