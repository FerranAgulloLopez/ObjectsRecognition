clear;
%IMPORTANT VARIABLES
numberBlocksY = 100;
numberBlocksX = 100;
fileType = '.jpg';
fileNameFirstImage = 'cat-in-the-grass-124276';
fileNameSecondImage = 'cat-jumping-running-grass';
trainingModel = 'Bay'; % Tree | Bay | Knn | Svm
secondStepType = 'Features'; % KeyPoints | Features | FeaturesAndKeyPoints

I = imread(['images/' fileNameFirstImage fileType]);
imshow(I,[]);
% [xmin ymin width height]
rectangleContenidor = getrect();

[trainedModel,trainingModel,normalizeValues,objectImage] = doFirstStep(I,rectangleContenidor,numberBlocksY,numberBlocksX,trainingModel);

imwrite(objectImage,'temporary/1.pgm');
aux = imread(['images/' fileNameSecondImage fileType]);
imwrite(aux,'temporary/2.pgm');

doSecondStep(imread(['images/' fileNameSecondImage fileType]),imread('temporary/1.pgm'),imread('temporary/2.pgm'),secondStepType,trainedModel,trainingModel,normalizeValues,numberBlocksY,numberBlocksX);


%HISTOGRAMAS
bset = [bset;bsetaux];
for i=1:17
    figure
    h1 = histogram(bset(:,i));
    h1.FaceColor=[0.8500 0.3250 0.0980];
    h1.Normalization = 'probability';
    hold on
    h2 = histogram(oset(:,i));
    h2.FaceColor=[0 0.4470 0.7410];
    h2.Normalization = 'probability';
    h2.BinWidth = h1.BinWidth;
    %h1.BinWidth = h2.BinWidth;
end

