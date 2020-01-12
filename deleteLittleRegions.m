function bw = deleteLittleRegions(bw,windowSizeY,windowSizeX)
    SE = strel('rectangle',[2*windowSizeY 2*windowSizeX]);
    bw = imopen(bw,SE);
end

