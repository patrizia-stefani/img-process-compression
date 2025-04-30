img = imread('img.jpg');
[rows, columns, channels] = size(img);
fprintf("Coloured image\nrows: %d  columns: %d  channels: %d\n\n",rows,columns,channels);

img = rgb2gray(img);
[rows, columns, channels] = size(img);
fprintf("Grey-scale image\nrows: %d  columns: %d  channels: %d\n\n",rows,columns,channels);


