close all;
img = imread('dol.jpg');
%img = img(:,:,1);
m = 4;
[r, c, dim] = size(img);
sampled = img(1:m:r, 1:m:c);
[rS, cS] = size(sampled);
figure;image(img(:,:,:));
%figure;image(img(:,:,2));
%figure;image(img(:,:,3));
%figure, imshow(sampled), title(strcat('Pixels: ', string(rS), ' : ', string(cS)));
%figure, imshow(imresize(sampled, [r c])), title(strcat('Pixels: ', string(r), ' : ', string(c)));


%filter = [linspace(1/2, 1/2, 3);linspace(1/2, 1/2, 3);linspace(1/2, 1/2, 3)];
filter = [1 0 -1; 1 0 -1; 1 0 -1];
%filter = [cos(pi) -sin(pi); sin(pi) cos(pi)];
theta=deg2rad(35);
%filter = [cos(theta) -sin(theta) ; sin(theta) cos(theta)];

[filR, filC] = size(filter);

n = 1;
m = 1;

rowFiltered = 1;
colFiltered  = 1;

height = uint64((r - length(filter))/2);
width = uint64((c - length(filter))/2);
filteredImg = zeros(height, width);


iteratorBy3C = 1;
iteratorBy3R = 1;
counter = 0;

%{
while m < r - 2
    while n < c -2
        
        while iteratorBy3R <= filR
            while iteratorBy3C <= filC
                counter = counter + img(m + iteratorBy3R - 1, n + iteratorBy3C - 1)*filter(iteratorBy3R,iteratorBy3C);
                iteratorBy3C = iteratorBy3C + 1;
        
            end
            iteratorBy3C = 1;
            iteratorBy3R = iteratorBy3R + 1;
        end
        filteredImg(rowFiltered, colFiltered) = counter;
        counter = 0;
        colFiltered = colFiltered + 1;
        iteratorBy3R = 1;
        n = n + 1;
    end
    colFiltered = 1;
    n = 1;
    m = m + 1;
    rowFiltered = rowFiltered + 1;
end
%}


%{
for dim = 1:3
    for i = 1 : r - filR+1
        for j = 1 : c - filC + 1
            submatrix = double(img(i:i+filR-1, j:j+filC-1));
            product = submatrix .* filter;
            count = sum(submatrix .* filter, 'all');
            filteredImg(i, j) = count;
        end
    end
end
%}
imgF = abs(fftshift(fft(img)));
fltrF = abs(fft(filter));
[imgFR, imgFC] = size(imgF);
[fltrFR, fltrFC] = size(fltrF);
for i = 1: r - fltrFR + 1
    for j = c - fltrFC + 1
        submatrix = double(img(i : i+fltrFR-1, j : j+fltrFC-1));
        filteredImg(i,j) = submatrix .* fltrF;
    end
end

filteredImg = ifft(filteredImg);
figure; image(filteredImg);
figure; image(imfilter(img, filter));
