img = rgb2gray(imread('img.jpg'));
[r,c] = size(img);
totPixels = r*c;
[numPixel, intensities] = imhist(img);
probs = numPixel/totPixels;

%map probabilities with intensities 
pixelsProb = containers.Map(intensities,probs);

%at every iteration find the two minimum probabilities 
%and eliminate them from map, building a tree formed by nodes
parIntens = -1;
treeIndex = 1;

while size(pixelsProb,1) > 1
    %left sibling
    [minimum, index] = min(cell2mat(values(pixelsProb)));
    keysVal = cell2mat(keys(pixelsProb));
    tree(treeIndex).node1.probability = minimum;
    tree(treeIndex).node1.intensity = keysVal(1,index);
    tree(treeIndex).node1.code = 0;
    tree(treeIndex).node1.parent = parIntens;
    remove(pixelsProb, tree(treeIndex).node1.intensity);
    
    %right sibling
    [minimum, index] = min(cell2mat(values(pixelsProb)));
    keysVal = cell2mat(keys(pixelsProb));
    tree(treeIndex).node2.probability = minimum;
    tree(treeIndex).node2.intensity = keysVal(1,index);
    tree(treeIndex).node2.code = 1;
    remove(pixelsProb, tree(treeIndex).node2.intensity);

    %sum of the two siblings inserted in the map
    pixelsProb(parIntens) = tree(treeIndex).node1.probability + tree(treeIndex).node2.probability;
    parIntens = parIntens-1;
    treeIndex = treeIndex + 1;
    
    %add it as parent
    tree(treeIndex)
end
    
