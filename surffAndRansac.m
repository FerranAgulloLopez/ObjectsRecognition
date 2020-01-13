function [xmin,xmax,ymin,ymax] = surffAndRansac(image1,image2)
    maxIterations = 1000;
    correct = 0;
    cont = 0;
    while (correct ~= 1) & (cont < maxIterations)
        original = image2;
        distorted = image1;
        ptsOriginal  = detectSURFFeatures(original);
        ptsDistorted = detectSURFFeatures(distorted);
        %ptsOriginal  = detectHarrisFeatures(original);
        %ptsDistorted = detectHarrisFeatures(distorted);
        [featuresOriginal,validPtsOriginal] = extractFeatures(original,ptsOriginal);
        [featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);
        index_pairs = matchFeatures(featuresOriginal,featuresDistorted,'MaxRatio',0.8,'MatchThreshold',80);
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
        
        xmin = min(arrayX);
        xmax = max(arrayX);
        ymin = min(arrayY);
        ymax = max(arrayY);
        
        if goodPoint(xmin,ymin,image2) == 1 & goodPoint(xmax,ymax,image2) == 1
            correct = 1
        end
    end
end

function correct = goodPoint(x,y,image)
    correct = 0;
    [nr,nc]= size(image(:,:,1));
    if x > 0 & x < nc & y > 0 & y < nr
        correct = 1;
    end
end

