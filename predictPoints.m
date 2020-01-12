function predictedPoints = predictPoints(I,expandedEdges,trainedModel,type)
    [nr,nc]= size(I(:,:,1));
    predictedPoints = zeros(size(I(:,:,1)));
    for i=1:nr
        for j=1:nc
            if expandedEdges(i,j) == 1
                B = I(i-2:i+2,j-2:j+2,:);
                featureVector = computeFeatures(B);
                [test_prediction,score] = predict(trainedModel,featureVector);
                switch type
                    case 'Tree'
                        predicted = test_prediction{1};
                    otherwise
                        predicted = test_prediction;
                end
                if predicted == 'O'
                    predictedPoints(i,j,:) = 1;
                end
            end
        end
    end
end

