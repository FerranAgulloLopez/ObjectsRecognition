function [oset,bset,predictedPixels] = predictModel(I,trainedModel,rectangleContenidor,windowSizeX,windowSizeY,type,normalizeValues)
    bset = zeros([1 17]);
    oset = zeros([1 17]);
    predictedPixels = zeros(size(I(:,:,1)));
    ymin = floor(rectangleContenidor(2));
    xmin = floor(rectangleContenidor(1));
    height = floor(rectangleContenidor(4));
    width = floor(rectangleContenidor(3)); 
    
    for i=ymin:windowSizeY:ymin+height
        for j=xmin:windowSizeX:xmin+width
            B = I(i:i+windowSizeY-1,j:j+windowSizeX-1,:);
            featureVector = computeFeatures(B);
            normalizedfeatureVector = featureVector;
            for k=1:length(featureVector)
                value = featureVector(k);
                normalizedfeatureVector(k) = (value - normalizeValues(k,1))/(normalizeValues(k,2) - normalizeValues(k,1));
            end
            [test_prediction,score] = predict(trainedModel,normalizedfeatureVector);
            switch type
                case 'Tree'
                    predicted = test_prediction{1};
                otherwise
                    predicted = test_prediction;
            end
            if predicted == 'O'
                oset = [oset;featureVector];
                predictedPixels(i:i+windowSizeY-1,j:j+windowSizeX-1,:) = 1;
            else
                bset = [bset;featureVector];
            end
        end
    end
    bset = bset(2:length(bset),:);
    oset = oset(2:length(oset),:);
end

