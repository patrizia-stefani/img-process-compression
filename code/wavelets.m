%wavelet decomposition
clear;close all;
img = rgb2gray(imread('example.jpg'));
imshow(img,[]);
[C,S] = wavedec2(img, 2, 'bior3.7');

%approximations
cA2 = appcoef2(C,S,'bior3.7',2);
cA1 = appcoef2(C, S, 'bior3.7', 1);

%details
cH2 = detcoef2('h', C, S, 2);
cD2 = detcoef2('d', C, S, 2);
cV2 = detcoef2('v', C, S, 2);

cH1 = detcoef2('h', C, S, 1);
cD1 = detcoef2('d', C, S, 1);
cV1 = detcoef2('v', C, S, 1);

figure;
colormap(gray);
subplot(4,2,1); image(cA2);
subplot(4,2,2); image(cH2);
subplot(4,2,3); image(cD2);
subplot(4,2,4); image(cV2);
subplot(4,2,5); image(cA1);
subplot(4,2,6); image(cH1);
subplot(4,2,7); image(cD1);
subplot(4,2,8); image(cV1);

threshold = 50;
%zero out based on threshold (details, high frequency components)
cH1(abs(cH1) < threshold) = 0;
cD1(abs(cD1) < threshold) = 0;
cV1(abs(cV1) < threshold) = 0;

H2 = upcoef2('h', cH1, 'bior3.7', 2);
V2 = upcoef2('v', cV1, 'bior3.7', 2);
D2 = upcoef2('d', cD1, 'bior3.7', 2);

figure;
colormap(gray);
subplot(4,2,1); image(cA2);
subplot(4,2,2); image(cH2);
subplot(4,2,3); image(cD2);
subplot(4,2,4); image(cV2);
subplot(4,2,5); image(cA1);
subplot(4,2,6); image(cH1);
subplot(4,2,7); image(cD1);
subplot(4,2,8); image(cV1);

%compress the image with threshold from 1 to 100
thr = 1;
n = 5;                   
w = 'sym8';              
[c,l] = wavedec2(img,n,w); 
opt = 'gbl';
sorh = 'h'; 
keepapp = 1;
while thr < 100 
    [xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);
    %figure
    %image(xd); colormap(gray);
    title(strcat('Compressed Image - Global Threshold = ', num2str(thr)));
    
    %store data to be plotted after the while loop
    %compression ratio
    plotData(thr) = perf0;
    
    %store the compressed images
    imageName = strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\waveletCompression\', num2str(thr), '.jpg');
    imwrite(xd,gray, imageName);
    thr = thr + 1;
end
figure;
plot(1:99, plotData); xlabel('Quality decrease iteration'); ylabel('Threshold Value');