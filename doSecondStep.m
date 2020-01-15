function I = doSecondStep(I,image1,image2,type,trainedModel,trainingModel,normalizeValues,numberBlocksY,numberBlocksX,deleted)
    switch type
        case 'Features'
            [nr,nc]= size(I(:,:,1));
            windowSizeY = floor(nr/numberBlocksY);
            windowSizeX = floor(nc/numberBlocksX);
            stuffY = windowSizeY - mod(nr,windowSizeY);
            stuffX = windowSizeX - mod(nc,windowSizeX);
            I = padarray(I, [stuffY stuffX], 'replicate','post');
            [nr,nc]= size(I(:,:,1));
            [oset,bsetaux,predictedBlocks] = predictModel(I,trainedModel,[1 1 (nc-1) (nr-1)],windowSizeX,windowSizeY,trainingModel,normalizeValues,deleted);
            cleaning = predictedBlocks == 1;
            cleaning = deleteInteriorHoles(cleaning);
            figure;imshow(cleaning,[]);
            CC = bwconncomp(predictedBlocks);
            numPixels = cellfun(@numel,CC.PixelIdxList);
            [biggest,idx] = max(numPixels); 
            arrayX = zeros([1 biggest]);
            arrayY = zeros([1 biggest]);
            pixels = CC.PixelIdxList{idx};
            for num = 1:numel(pixels)
                pixel = pixels(num,1);
                arrayX(num) = ceil(pixel/nr);
                arrayY(num) = ceil(mod(pixel,nr));
            end
            xmin = min(arrayX);
            xmax = max(arrayX);
            ymin = min(arrayY);
            ymax = max(arrayY);
        case 'FeaturesAndKeyPoints'
            %not implemented
        otherwise
            %only KeyPoints
            [xmin,xmax,ymin,ymax] = surffAndRansac(image1,image2);
    end
    corrector = 1;
    auxWidth = xmax - xmin;
    auxHeight = ymax - ymin;
    auxX = round((auxWidth*corrector - auxWidth)/2);
    auxY = round((auxHeight*corrector - auxHeight)/2);
    xmin = xmin - auxX;
    xmax = xmax + auxX;
    ymin = ymin - auxY;
    ymax = ymax + auxY;
    
    figure1 = figure;
    axes1 = axes('Parent', figure1);
    hold(axes1,'on');
    imshow(I);
    rectangle('Parent',axes1,'Position',[xmin ymin (xmax-xmin) (ymax-ymin)],'Curvature',0.2,'EdgeColor','r','LineWidth',3)
end

