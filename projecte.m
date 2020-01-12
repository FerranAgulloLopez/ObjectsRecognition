%IMPORTANT VARIABLES
numberBlocksY = 100;
numberBlocksX = 100;
fileName = 'Snow1.png';
trainingModel = 'Bay'; % Tree | Knn | Bay

%MAIN CODE
I=imread(['images/' fileName]);
imshow(I,[]);
% [xmin ymin width height]
rectangleContenidor=getrect();
resultImage = I;

[nr,nc]= size(I(:,:,1));
windowSizeY = floor(nr/numberBlocksY);
windowSizeX = floor(nc/numberBlocksX);
stuffY = windowSizeY - mod(nr,windowSizeY);
stuffX = windowSizeX - mod(nc,windowSizeX);
I = padarray(I, [stuffY stuffX], 'replicate','post');
[nr,nc]= size(I(:,:,1));

numberBlocks = nr/windowSizeY * nc/windowSizeX;
trainingDataset = zeros([numberBlocks 7]);
charBackground = 'B';
charObject = 'O';
prediction = charBackground;

cont = 0;
for i=1:windowSizeY:nr
    for j=1:windowSizeX:nc
        
        cont = cont + 1;
        B = I(i:i+windowSizeY-1,j:j+windowSizeX-1,:);

        featureVector=computeFeatures(B);
        trainingDataset(cont,:)=featureVector;

        if blockInsideRectangle([j i windowSizeX windowSizeY],rectangleContenidor,0.8)
            prediction = [prediction; charObject];
        else
            prediction = [prediction; charBackground];
        end
    end
end
prediction = prediction(2:(numberBlocks+1));

%Train model to differentiate between the two type of blocks
trainedModel = trainModel(trainingDataset,prediction,trainingModel);

%Predict model for the blocks inside the rectangle
predictedBlocks = predictModel(I,trainedModel,rectangleContenidor,windowSizeX,windowSizeY,trainingModel);

firstCleaning = predictedBlocks == 1;
firstCleaning = deleteInteriorHoles(firstCleaning);
firstCleaning = deleteLittleRegions(firstCleaning,windowSizeY,windowSizeX);

[expandedEdges,interior] = expandEdges(firstCleaning,windowSizeY,windowSizeX);

predictedPoints = predictPoints(I,expandedEdges,trainedModel,trainingModel);

aux = or(predictedPoints,interior);
aux = deleteInteriorHoles(aux);
imshow(aux,[]);

finalImage = doFinalImage(I,aux);
imshow(finalImage,[]);




