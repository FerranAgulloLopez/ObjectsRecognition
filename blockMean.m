function [result] = blockMean(B)
    result=zeros([1 3]);
    result(1,1)=mean(mean(B(:,:,1)));
    result(1,2)=mean(mean(B(:,:,2)));
    result(1,3)=mean(mean(B(:,:,3)));
end

