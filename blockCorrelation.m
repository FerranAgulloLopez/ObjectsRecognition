function [result] = blockCorrelation(B)
    R = B(:,:,1);
    G = B(:,:,2);
    B1 = B(:,:,3);
    B2 = (R+G+B1)/3;
    glcms = graycomatrix(B2);
    correlation = graycoprops(glcms,'Correlation');
    result=correlation.Correlation;
end

