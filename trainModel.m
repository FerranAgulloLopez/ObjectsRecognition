function trainedModel = trainModel(trainingDataset,prediction,type)
    switch type
        case 'Tree'
            trainedModel = TreeBagger(100,trainingDataset,prediction);
        case 'Knn'
            trainedModel = fitcknn(trainingDataset,prediction,'NumNeighbors',11);
        otherwise
            trainedModel = fitcnb(trainingDataset,prediction);
    end
end

