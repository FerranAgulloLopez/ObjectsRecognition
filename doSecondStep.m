function I = doSecondStep(I,image1,image2,type)
    switch type
        case 'Features'
            %not implemented
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
    
    %figure;
    imshow(I);
    rectangle('Position',[xmin ymin (xmax-xmin) (ymax-ymin)],'Curvature',0.2,'EdgeColor','r','LineWidth',3)
end

