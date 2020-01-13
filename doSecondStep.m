function I = doSecondStep(I,image1,image2,secondStepType)
    original = image2;
    distorted = image1;
    ptsOriginal  = detectSURFFeatures(original);
    ptsDistorted = detectSURFFeatures(distorted);
    %ptsOriginal  = detectHarrisFeatures(original);
    %ptsDistorted = detectHarrisFeatures(distorted);
    [featuresOriginal,validPtsOriginal] = extractFeatures(original,ptsOriginal);
    [featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);
    index_pairs = matchFeatures(featuresOriginal,featuresDistorted,'MaxRatio',0.9,'MatchThreshold',80);
    matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
    matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
    
    %figure; 
    %showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);
    %title('Matched SURF points,including outliers');
    
    [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity');
    
    %figure; 
    %showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted);
    %title('Matched inlier points');
    
    [nr,nc]= size(ptsDistorted.Location);
    arrayX = zeros([1 nr]);
    arrayY = zeros([1 nr]);
    for k = 1:nr
        x = ptsDistorted.Location(k,1);
        y = ptsDistorted.Location(k,2);
        [X,Y] = transformPointsForward(tform,x,y);
        arrayX(1,k) = X;
        arrayY(1,k) = Y;
    end
    
    correctorMin = 0.9;
    correctorMax = 1.1;
    xmin = min(arrayX)*correctorMin;
    xmax = max(arrayX)*correctorMax;
    ymin = min(arrayY)*correctorMin;
    ymax = max(arrayY)*correctorMax;
    
    %figure;
    imshow(I);
    rectangle('Position',[xmin ymin (xmax-xmin) (ymax-ymin)],'Curvature',0.2,'EdgeColor','r','LineWidth',3)
end

