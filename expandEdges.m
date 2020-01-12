function [edges,interior] = expandEdges(firstCleaning,windowSizeY,windowSizeX)
    edges = zeros(size(firstCleaning));
    interior = zeros(size(firstCleaning));
    CC = bwconncomp(firstCleaning);
    SE = strel('rectangle',[3*windowSizeY 3*windowSizeX]);
    for x=1:CC.NumObjects
        aux = zeros(size(firstCleaning));
        aux(CC.PixelIdxList{x}) = 1;
        erode = imerode(aux,SE);
        dilate = imdilate(aux,SE);
        aux = xor(erode,dilate);
        edges = or(aux,edges);
        interior = or(erode,interior);
    end
end

