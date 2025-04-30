clc; clear; close all;

img = rgb2gray(imread('moon.jpg'));

%show image
subplot(3,3,1)
imshow(img);title('original image');
subplot(3,3,2)
imhist(img);title('image intensities');

%frequency of image thorugh fourier transform
fImg = fftshift(log(abs(fft2(img))));
subplot(3,3,3)
imshow(fImg, []);title('fourier transform of original image');

%low pass filter in space domain
lowPass = imgaussfilt(img, 10);
subplot(3,3,4)
imshow(lowPass);title('low-pass filtered image');
subplot(3,3,5)
imhist(lowPass);title('low-pass filtered image intensities');
fImgLow = fftshift(log(abs(fft2(lowPass))));
subplot(3,3,6)
imshow(fImgLow, []);title('fourier transform of low-pass filtered image');

%high pass filter in space domain
hHighPass = [1 0 -1; 1 0 -1; 1 0 -1];
highPass = imfilter(img,hHighPass);
subplot(3,3,7)
imshow(highPass);title('high-pass filtered image');
subplot(3,3,8)
imhist(highPass);title('high-pass filtered image intensities');
fImgHigh = fftshift(log(abs(fft2(highPass))));
subplot(3,3,9)
imshow(fImgHigh, []);title('fourier transform of high-pass filtered image');

