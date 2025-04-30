close all;
for i = 1:99
    img = dir(strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\waveletCompression\',num2str(i),'.jpg'));
    sizesArr(i) = img.bytes;
end
figure; plot(1:99, sizesArr); xlabel('Decrease quality iteration');
ylabel('File size (Bytes)');
figure;
subplot(1,3,1); title('Image size after compression'); plot(1:99,sizesArr); title('Wavelets');
xlabel('Decrease quality iteration');
ylabel('File size (Bytes)');

for i = 2:7
    img = dir(strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\jpegCompression\',num2str(i),'.jpg'));
    sizesArr1(i-1) = img.bytes;
end
subplot(1,3,2); plot(1:6,sizesArr1); title('JPEG');
xlabel('Decrease quality iteration');
ylabel('File size (Bytes)');
for i = 2:201
    img = dir(strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\svdCompression\',num2str(i),'.jpg'));
    sizesArr2(i-1) = img.bytes;
end
subplot(1,3,3); plot(1:200,sizesArr2); title('SVD');
xlabel('Decrease quality iteration');
ylabel('File size (Bytes)');