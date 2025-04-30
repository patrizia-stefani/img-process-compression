clear;close all;

%read image and show it
img = imread('landscape.tiff');
figure; imshow(img);
thresholdIndex = 1;

%convert rgb to yuv
imgYUV =  rgb2ycbcr(img);
[r,c,s] = size(imgYUV);

%subsample colors: human eye is more sensitive to intensity then chroma
imgYUV(:,:,2) = imresize(imgYUV(1:30:r,1:30:c,2),[r,c]); 
imgYUV(:,:,3) = imresize(imgYUV(1:30:r,1:30:c,3),[r,c]); 

%show the Y, Cb and Cr components
lb = {'Y', 'Cb', 'Cr'};
figure;
for channel = 1:3
    subplot(1,3,channel)
    Y_C = imgYUV;
    Y_C(:,:,setdiff(1:3,channel)) = intmax(class(Y_C))/2;
    imshow(ycbcr2rgb(Y_C))
    title([lb{channel} ' component'],'fontsize',16)
end

%divide data into 8x8 blocks and apply algorithm to each of them
y = zeros(r,c);
block = zeros(8,8);
threshold = 7;

while threshold > 1
    numberOfZeros = 0;
        for i = 1:8:r-7
            for j = 1:8:c-7
                for channel = 1:3
                     block = dct(double(imgYUV(i:i+7,j:j+7,channel)));
                     block(threshold:8,threshold:8) = 0;
                     y(i:i+7,j:j+7,channel) = idct(block);
                end
                numberOfZeros = numberOfZeros + (8- threshold)^2;
            end
        end
        %disp(numberOfZeros);
        y = uint8(y);
        %disp(size(y));

        resultImg = ycbcr2rgb(y);
       %figure; imshow(resultImg,[]);
       thresholdData(1,thresholdIndex) = abs(8- threshold);
       thresholdData(2, thresholdIndex) = numberOfZeros;
       thresholdIndex = thresholdIndex + 1;
      threshold = threshold - 1;

imageName = strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\jpegCompression\', num2str(thresholdIndex), '.jpg');
imwrite(resultImg, imageName);
end

figure;
plot(thresholdData(1,:), thresholdData(2,:)); title('Discarded values based on number rows/columns');
xlabel('Number of Rows/Columns');ylabel('Discarded Values');