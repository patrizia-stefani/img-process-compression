clc; clear; close all;

img = rgb2gray(imread('moon.jpg'));

%show image
subplot(2,3,1);
imshow(img);title('original image');

%frequency of image thorugh fourier transform
fImgOrig = fft2(img);
fImg = fftshift(log(abs(fImgOrig)));
subplot(2,3,2);
imshow(fImg, []);title('fourier transform of original image');


[fImgR, fImgC] = size(fImgOrig);

%low pass filter in frequency domain
hLowPass = fspecial('gaussian', fImgC, 7);
HLowPass = fft2(fftshift(hLowPass));
subplot(2,3,3);
imshow(log(fftshift(abs(HLowPass))),[]);title('low-pass filter frequency');

%apply filter in frequency domain
fLowPass = HLowPass .* fImgOrig;
subplot(2,3,4);
imshow(log(fftshift(abs(fLowPass))),[]);title('low-pass filtered image frequency');

sLowPass = real(ifft2(fLowPass)); 
subplot(2,3,5);
imshow(sLowPass,[]);title('low-pass filtered image shown');

figure;
subplot(2,3,1);
imshow(img);title('original image');

%frequency of image thorugh fourier transform
fImgOrig = fft2(img);
fImg = fftshift(log(abs(fImgOrig)));
subplot(2,3,2);
imshow(fImg, []);title('fourier transform of original image');

%high pass filter in frequency domain
hHighPass = zeros(fImgR, fImgC);
hHighPass((fImgR/2)-1:(fImgR/2)+1, (fImgC/2)-1:(fImgC/2)+1) = [1 0 -1; 1 0 -1; 1 0 -1];

HHighPass = fft2(fftshift(hHighPass));

HHighPass(1,1000) = 0;
HHighPass(1000,1) = 0;
subplot(2,3,3);
imshow(HHighPass,[]);title('high-pass filter frequency');

%apply filter in frequency domain
fHighPass = HHighPass .* fImgOrig;
subplot(2,3,4);
imshow(log(fftshift(abs(fHighPass))),[]);title('high-pass filtered image frequency');

sHighPass = real(ifft2(fHighPass)); 
subplot(2,3,5);
imshow(sHighPass,[]);title('high-pass filtered image shown');