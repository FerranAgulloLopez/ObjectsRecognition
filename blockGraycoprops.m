function [result] = blockGraycoprops(B)
    result = zeros([1 4]);
    B2=rgb2gray(B);
    glcms = graycomatrix(B2);
    all = graycoprops(glcms,'all');
    result(1)=all.Contrast;
    result(2)=all.Correlation;
    
    if isnan(result(2))
        result(2)=0;
    end
   
    result(3)=all.Energy;
    result(4)=all.Homogeneity;
end
