function trainedModel = trainModel(trainingDataset,prediction,type)
    switch type
        case 'Svm'
            trainedModel = fitcsvm(trainingDataset,prediction,'CacheSize',500,'Solver','SMO');
        case 'Tree'
            trainedModel = TreeBagger(5,trainingDataset,prediction);
        case 'Knn'
            trainedModel = fitcknn(trainingDataset,prediction,'NumNeighbors',11,'Distance','correlation');
        otherwise
            trainedModel = fitcnb(trainingDataset,prediction);
    end
end

