I=imread('orca.jpg');
figure 
imshow(I,[]);
% [xmin ymin width height]
rectangleContenidor=getrect();

%T=colfilt(I,[5 5],'distinct',@features)
[nr,nc]= size(I(:,:,1));
windowSizeX=nr/100;
windowSizeY=nc/100;
matrix=zeros([nr/windowSizeX nc/windowSizeY 3]);
for i=1:windowSizeX:nr
    for j=1:windowSizeY:nc
        B=I(i:i+windowSizeX-1,j:j+windowSizeY-1,:);
        colourMean = blockMean(B);
        fprintf('Color: %d\n', colourMean);
        if i~=1 && j~=1
            matrix(floor(i/windowSizeX),floor(j/windowSizeY),1)=colourMean(1,1);
            matrix(floor(i/windowSizeX),floor(j/windowSizeY),2)=colourMean(1,2);
            matrix(floor(i/windowSizeX),floor(j/windowSizeY),3)=colourMean(1,3);
        end
        %matrix(mod(i,windowSizeX),mod(j,windowSizeY),1)=colourMean(1,1);
        %matrix(mod(i,windowSizeX),mod(j,windowSizeY),2)=colourMean(1,2);
        %matrix(mod(i,windowSizeX),mod(j,windowSizeY),3)=colourMean(1,3);
    end
end
imshow(uint8(matrix),[]);