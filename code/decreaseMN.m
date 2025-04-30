%read image and show it
img = rgb2gray(imread('img.jpg'));
disp(size(img));
figure;
imshow(img);

%decrease number of rows and columns
[r,c] = size(img);
imgDegraded = img(1:4:r, 1:4:c);
disp(size(imgDegraded));
imgDegraded = imresize(imgDegraded, [r,c]);

%show degraded image
%figure;
%imshow(imgDegraded);

%quantize at lower levels
%number of levels: 5
%level offset: 256/5
imgQuantized = zeros(r,c);
lvlOffset = 256/5;
for i = 1:r
    for j = 1:c
        if(img(i,j) <= lvlOffset)
            imgQuantized(i,j) = floor(lvlOffset);
        end
        if(img(i,j) > lvlOffset && img(i,j) <= lvlOffset*2)
            imgQuantized(i,j) = floor(lvlOffset*2);
        end
        if(img(i,j) > lvlOffset*2 && img(i,j) <= lvlOffset*3)
            imgQuantized(i,j) = floor(lvlOffset*3);
        end
        if(img(i,j) > lvlOffset*3 && img(i,j) <= lvlOffset*4)
            imgQuantized(i,j) = floor(lvlOffset*4);
        end
        if(img(i,j) > lvlOffset*4 && img(i,j) <= lvlOffset*5)
            imgQuantized(i,j) = floor(lvlOffset*5);
        end
    end
end
figure;
imshow(imgQuantized,[]);

%quantize at lower levels
%number of levels: 2
%level offset: 256/2
lvlOffset = 256/2;
for i = 1:r
    for j = 1:c
        if(img(i,j) <= lvlOffset)
            imgQuantized(i,j) = floor(lvlOffset);
        end
        if(img(i,j) > lvlOffset)
            imgQuantized(i,j) = floor(lvlOffset*2);
        end
    end
end
figure;
imshow(imgQuantized,[]);