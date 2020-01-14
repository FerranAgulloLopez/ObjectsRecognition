clear;
%IMPORTANT VARIABLES
numberBlocksY = 100;
numberBlocksX = 100;
fileType = '.png';
fileNameFirstImage = 'Eagle1';
fileNameSecondImage = 'Eagle2';
trainingModel = 'Bay'; % Tree | Bay | Knn | Svm
secondAproximationType = 'Hard'; % Simple | Hard
secondStepType = 'Features'; % KeyPoints | Features | FeaturesAndKeyPoints

I = imread(['images/' fileNameFirstImage fileType]);
imshow(I,[]);
% [xmin ymin width height]
rectangleContenidor = getrect();

[trainedModel,trainingModel,normalizeValues,objectImage,bset,oset,bsetaux] = doFirstStep(I,rectangleContenidor,numberBlocksY,numberBlocksX,trainingModel,secondAproximationType);

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

tset= [bset;oset];

%Correlation
rowNames = {'Red','Green','Blue','HueCos','HueSin','Saturation','Value','Average','AverageContrast','Smoothness','Skewness','Uniformity','Entropy','Contrast','Correlation','Energy','Homogeneity' };
sTable = array2table(tset','RowNames',rowNames);
corrplot(sTable)
meh = corrcoef(tset);

h = heatmap(meh);
h.Title = 'Correlation between features';
h.XLabel = 'Features';
h.YLabel = 'Features';
h.XData = ["Red" "Green" "Blue" "HueCos" "HueSin" "Saturation" "Value" "Average" "AverageContrast" "Smoothness" "Skewness" "Uniformity" "Entropy" "Contrast" "Correlation" "Energy" "Homogeneity"];
h.YData = ["Red" "Green" "Blue" "HueCos" "HueSin" "Saturation" "Value" "Average" "AverageContrast" "Smoothness" "Skewness" "Uniformity" "Entropy" "Contrast" "Correlation" "Energy" "Homogeneity"];


imagesc(meh);
xticklabels = rowNames;
xticks = linspace(1, size(tset, 2), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
yticklabels = rowNames;
yticks = linspace(1, size(tset, 1), numel(yticklabels));
set(gca, 'YTick', yticks, 'YTickLabel', flipud(yticklabels(:)))


