%IMPORTANT VARIABLES
numberBlocksY = 100;
numberBlocksX = 100;
fileName = 'Eagle1.png';
trainingModel = 'Bay'; % Tree | Knn | Bay

%MAIN CODE
I=imread(fileName);
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
trainingDataset = zeros([numberBlocks 9]);
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
predictedPixels = predictModel(I,trainedModel,rectangleContenidor,windowSizeX,windowSizeY,trainingModel);

imshow(predictedPixels,[]);
imshow(I,[]);

