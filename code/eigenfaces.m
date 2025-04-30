%set pattern
myFolder = '.\face';
filePattern = fullfile(myFolder, '*.jpg');
theFiles = dir(filePattern);

%initialize array to store the images
imageArray = cell(length(theFiles),1);

%for each image put it in the imageArray
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    img = rgb2gray(imresize(imread(fullFileName),[250,250]));
    
    %store the images instead of n x n, in a vector n^2
    [r,c] = size(img);
    prevRows = 1;
    imgVector = zeros(r*c,1);
    for i = 1:c
        imgVector(prevRows:prevRows+r-1,1) = img(:,i);
        prevRows = prevRows+r-1;
    end
    imageArray{k} = imgVector;
end

%imageArrayMean = cell(length(theFiles),1);
[r,~] = size(imageArray{1});
[m,~] = size(imageArray);
faces = zeros(r, m);
for i = 1:length(imageArray)
    meanOfImg = mean(imageArray{i});
    faces(:,i) = imageArray{i} - meanOfImg;
end

covariance = faces' * faces;



