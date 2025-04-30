clear;
close all;

%read image
img = imread('dol.jpg');
whos img;
%figure;
%imshow(img);
plotDataIndex = 1;

%separate the three different channels for different colours
imgCh1 = im2double(img(:,:,1));
imgCh2 = im2double(img(:,:,2));
imgCh3 = im2double(img(:,:,3));

[U1,S1,V1]  = svd(imgCh1);
[U2,S2,V2]  = svd(imgCh2);
[U3,S3,V3]  = svd(imgCh3);

%figure;
completeFigure(:,:,1) = U1*S1*V1';
completeFigure(:,:,2) = U2*S2*V2';
completeFigure(:,:,3) = U3*S3*V3';
%imshow(completeFigure,[]);
threshold = 0;
initial = S1;

[r,c] = size(S1);


while threshold < 100
%fprintf("threshold: %d\n", threshold);
S1(S1 < threshold) = 0;
i = 1;

while S1(i,i) ~= 0 && i < min(size(S1))
    i = i+1;
end

dropped = min(size(initial)) - i;
%fprintf("Amount of dropped singular values: %d\n", dropped);
U1 = U1(:,1:i);
S1 = S1(1:i,1:i);
V1 = V1(:,1:i);
svdImg1 = U1*S1*V1';

%figure;
%imshow(svdImg1,[]);

S2(S2 < threshold) = 0;
i = 1;
while S1(i,i) ~= 0 && i < min(size(S1))
    i = i+1;
end
U2 = U2(:,1:i);
S2 = S2(1:i,1:i);
V2 = V2(:,1:i);
svdImg2 = U2*S2*V2';

%figure;
%imshow(svdImg2,[]);

S3(S3 < threshold) = 0;
i = 1;
while S1(i,i) ~= 0 && i < min(size(S1))
    i = i+1;
end
U3 = U3(:,1:i);
S3 = S3(1:i,1:i);
V3 = V3(:,1:i);
svdImg3 = U3*S3*V3';

%figure;
%imshow(svdImg3,[]);

totImg(:,:,1) = svdImg1;
totImg(:,:,2) = svdImg2;
totImg(:,:,3) = svdImg3;

%figure;
%imshow(totImg,[]);
%whos totImg;
plotData(1, plotDataIndex) = threshold;
plotData(2, plotDataIndex) = dropped;
plotDataIndex = plotDataIndex + 1;
imageName = strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\svdCompression\', num2str(plotDataIndex), '.jpg');
imwrite(totImg, imageName);
threshold = threshold + 0.5;
end

figure;
plot(plotData(1,:), plotData(2,:)); title('Amount of dropped values based on threshold');
xlabel('Threshold');
ylabel('Dropped');