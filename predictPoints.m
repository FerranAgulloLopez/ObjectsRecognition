function predictedPoints = predictPoints(I,expandedEdges,trainedModel,type,normalizeValues,difficulty,deleted)
    [nr,nc]= size(I(:,:,1));
    predictedPoints = zeros(size(I(:,:,1)));
    for i=1:nr
        for j=1:nc
            if expandedEdges(i,j) == 1
                if goodPoint(i-2,j-2,I) == 1 & goodPoint(i+2,j+2,I) == 1
                    B = I(i-2:i+2,j-2:j+2,:);
                    if strcmp(difficulty,'Simple')
                        expandedEdges(i-2:i+2,j-2:j+2) = 0;
                    end
                    featureVector = computeFeatures(B);
                    normalizedfeatureVector = featureVector;
                    if length(deleted)>1
                        auxdeleted=deleted(2:length(deleted));
                        normalizedfeatureVector(auxdeleted)=[];
                    end
                    for k=1:length(normalizedfeatureVector)
                        value = normalizedfeatureVector(k);
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
                        if strcmp(difficulty,'Simple')
                            predictedPoints(i-2:i+2,j-2:j+2,:) = 1;
                        else
                            predictedPoints(i,j,:) = 1;
                        end
                    end
                end
            end
        end
    end
end

function correct = goodPoint(y,x,image)
    correct = 0;
    [nr,nc]= size(image(:,:,1));
    if x > 0 & x < nc & y > 0 & y < nr
        correct = 1;
    end
end

