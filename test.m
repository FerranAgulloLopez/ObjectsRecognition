function test(tform,ptsOriginal,ptsDistorted,image2,image1)
    %imshow(image1);
    figure;
    imshow(image2);
    [nr,nc]= size(ptsDistorted);
    hold on;
    for k = 1:nr
        x = ptsDistorted(k,1);
        y = ptsDistorted(k,2);
        [X,Y] = transformPointsForward(tform,x,y);
        plot(round(X), round(Y), 'ro', 'MarkerSize', 3);
    end
    hold off;
    
    %T = maketform('projective',H');
    %array = tformfwd(matchLoc2,T);
    %imshow(image1);
    %[nr,nc]= size(array);
    %hold on;
    %for x = 1:nr
    %    i = round(array(x,1));
    %    j = round(array(x,2));
    %    plot(i, j, 'ro', 'MarkerSize', 3);
    %end
    %hold off;
end

