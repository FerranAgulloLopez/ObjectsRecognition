function [featureVector] = computeFeatures(B)
    featureVector = zeros([1 7]);
    featureVector(1:3)=blockMean(B);
    featureVector(4:7)=blockGraycoprops(B);
end

