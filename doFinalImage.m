function finalImage = doFinalImage(I,bw)
    CC = bwconncomp(bw);
    S = regionprops(CC, 'Area', 'Perimeter');

    maxIndex = 1;
    maxArea = 0;
    for x=1:numel(S)
        value = S(x);
        value = value.Area;
        if value>maxArea
           maxIndex = x;
           maxArea = value;
        end
    end
    
    bw = zeros(size(I(:,:,1)));
    bw(CC.PixelIdxList{maxIndex}) = 1;
    %SE = strel('rectangle',[0 1 0; 1 1 1; 0 1 0]);
    aux = imerode(bw,[0 1 0; 1 1 1; 0 1 0]);
    perimeter = xor(aux,bw);
    
    [nr,nc]= size(I(:,:,1));
    finalImage = uint8(zeros(size(I)));
    pixels = CC.PixelIdxList{maxIndex};
    for num = 1:numel(pixels)
        pixel = pixels(num,1);
        j = ceil(pixel/nr);
        i = ceil(mod(pixel,nr));
        if perimeter(i,j) == 1
            finalImage(i,j,1) = 255;
        else
            finalImage(i,j,1) = I(i,j,1);
            finalImage(i,j,2) = I(i,j,2);
            finalImage(i,j,3) = I(i,j,3);
        end
    end
end

