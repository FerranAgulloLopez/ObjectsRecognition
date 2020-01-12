function binary = deleteInteriorHoles(bw)
    IM = zeros(size(bw));
    IM = IM == 1;
    IM(1,1) = 1;
    binary = not(imreconstruct(IM, not(bw)));
end

