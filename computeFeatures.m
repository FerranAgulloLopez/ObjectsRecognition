function [featureVector] = computeFeatures(B)
    featureVector = zeros([1 17]);
    featureVector(1:3)=blockMean(B);
    featureVector(4:7)=blockHSV(B);
    featureVector(8:13)=textureFeatures(B);
    featureVector(14:17)=blockGraycoprops(B);
    
end

