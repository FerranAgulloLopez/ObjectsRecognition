function [result] = blockHSV(B)
    result=zeros([1 4]);
    B1 = rgb2hsv(B);
    result(1,1) = mean(mean(cos(B1(:,:,1))));
    result(1,2) = mean(mean(sin(B1(:,:,1))));
    result(1,3) = mean(mean(B1(:,:,2)));
    result(1,4) = mean(mean(B1(:,:,3)));
end

