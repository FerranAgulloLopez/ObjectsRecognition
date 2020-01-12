function [I,objectImage] = doFinalImage(I,bw)
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
    SE = strel('disk',2,6);
    aux = imerode(bw,SE);
    perimeter = xor(aux,bw);
    
    [nr,nc]= size(I(:,:,1));
    objectImage = uint8(zeros(size(I)));
    pixels = CC.PixelIdxList{maxIndex};
    for num = 1:numel(pixels)
        pixel = pixels(num,1);
        j = ceil(pixel/nr);
        i = ceil(mod(pixel,nr));
        objectImage(i,j,1) = I(i,j,1);
        objectImage(i,j,2) = I(i,j,2);
        objectImage(i,j,3) = I(i,j,3);
        if perimeter(i,j) == 1
            I(i,j,1) = 255;
            I(i,j,2) = 0;
            I(i,j,3) = 0;
        end
    end
end

