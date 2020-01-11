function [result] = blockContrast(B)
    R = B(:,:,1);
    G = B(:,:,2);
    B1 = B(:,:,3);
    B2 = (R+G+B1)/3;
    glcms = graycomatrix(B2);
    contrast = graycoprops(glcms,'Contrast');
    result=contrast.Contrast;
end
