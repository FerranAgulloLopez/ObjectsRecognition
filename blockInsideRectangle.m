function [result] = blockInsideRectangle(block,rectangle,threshold)
     pointTopLeft = [block(1) block(2)];
     pointTopRight = [(block(1)+block(3)) block(2)];
     pointBottomLeft = [block(1) (block(2)+block(4))];
     pointBottomRight = [(block(1)+block(3)) (block(2)+block(4))];
     
     points=[pointTopLeft; pointTopRight; pointBottomLeft; pointBottomRight];
     found=false;
     cont=1;
     
     while (~found) & (cont<=4)
        point = points(cont,:);
        found = pointInsideRectangle(point,rectangle);
        cont = cont+1;
     end
   
     if found 
         inside=0;
         for x=block(1):block(1)+block(3)
            for y=block(2):block(2)+block(4)
                if pointInsideRectangle([x y],rectangle)
                    inside = inside + 1;
                end 
            end
         end
         p=inside/(floor(block(3))*floor(block(4)));
         result = p > threshold;
     else 
         result =false;
     end
end

function [result] = pointInsideRectangle(point,rectangle)
   result = point(1)>rectangle(1) & point(1)<(rectangle(1)+rectangle(3)) & point(2)>rectangle(2) & point(2)<(rectangle(2)+rectangle(4));
end
