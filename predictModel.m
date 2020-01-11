function predictedPixels = predictModel(I,trainedModel,rectangleContenidor,windowSizeX,windowSizeY,type)
    predictedPixels = zeros(size(I(:,:,1)));
    ymin = floor(rectangleContenidor(2));
    xmin = floor(rectangleContenidor(1));
    height = floor(rectangleContenidor(4));
    width = floor(rectangleContenidor(3)); 
    
    for i=ymin:windowSizeY:ymin+height
        for j=xmin:windowSizeX:xmin+width
            B = I(i:i+windowSizeY-1,j:j+windowSizeX-1,:);
            featureVector = computeFeatures(B);
            [test_prediction,score] = predict(trainedModel,featureVector);
            switch type
                case 'Tree'
                    predicted = test_prediction{1};
                otherwise
                    predicted = test_prediction;
            end
            if predicted == 'O'
                predictedPixels(i:i+windowSizeY-1,j:j+windowSizeX-1,:) = 1;
            end
        end
    end
end

