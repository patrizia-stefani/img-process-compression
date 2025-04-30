%img = rgb2gray(imread('input.png'));
%for images = 2:201 num2str(images)
%input = strcat('C:\Users\patri\Documents\UNI\year_3\image_compression\Scripts\svdCompression\2', '.jpg');
input = ''
img = rgb2gray(imread(input));
[r,c] = size(img);

%find number of pixels which have specific intensity
[numPixel, binLocations] = imhist(img);
[sizePixels,~] = size(numPixel);

%remove all zero values
for i = 1:sizePixels
    if(numPixel(i,1) == 0)
        binLocations(i,1) = 0;
    end
end

numPixel = numPixel(numPixel ~= 0);
binLocations = binLocations(binLocations ~= 0);
[sizePixels,~] = size(numPixel);

%find probability of each intensity
probabilities(1,:) = double(double(numPixel) ./ double(r*c));

%initialize node structure for huffman tree
node.intensity = 0.0;
node.probability = 0.0;
node.code = NaN;
node.parent = 0;
node.child1 = 0;
node.child2 = 0;
treeNodes = repmat(node,1,sizePixels);

%initialize tree in unsorted order
for i = 1:sizePixels-1
    node.intensity = binLocations(i,1);
    node.probability = probabilities(1,i);
    treeNodes(1,i) = node;
end

%sort tree and apply huffman algorithm
lastIndex = sizePixels;
sizeIndex = sizePixels*2-2;
sortedtreeNodes = repmat(node,1,sizeIndex);
position = 1;
minimum1 = 0;
parentIntensity = -1;

while length(treeNodes) > 1
    minProb1 = 1.1;
    minProb2 = 1.1;
    
        for i = 1:lastIndex
           if(treeNodes(1,i).probability < minProb1)
               minProb2 = minProb1;
               minimum2 = minimum1;
               minProb1 = treeNodes(1,i).probability;
               minimum1 = i;
           elseif(treeNodes(1,i).probability < minProb2 && treeNodes(1,i).probability ~= minProb1)
               minProb2 = treeNodes(1,i).probability;
               minimum2 = i;
           end
        end

        sortedtreeNodes(1,position) = treeNodes(1,minimum1);
        sortedtreeNodes(1,position).code = 0;
        sortedtreeNodes(1,position+1) = treeNodes(1,minimum2);
        sortedtreeNodes(1,position+1).code = 1;
        
        if(sortedtreeNodes(1,position).child1 ~= 0)
            sortedtreeNodes(1, sortedtreeNodes(1,position).child1).parent = position;
            sortedtreeNodes(1, sortedtreeNodes(1,position).child2).parent = position;
        end
        
        if(sortedtreeNodes(1,position+1).child1 ~= 0)
            sortedtreeNodes(1, sortedtreeNodes(1,position+1).child1).parent = position+1;
            sortedtreeNodes(1, sortedtreeNodes(1,position+1).child2).parent = position+1;
        end
  
        
        %parent node
        
        treeNodes(minimum1).intensity = parentIntensity;
        treeNodes(minimum1).probability = sortedtreeNodes(1,position).probability + sortedtreeNodes(1,position+1).probability;
        treeNodes(minimum1).child1 = position;
        treeNodes(minimum1).child2 = position+1;
        parentIntensity = parentIntensity - 1;
        
        treeNodes(minimum2) = [];
        minProb1 = 1.1;
        minProb2 = 1.1;
         
        lastIndex = lastIndex-1;
        position = position + 2;
end

sortedtreeNodes(1, position) = struct('intensity', -1, 'probability', sortedtreeNodes(1,position-1).probability + sortedtreeNodes(1,position-2).probability,'code', 0, 'parent', 0, 'child1', position-2, 'child2',position-1);
sortedtreeNodes(1,position-1).parent = position;
sortedtreeNodes(1,position-2).parent = position;

%get codes by traversing the tree
codes = traverseTree(sortedtreeNodes,position);

%write the image in code form
codeLengths = zeros(1, length(codes));
indexLengths = 1;
indexCodes = 1;
imageCodeArr = zeros(r,1);
imageCode = "";
[binLocationsSize, ~] = size(binLocations);
for i = 1:binLocationsSize
    fprintf("Intensity: %d -> %s\n", binLocations(i) ,codes(binLocations(i)));
end
for i = 1:r
   for j = 1:c
      imageCode = strcat(imageCode,codes(img(i,j))); 
      codeLengths(indexLengths) = length(codes(img(i,j)));
      indexLengths = indexLengths + 1;
   end
   
   %imageCodeArr(indexCodes, 1) = imageCode;
   indexCodes = indexCodes + 1;
   %imageCode = "";
end
disp(imageCode);
%end
