function [featureVector] = computeFeatures(B)
    featureVector = zeros([1 13]);
    featureVector(1:3)=blockMean(B);
    featureVector(4:9)=textureFeatures(B);
    featureVector(10:13)=blockGraycoprops(B);
end

